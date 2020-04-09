/*
 TestCoverageReport.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.2.1, Web doesn’t have Foundation yet.)
#if !os(WASI)
  /// A test coverage report.
  public struct TestCoverageReport {

    // MARK: - Initialization

    /// Creates a test coverage report.
    ///
    /// - Parameters:
    ///     - files: The files in the package.
    public init(files: [FileTestCoverage]) {
      self.files = files
    }

    // MARK: - Properties

    /// The files in the package.
    public let files: [FileTestCoverage]
  }
#endif
