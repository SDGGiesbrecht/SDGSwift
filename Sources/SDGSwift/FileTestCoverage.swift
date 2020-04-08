/*
 FileTestCoverage.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(WASI)  // #workaround(workspace version 0.32.0, Web lacks Foundation.)
import Foundation
#endif

/// A test coverage report for a single file.
public struct FileTestCoverage {

  // MARK: - Initialization

  /// Creates a test coverage report for a single file.
  ///
  /// - Parameters:
  ///     - file: The URL of the corresponding file.
  ///     - regions: The regions of the file.
  public init(file: URL, regions: [CoverageRegion]) {
    self.file = file
    self.regions = regions
  }

  // MARK: - Properties

  /// The URL of the corresponding file.
  public let file: URL

  /// The regions of the file.
  public let regions: [CoverageRegion]
}
