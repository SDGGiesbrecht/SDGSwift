/*
 PackageRepository.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

/// A local repository containing a Swift package.
public struct PackageRepository {

    // MARK: - Initialization

    /// Creates an instance describing an existing package repository.
    public init(at location: URL) {
        self.location = location
    }

    // MARK: - Properties

    /// The location of the repository.
    public let location: URL

    // MARK: - Workflow

    /// Builds the package.
    ///
    /// - Parameters:
    ///     - reportProgress: A closure to execute for each line of the compiler’s output.
    ///
    /// - Throws: Either a `SwiftCompiler.Error` or an `ExternalProcess.Error`.
    @discardableResult public func build(releaseConfiguration: Bool = true, staticallyLinkStandardLibrary: Bool = true, reportProgress: (String) -> Void = { _ in }) throws -> String {
        return try SwiftCompiler.build(self, releaseConfiguration: releaseConfiguration, staticallyLinkStandardLibrary: staticallyLinkStandardLibrary, reportProgress: reportProgress)
    }

    /// Tests the package.
    ///
    /// - Parameters:
    ///     - reportProgress: A closure to execute for each line of the compiler’s output.
    ///
    /// - Throws: Either a `SwiftCompiler.Error` or an `ExternalProcess.Error`.
    @discardableResult public func test(reportProgress: (String) -> Void = { _ in }) throws -> String {
        return try SwiftCompiler.test(self, reportProgress: reportProgress)
    }

    /// Resolves the package, fetching its dependencies.
    ///
    /// - Parameters:
    ///     - reportProgress: A closure to execute for each line of the compiler’s output.
    ///
    /// - Throws: Either a `SwiftCompiler.Error` or an `ExternalProcess.Error`.
    @discardableResult public func resolve(reportProgress: (String) -> Void = { _ in }) throws -> String {
        return try SwiftCompiler.resolve(self, reportProgress: reportProgress)
    }
}
