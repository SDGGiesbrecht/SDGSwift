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
    ///
    /// - Throws: Either an `Xcode.Error` or an `ExternalProcess.Error`.
    public func scheme() throws -> String {
        return try Xcode.scheme(for: self)
    }

    // MARK: - Workflow

    /// Generates or refreshes the package’s Xcode project.
    ///
    /// - Parameters:
    ///     - reportProgress: Optional. A closure to execute for each line of output.
    ///     - progressReport: A line of output.
    @discardableResult public func generateXcodeProject(reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress) throws -> Result<String, SwiftCompiler.Error> {
        return SwiftCompiler.generateXcodeProject(for: self, reportProgress: reportProgress)
    }

    /// Builds the package.
    ///
    /// - Parameters:
    ///     - sdk: The SDK to build for.
    ///     - reportProgress: Optional. A closure to execute for each line of output.
    ///     - progressReport: A line of output.
    ///
    /// - Throws: Either an `Xcode.Error` or an `ExternalProcess.Error`.
    @discardableResult public func build(for sdk: Xcode.SDK, reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress) throws -> String {
        return try Xcode.build(self, for: sdk, reportProgress: reportProgress)
    }

    /// Tests the package.
    ///
    /// - Parameters:
    ///     - sdk: The SDK to run tests on.
    ///     - reportProgress: Optional. A closure to execute for each line of output.
    ///     - progressReport: A line of output.
    ///
    /// - Throws: Either an `Xcode.Error` or an `ExternalProcess.Error`.
    @discardableResult public func test(on sdk: Xcode.SDK, reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress) throws -> String {
        return try Xcode.test(self, on: sdk, reportProgress: reportProgress)
    }

    /// Returns the code coverage report for the package.
    ///
    /// - Parameters:
    ///     - sdk: The SDK to run tests on.
    ///     - ignoreCoveredRegions: Optional. Set to `true` if only coverage gaps are significant. When `true`, covered regions will be left out of the report, resulting in faster parsing.
    ///     - reportProgress: Optional. A closure to execute for each line of output.
    ///     - progressReport: A line of output.
    ///
    /// - Throws: Either an `Xcode.Error` or an `ExternalProcess.Error`.
    ///
    /// - Returns: The report, or `nil` if there is no code coverage information.
    public func codeCoverageReport(on sdk: Xcode.SDK, ignoreCoveredRegions: Bool = false, reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress) throws -> TestCoverageReport? {
        return try Xcode.codeCoverageReport(for: self, on: sdk, ignoreCoveredRegions: ignoreCoveredRegions, reportProgress: reportProgress)
    }

    /// The derived data directory for the package.
    ///
    /// - Parameters:
    ///     - sdk: The SDK.
    ///
    /// - Throws: Either an `Xcode.Error` or an `ExternalProcess.Error`.
    public func derivedData(for sdk: Xcode.SDK) throws -> URL {
        return try Xcode.derivedData(for: self, on: sdk)
    }
}
