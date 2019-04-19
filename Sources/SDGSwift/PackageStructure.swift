/*
 PackageStructure.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow
import SDGLogic
import SDGCollections
import SDGText

import SDGExternalProcess

/// A remote Swift package.
public struct Package : TransparentWrapper {

    // MARK: - Initialization

    /// Creates an instance describing the package at the specified url.
    ///
    /// - Parameters:
    ///     - url: The package URL.
    public init(url: URL) {
        self.url = url
    }

    // MARK: - Properties

    /// The URL of the package.
    public let url: URL

    /// Retrieves the list of available versions.
    ///
    /// - Throws: Either a `Git.Error` or an `ExternalProcess.Error`.
    public func versions() throws -> Set<Version> {
        return try Git.versions(of: self)
    }

    /// Retrieves the latest commit identifier in the master branch of the package.
    ///
    /// - Throws: Either a `Git.Error` or an `ExternalProcess.Error`.
    public func latestCommitIdentifier() throws -> String {
        return try Git.latestCommitIdentifier(in: self)
    }

    // MARK: - Workflow

    /// Retrieves the package, builds it, and copies its products to the specified destination.
    ///
    /// - Parameters:
    ///     - build: The version to build.
    ///     - destination: The directory to put the products in.
    ///     - reportProgress: Optional. A closure to execute for each line of the compiler’s output.
    ///     - progressReport: A line of output.
    ///
    /// - Throws: A `Git.Error`, a `SwiftCompiler.Error`, or an `ExternalProcess.Error`.
    public func build(_ build: Build, to destination: URL, reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress) throws {
        try FileManager.default.withTemporaryDirectory(appropriateFor: destination) { temporaryDirectory in
            let temporaryCloneLocation = temporaryDirectory.appendingPathComponent(url.lastPathComponent)

            reportProgress("")

            let temporaryRepository = try PackageRepository(cloning: self, to: temporaryCloneLocation, at: build, shallow: true, reportProgress: reportProgress)

            reportProgress("")

            try temporaryRepository.build(releaseConfiguration: true, reportProgress: reportProgress)
            let products = temporaryRepository.releaseProductsDirectory()
            #if os(macOS)
            // #workaround(Swift 5.0.1, Swift links with absolute paths on macOS.)
            for dynamicLibrary in try FileManager.default.contentsOfDirectory(at: products, includingPropertiesForKeys: nil, options: []) where dynamicLibrary.pathExtension == "dylib" {
                for component in try FileManager.default.contentsOfDirectory(at: products, includingPropertiesForKeys: nil, options: []) {
                    _ = try? Shell.default.run(command: [
                        "install_name_tool",
                        "\u{2D}change", Shell.quote(dynamicLibrary.path), Shell.quote("@executable_path/" + dynamicLibrary.lastPathComponent), Shell.quote(component.path)
                        ])
                }
            }
            #endif

            let intermediateDirectory = temporaryDirectory.appendingPathComponent(UUID().uuidString)
            for component in try FileManager.default.contentsOfDirectory(at: products, includingPropertiesForKeys: nil, options: []) {
                let filename = component.lastPathComponent

                // #workaround(Can the product filters be moved upstream?)
                if filename ≠ "ModuleCache",
                    ¬filename.hasSuffix(".product"),
                    ¬filename.hasSuffix(".build"),
                    ¬filename.hasSuffix(".swiftdoc"),
                    ¬filename.hasSuffix(".swiftmodule") {

                    try FileManager.default.move(component, to: intermediateDirectory.appendingPathComponent(filename))
                }
            }

            try FileManager.default.move(intermediateDirectory, to: destination)
        }
    }

    private func developmentCache(for cache: URL) -> URL {
        return cache.appendingPathComponent("Development")
    }

    private func cacheDirectory(in cache: URL, for version: Build) throws -> URL {
        switch version {
        case .version(let specific):
            return cache.appendingPathComponent(specific.string())
        case .development:
            return developmentCache(for: cache).appendingPathComponent(try latestCommitIdentifier())
        }
    }

    /// Retrieves, builds and runs a command line tool defined by a Swift package.
    ///
    /// - Parameters:
    ///     - build: The version to build.
    ///     - executableNames: The name of the executable file. Multiple names can be supplied if the package defines localized products which are essentially the same executable.
    ///     - arguments: The arguments to send to the executable.
    ///     - cacheDirectory: Optional. A directory to store the executable in for future use. If the executable is already in the cache, the cached version will be used instead of fetching and rebuilding.
    ///     - reportProgress: Optional. A closure to execute for each line of the compiler’s output.
    ///     - progressReport: A line of output.
    ///
    /// - Throws: A `Git.Error`, a `SwiftCompiler.Error`, or an `ExternalProcess.Error`.
    @discardableResult public func execute(_ build: Build, of executableNames: Set<StrictString>, with arguments: [String], cacheDirectory: URL?, reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress) throws -> String {
        return try FileManager.default.withTemporaryDirectory(appropriateFor: nil) { temporaryDirectory in
            let cacheRoot = cacheDirectory ?? temporaryDirectory // @exempt(from: tests)
            let cache = try self.cacheDirectory(in: cacheRoot, for: build)

            if ¬FileManager.default.fileExists(atPath: cache.path) {

                switch build {
                case .development:
                    // Clean up older builds.
                    try? FileManager.default.removeItem(at: developmentCache(for: cacheRoot))
                case .version:
                    break
                }

                try self.build(build, to: cache, reportProgress: reportProgress)
            }

            for executable in try FileManager.default.contentsOfDirectory(at: cache, includingPropertiesForKeys: nil, options: []) where StrictString(executable.lastPathComponent) ∈ executableNames {

                #if os(Linux)
                // The move from the temporary directory to the cache may lose permissions.
                if ¬FileManager.default.isExecutableFile(atPath: executable.path) {
                    _ = try? Shell.default.run(command: ["chmod", "+x", executable.path])
                }
                #endif

                reportProgress("")
                reportProgress("$ " + executable.lastPathComponent + " " + arguments.joined(separator: " "))
                return try ExternalProcess(at: executable).run(arguments, reportProgress: reportProgress)
            }
            throw Package.Error.noSuchExecutable(requested: executableNames)
        }
    }

    // MARK: - TransparentWrapper

    public var wrappedInstance: Any {
        return url
    }
}
