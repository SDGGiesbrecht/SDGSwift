/*
 PackageStructure.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

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
    /// - Throws: A `Git.Error`, a `SwiftCompiler.Error`, or an `ExternalProcess.Error`.
    public func build(_ version: Build, to destination: URL, reportProgress: (String) -> Void = SwiftCompiler._ignoreProgress) throws {
        let temporaryCloneLocation = FileManager.default.url(in: .temporary, at: "Package Clones/" + url.lastPathComponent)

        reportProgress("")

        let temporaryRepository = try PackageRepository(cloning: self, to: temporaryCloneLocation, at: version, shallow: true, reportProgress: reportProgress)
        defer { try? FileManager.default.removeItem(at: temporaryCloneLocation) }

        reportProgress("")

        try temporaryRepository.build(releaseConfiguration: true, reportProgress: reportProgress)
        let products = temporaryRepository.releaseProductsDirectory()

        let intermediateDirectory = FileManager.default.url(in: .temporary, at: UUID().uuidString)
        defer { try? FileManager.default.removeItem(at: intermediateDirectory) }
        for component in try FileManager.default.contentsOfDirectory(at: products, includingPropertiesForKeys: nil, options: []) {
            let filename = component.lastPathComponent

            if filename ≠ "ModuleCache",
                ¬filename.hasSuffix(".build"),
                ¬filename.hasSuffix(".swiftdoc"),
                ¬filename.hasSuffix(".swiftmodule") {

                try FileManager.default.move(component, to: intermediateDirectory.appendingPathComponent(filename))
            }
        }
        try FileManager.default.move(intermediateDirectory, to: destination)
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
    /// - Throws: A `Git.Error`, a `SwiftCompiler.Error`, or an `ExternalProcess.Error`.
    @discardableResult public func execute(_ version: Build, of executableNames: Set<StrictString>, with arguments: [String], cacheDirectory: URL?, reportProgress: (String) -> Void = SwiftCompiler._ignoreProgress) throws -> String {
        let cacheRoot = cacheDirectory ?? FileManager.default.url(in: .temporary, at: "Cache")
        let cache = try self.cacheDirectory(in: cacheRoot, for: version)

        if ¬FileManager.default.fileExists(atPath: cache.path) {

            switch version {
            case .development:
                // Clean up older builds.
                try? FileManager.default.removeItem(at: developmentCache(for: cacheRoot))
            case .version:
                break
            }

            try build(version, to: cache, reportProgress: reportProgress)
        }

        for executable in try FileManager.default.contentsOfDirectory(at: cache, includingPropertiesForKeys: nil, options: []) where StrictString(executable.lastPathComponent) ∈ executableNames {

            reportProgress("")
            reportProgress("$ " + executable.lastPathComponent + " " + arguments.joined(separator: " "))
            return try ExternalProcess(at: executable).run(arguments, reportProgress: reportProgress)
        }
        throw Package.Error.noSuchExecutable(requested: executableNames)
    }

    // MARK: - TransparentWrapper

    // [_Inherit Documentation: SDGCornerstone.TransparentWrapper.wrapped_]
    /// The wrapped instance.
    public var wrappedInstance: Any {
        return url
    }
}
