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

import SDGSwift
import SDGSwiftPackageManager

extension PackageRepository {

    // MARK: - Properties

    /// Returns the package’s Xcode project.
    public func xcodeProject() throws -> URL? {
        let files = try FileManager.default.contentsOfDirectory(at: location, includingPropertiesForKeys: [], options: [])

        for file in files where file.pathExtension == "xcodeproj" {
            return file
        }
        return nil
    }

    /// Returns the main package scheme.
    public func scheme() -> Result<String, Xcode.SchemeError> {
        return Xcode.scheme(for: self)
    }

    // MARK: - Workflow

    /// Generates or refreshes the package’s Xcode project.
    ///
    /// - Parameters:
    ///     - reportProgress: Optional. A closure to execute for each line of output.
    ///     - progressReport: A line of output.
    @discardableResult public func generateXcodeProject(reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress) -> Result<String, SwiftCompiler.Error> {
        return SwiftCompiler.generateXcodeProject(for: self, reportProgress: reportProgress)
    }

    /// Builds the package.
    ///
    /// - Parameters:
    ///     - sdk: The SDK to build for.
    ///     - derivedData: Optional. A specific place Xcode should use for derived data.
    ///     - reportProgress: Optional. A closure to execute for each line of output.
    ///     - progressReport: A line of output.
    @discardableResult public func build(
        for sdk: Xcode.SDK,
        derivedData: URL? = nil,
        reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress
        ) -> Result<String, Xcode.SchemeError> {
        return Xcode.build(self, for: sdk, derivedData: derivedData, reportProgress: reportProgress)
    }

    /// Tests the package.
    ///
    /// - Parameters:
    ///     - sdk: The SDK to run tests on.
    ///     - derivedData: Optional. A specific place Xcode should use for derived data.
    ///     - reportProgress: Optional. A closure to execute for each line of output.
    ///     - progressReport: A line of output.
    @discardableResult public func test(
        on sdk: Xcode.SDK,
        derivedData: URL? = nil,
        reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress
        ) -> Result<String, Xcode.SchemeError> {
        return Xcode.test(self, on: sdk, derivedData: derivedData, reportProgress: reportProgress)
    }

    /// Returns the code coverage report for the package.
    ///
    /// - Parameters:
    ///     - sdk: The SDK to run tests on.
    ///     - derivedData: A specific place Xcode should use for derived data.
    ///     - ignoreCoveredRegions: Optional. Set to `true` if only coverage gaps are significant. When `true`, covered regions will be left out of the report, resulting in faster parsing.
    ///     - reportProgress: Optional. A closure to execute for each line of output.
    ///     - progressReport: A line of output.
    ///
    /// - Returns: The report, or `nil` if there is no code coverage information.
    public func codeCoverageReport(
        on sdk: Xcode.SDK,
        derivedData: URL,
        ignoreCoveredRegions: Bool = false,
        reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress
        ) -> Result<TestCoverageReport?, Xcode.CoverageReportingError> {
        return Xcode.codeCoverageReport(
            for: self, on: sdk,
            derivedData: derivedData,
            ignoreCoveredRegions: ignoreCoveredRegions,
            reportProgress: reportProgress)
    }

    /// A stable directory that can be used for this package’s derived data.
    ///
    /// Xcode’s default directory is hard to predict in order to get results from it afterward. This directory is in the same parent directory as Xcode’s default, but it is deterministic.
    public var stableDerivedData: URL {
        return Xcode.stableDerivedData(for: self)
    }
}
