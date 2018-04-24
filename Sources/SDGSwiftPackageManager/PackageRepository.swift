/*
 PackageRepository.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Basic
import PackageModel
import PackageLoading
import Workspace

import SDGSwift

extension PackageRepository {

    // MARK: - Initialization

    /// Creates a new package by initializing it at the specified URL.
    public init(initializingAt location: URL, type: InitPackage.PackageType) throws {
        self.init(at: location)
        let initializer = try InitPackage(destinationPath: AbsolutePath(location.path), packageType: type)
        try initializer.writePackageStructure()
    }

    // MARK: - Properties

    /// Returns the package manifest.
    ///
    /// - Throws: A `SwiftCompiler.Error`.
    public func manifest() throws -> Manifest {
        let loader = try SwiftCompiler.manifestLoader()
        return try loader.load(packagePath: AbsolutePath(location.path), baseURL: location.path, version: nil, manifestVersion: ToolsVersion.currentToolsVersion.manifestVersion)
    }

    /// Returns the package structure.
    ///
    /// - Throws: A `SwiftCompiler.Error`.
    public func package() throws -> Package {
        return try PackageBuilder(manifest: try manifest(), path: AbsolutePath(location.path), diagnostics: DiagnosticsEngine(), isRootPackage: true).construct()
    }
}
