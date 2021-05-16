/*
 PackageRepository.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGSwift

extension PackageRepository {

  // MARK: - Properties

  #if !PLATFORM_LACKS_FOUNDATION_PROCESS
    /// Returns the main package scheme.
    public func scheme() -> Result<String, Xcode.SchemeError> {
      return Xcode.scheme(for: self)
    }

    // MARK: - Workflow

    /// Builds the package.
    ///
    /// - Parameters:
    ///     - sdk: The SDK to build for.
    ///     - allArchitectures: Optional. Pass `true` to build for all architectures.
    ///     - reportProgress: Optional. A closure to execute for each line of output.
    ///     - progressReport: A line of output.
    @discardableResult public func build(
      for sdk: Xcode.SDK,
      allArchitectures: Bool = false,
      reportProgress: (_ progressReport: String) -> Void = { _ in }  // @exempt(from: tests)
    ) -> Result<String, Xcode.SchemeError> {
      return Xcode.build(
        self,
        for: sdk,
        allArchitectures: allArchitectures,
        reportProgress: reportProgress
      )
    }

    /// Tests the package.
    ///
    /// - Parameters:
    ///     - sdk: The SDK to run tests on.
    ///     - reportProgress: Optional. A closure to execute for each line of output.
    ///     - progressReport: A line of output.
    @discardableResult public func test(
      on sdk: Xcode.SDK,
      reportProgress: (_ progressReport: String) -> Void = { _ in }  // @exempt(from: tests)
    ) -> Result<String, Xcode.SchemeError> {
      return Xcode.test(self, on: sdk, reportProgress: reportProgress)
    }
  #endif

  #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
    /// Returns the code coverage report for the package.
    ///
    /// - Parameters:
    ///     - sdk: The SDK to run tests on.
    ///     - ignoreCoveredRegions: Optional. Set to `true` if only coverage gaps are significant. When `true`, covered regions will be left out of the report, resulting in faster parsing.
    ///     - reportProgress: Optional. A closure to execute for each line of output.
    ///     - progressReport: A line of output.
    ///
    /// - Returns: The report, or `nil` if there is no code coverage information.
    public func codeCoverageReport(
      on sdk: Xcode.SDK,
      ignoreCoveredRegions: Bool = false,
      reportProgress: (_ progressReport: String) -> Void = { _ in }  // @exempt(from: tests)
    ) -> Result<TestCoverageReport?, Xcode.CoverageReportingError> {
      return Xcode.codeCoverageReport(
        for: self,
        on: sdk,
        ignoreCoveredRegions: ignoreCoveredRegions,
        reportProgress: reportProgress
      )
    }
  #endif
}
