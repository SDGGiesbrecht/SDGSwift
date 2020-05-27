/*
 PackageRepository.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(WASI)  // #workaround(Swift 5.2.4, Web lacks Foundation.)
  import Foundation

  import SDGSwift

  extension PackageRepository {

    // MARK: - Properties

    /// Returns the package’s Xcode project.
    public func xcodeProject() throws -> URL? {
      let files = try FileManager.default.contentsOfDirectory(
        at: location,
        includingPropertiesForKeys: [],
        options: []
      )

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
    @discardableResult public func generateXcodeProject(
      reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress
    ) -> Result<String, VersionedExternalProcessExecutionError<SwiftCompiler>> {
      return SwiftCompiler.generateXcodeProject(for: self, reportProgress: reportProgress)
    }

    /// Builds the package.
    ///
    /// - Parameters:
    ///     - sdk: The SDK to build for.
    ///     - reportProgress: Optional. A closure to execute for each line of output.
    ///     - progressReport: A line of output.
    @discardableResult public func build(
      for sdk: Xcode.SDK,
      reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress
    ) -> Result<String, Xcode.SchemeError> {
      return Xcode.build(self, for: sdk, reportProgress: reportProgress)
    }

    /// Tests the package.
    ///
    /// - Parameters:
    ///     - sdk: The SDK to run tests on.
    ///     - reportProgress: Optional. A closure to execute for each line of output.
    ///     - progressReport: A line of output.
    @discardableResult public func test(
      on sdk: Xcode.SDK,
      reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress
    ) -> Result<String, Xcode.SchemeError> {
      return Xcode.test(self, on: sdk, reportProgress: reportProgress)
    }

    // #workaround(Swift 5.2.4, SwiftPM won’t compile.)
    #if !(os(Windows) || os(Android))
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
        reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress
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
#endif
