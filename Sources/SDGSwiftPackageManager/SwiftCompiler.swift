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
    private static func manifestResourceProvider() throws -> ManifestResourceProvider {
        return try UserToolchain(destination: hostDestination()).manifestResources
    }

    internal static func manifestLoader() throws -> ManifestLoader {
        return ManifestLoader(manifestResources: try manifestResourceProvider())
    }

    // MARK: - Test Coverage

    public static func _codeCoverageReport(for package: PackageRepository, ignoreCoveredRegions: Bool, reportProgress: (_ progressReport: String) -> Void) throws -> [URL] {
        return try package.directoriesIgnoredForTestCoverage()
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
        reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress) throws -> [URL] {
        return try _codeCoverageReport(
            for: package,
            ignoreCoveredRegions: ignoreCoveredRegions,
            reportProgress: reportProgress
        )
    }
}
