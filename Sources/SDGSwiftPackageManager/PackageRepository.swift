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
import PackageGraph
import Workspace

import SDGSwift
import SDGSwiftLocalizations

extension PackageRepository {

    // MARK: - Initialization

    /// Creates a new package by initializing it at the specified URL.
    ///
    /// - Throws: A `Git.Error`, an `ExternalProcess.Error`, or a package manager error.
    public init(initializingAt location: URL, type: InitPackage.PackageType) throws {
        self.init(at: location)
        let initializer = try InitPackage(destinationPath: AbsolutePath(location.path), packageType: type)
        try initializer.writePackageStructure()
        try Git.initialize(self)
        try commitChanges(description: UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom:
                return "Initialised."
            case .englishUnitedStates, .englishCanada:
                return "Initialized."
            }
        }).resolved())
    }

    // MARK: - Properties

    private var pinsFile: URL {
        return location.appendingPathComponent("Package.resolved")
    }

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
    public func package() throws -> PackageModel.Package {
        return try PackageBuilder(manifest: try manifest(), path: AbsolutePath(location.path), diagnostics: DiagnosticsEngine(), isRootPackage: true).construct()
    }

    /// Returns the package workspace.
    ///
    /// - Throws: A `SwiftCompiler.Error`.
    public func packageWorkspace() throws -> Workspace {
        return Workspace(
            dataPath: AbsolutePath(dataDirectory.path),
            editablesPath: AbsolutePath(editablesDirectory.path),
            pinsFile: AbsolutePath(pinsFile.path),
            manifestLoader: try SwiftCompiler.manifestLoader(),
            delegate: SwiftCompiler.workspaceDelegate()
        )
    }

    /// Returns the package graph.
    ///
    /// - Throws: A `SwiftCompiler.Error`.
    public func packageGraph() throws -> PackageGraph {
        return try packageWorkspace().loadPackageGraph(root: PackageGraphRootInput(packages: [AbsolutePath(location.path)]), diagnostics: DiagnosticsEngine())
    }

    /// Checks for uncommitted changes or additions.
    ///
    /// - Parameters:
    ///     - exclusionPatterns: Patterns describing paths or files to ignore.
    ///
    /// - Returns: The report provided by Git. (An empty string if there are no changes.)
    ///
    /// - Throws: Either a `Git.Error` or an `ExternalProcess.Error`.
    public func uncommittedChanges(excluding exclusionPatterns: [String] = []) throws -> String {
        return try Git.uncommittedChanges(in: self, excluding: exclusionPatterns)
    }

    // MARK: - Workflow

    /// Commits existing changes.
    ///
    /// - Throws: Either a `Git.Error` or an `ExternalProcess.Error`.
    public func commitChanges(description: StrictString) throws {
        try Git.commitChanges(in: self, description: description)
    }

    /// Tags a version.
    ///
    /// - Throws: Either a `Git.Error` or an `ExternalProcess.Error`.
    public func tag(version: SDGSwift.Version) throws {
        try Git.tag(version: version, in: self)
    }

    /// Returns the list of files ignored by source control.
    ///
    /// - Throws: Either a `Git.Error` or an `ExternalProcess.Error`.
    public func ignoredFiles() throws -> [URL] {
        return try Git.ignoredFiles(in: self)
    }
}
