
/*
 Package.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGLogic

/// A remote Swift package.
public struct Package {

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
    public func build(_ version: Build, to destination: URL, reportProgress: (String) -> Void = { _ in }) throws {
        let temporaryCloneLocation = FileManager.default.url(in: .temporary, at: "Package Clones/" + url.lastPathComponent)

        reportProgress("")

        let temporaryRepository = try PackageRepository(cloning: self, to: temporaryCloneLocation, at: version, shallow: true, reportProgress: reportProgress)
        defer { try? FileManager.default.removeItem(at: temporaryCloneLocation) }

        reportProgress("")

        try temporaryRepository.build(reportProgress: reportProgress)
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
}
