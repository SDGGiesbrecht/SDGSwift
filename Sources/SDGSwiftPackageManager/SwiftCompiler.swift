/*
 SwiftCompiler.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGSwift

import PackageLoading
import Workspace

extension SwiftCompiler {

    // MARK: - Properties

    private static func hostDestination() throws -> Destination {
        return try Destination.hostDestination(AbsolutePath(location().deletingLastPathComponent().path))
    }
    internal static func hostToolchain() throws -> UserToolchain {
        return try UserToolchain(destination: hostDestination())
    }

    private static func manifestResourceProvider() throws -> ManifestResourceProvider {
        return try hostToolchain().manifestResources
    }

    internal static func manifestLoader() throws -> ManifestLoader {
        return ManifestLoader(manifestResources: try manifestResourceProvider())
    }

    // MARK: - Test Coverage

    private static func codeCoverageDirectory(for package: PackageRepository) throws -> URL {
        return try package.hostBuildParameters().codeCovPath.asURL
    }

    private static func codeCoverageDataFileName(for package: PackageRepository) throws -> String {
        return try package.manifest().name
    }

    private static func codeCoverageDataFile(for package: PackageRepository) throws -> URL {
        let directory = try codeCoverageDirectory(for: package)
        let fileName = try codeCoverageDataFileName(for: package).appending(".json")
        return directory.appendingPathComponent(fileName)
    }

    /// Returns the code coverage report for the package.
    ///
    /// - Parameters:
    ///     - package: The package to test.
    ///     - ignoreCoveredRegions: Optional. Set to `true` if only coverage gaps are significant. When `true`, covered regions will be left out of the report, resulting in faster parsing.
    ///     - reportProgress: Optional. A closure to execute for each line of output.
    ///     - progressReport: A line of output.
    ///
    /// - Throws: Errors from the package manager.
    ///
    /// - Returns: The report, or `nil` if there is no code coverage information.
    public static func codeCoverageReport(
        for package: PackageRepository,
        ignoreCoveredRegions: Bool = false,
        reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress) throws -> TestCoverageReport? {

        let coverageData = try codeCoverageDataFile(for: package)

        let ignoredDirectories = try package._directoriesIgnoredForTestCoverage()

        return nil
    }
}
