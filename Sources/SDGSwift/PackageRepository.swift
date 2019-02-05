/*
 PackageRepository.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow

/// A local repository containing a Swift package.
public struct PackageRepository : TransparentWrapper {

    // MARK: - Initialization

    /// Creates an instance describing an existing package repository.
    ///
    /// - Parameters:
    ///     - location: The local directory where the package repository already resides.
    public init(at location: URL) {
        self.location = location
    }

    /// Creates a local repository by cloning a remote package.
    ///
    /// - Parameters:
    ///     - package: The package to clone.
    ///     - location: The location to create the clone.
    ///     - build: Optional. A specific version to check out.
    ///     - shallow: Optional. Specify `true` to perform a shallow clone. Defaults to `false`.
    ///     - reportProgress: Optional. A closure to execute for each line of the compiler’s output.
    ///
    /// - Throws: Either a `Git.Error` or an `ExternalProcess.Error`.
    public init(cloning package: Package, to location: URL, at build: Build = .development, shallow: Bool = false, reportProgress: (String) -> Void = SwiftCompiler._ignoreProgress) throws {
        self.init(at: location)
        try Git.clone(package, to: location, at: build, shallow: shallow, reportProgress: reportProgress)
    }

    // MARK: - Properties

    /// The location of the repository.
    public let location: URL

    /// The directory where build data is stored.
    public var dataDirectory: URL {
        return location.appendingPathComponent(".build")
    }

    /// The directory where editable dependencies are stored.
    public var editablesDirectory: URL {
        return location.appendingPathComponent("Packages")
    }

    private static let releaseProductsDirectory = ".build/release"

    /// The directory to which release products are built.
    public func releaseProductsDirectory() -> URL {
        return location.appendingPathComponent(PackageRepository.releaseProductsDirectory).resolvingSymlinksInPath()
    }

    // MARK: - Workflow

    /// Builds the package.
    ///
    /// - Parameters:
    ///     - releaseConfiguration: Optional. Whether or not to build in the release configuration. Defaults to `false`, i.e. the default debug configuration.
    ///     - staticallyLinkStandardLibrary: Optional. Whether or not to statically link the standard library. Defaults to `false`.
    ///     - reportProgress: Optional. A closure to execute for each line of the compiler’s output.
    ///
    /// - Throws: Either a `SwiftCompiler.Error` or an `ExternalProcess.Error`.
    @discardableResult public func build(releaseConfiguration: Bool = false, staticallyLinkStandardLibrary: Bool = false, reportProgress: (String) -> Void = SwiftCompiler._ignoreProgress) throws -> String {
        return try SwiftCompiler.build(self, releaseConfiguration: releaseConfiguration, staticallyLinkStandardLibrary: staticallyLinkStandardLibrary, reportProgress: reportProgress)
    }

    /// Tests the package.
    ///
    /// - Parameters:
    ///     - reportProgress: A closure to execute for each line of the compiler’s output.
    ///
    /// - Throws: Either a `SwiftCompiler.Error` or an `ExternalProcess.Error`.
    @discardableResult public func test(reportProgress: (String) -> Void = SwiftCompiler._ignoreProgress) throws -> String { // @exempt(from: tests) Xcode hijacks this.
        return try SwiftCompiler.test(self, reportProgress: reportProgress)
    }

    /// Resolves the package, fetching its dependencies.
    ///
    /// - Parameters:
    ///     - reportProgress: A closure to execute for each line of the compiler’s output.
    ///
    /// - Throws: Either a `SwiftCompiler.Error` or an `ExternalProcess.Error`.
    @discardableResult public func resolve(reportProgress: (String) -> Void = SwiftCompiler._ignoreProgress) throws -> String {
        return try SwiftCompiler.resolve(self, reportProgress: reportProgress)
    }

    /// Regenerates the package’s test lists.
    ///
    /// - Parameters:
    ///     - reportProgress: A closure to execute for each line of the compiler’s output.
    ///
    /// - Throws: Either a `SwiftCompiler.Error` or an `ExternalProcess.Error`.
    @discardableResult public func regenerateTestLists(reportProgress: (String) -> Void = SwiftCompiler._ignoreProgress) throws -> String {
        return try SwiftCompiler.regenerateTestLists(for: self, reportProgress: reportProgress)
    }

    // MARK: - TransparentWrapper

    public var wrappedInstance: Any {
        return location.path
    }
}
