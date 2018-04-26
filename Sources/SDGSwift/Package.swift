
/*
 Package.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

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
}
