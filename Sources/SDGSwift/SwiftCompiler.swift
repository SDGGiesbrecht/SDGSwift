/*
 SwiftCompiler.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow
import SDGLogic
import SDGCollections
import SDGText
import SDGExternalProcess
import SDGVersioning

/// The Swift compiler.
public enum SwiftCompiler : VersionedExternalProcess {

  // MARK: - Locating

  public static let _standardLibraryVersion = compatibleVersionRange.lowerBound

  // MARK: - Usage

  public static func _ignoreProgress(_ output: String) {}

  /// Builds the package.
  ///
  /// - Parameters:
  ///     - package: The package to build.
  ///     - releaseConfiguration: Optional. Whether or not to build in the release configuration. Defaults to `false`, i.e. the default debug configuration.
  ///     - staticallyLinkStandardLibrary: Optional. Whether or not to statically link the standard library. Defaults to `false`.
  ///     - reportProgress: Optional. A closure to execute for each line of the compiler’s output.
  ///     - progressReport: A line of output.
  @discardableResult public static func build(
    _ package: PackageRepository,
    releaseConfiguration: Bool = false,
    staticallyLinkStandardLibrary: Bool = false,
    reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress
  ) -> Result<String, VersionedExternalProcessExecutionError<SwiftCompiler>> {
    var arguments = ["build"]
    if releaseConfiguration {
      arguments += ["\u{2D}\u{2D}configuration", "release"]
    }
    if staticallyLinkStandardLibrary {
      arguments += ["\u{2D}\u{2D}static\u{2D}swift\u{2D}stdlib"]
    }
    return runCustomSubcommand(arguments, in: package.location, reportProgress: reportProgress)
  }

  public static func _warningBelongsToDependency(_ line: String.UnicodeScalarView.SubSequence) -> Bool {
    if let possiblePath = line.prefix(upTo: ":".scalars)?.contents,
      possiblePath.contains("/.build/".scalars) {
      return true
    }
    return false
  }
  /// Returns whether the log contains warnings.
  ///
  /// - Parameters:
  ///     - log: The output log to be checked.
  public static func warningsOccurred(during log: String) -> Bool {
    for line in log.lines.lazy.map({ $0.line }) where line.contains("warning:".scalars) {
      if SwiftCompiler._warningBelongsToDependency(line) {
        continue
      }
      return true
    }
    return false
  }

  /// The directory to which the products are built.
  ///
  /// - Parameters:
  ///     - package: The package to build.
  ///     - releaseConfiguration: Optional. Whether or not to build in the release configuration. Defaults to `false`, i.e. the default debug configuration.
  ///     - reportProgress: Optional. A closure to execute for each line of the compiler’s output.
  ///     - progressReport: A line of output.
  public static func productsDirectory(
    for package: PackageRepository,
    releaseConfiguration: Bool = false,
    reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress
  ) -> Result<URL, VersionedExternalProcessExecutionError<SwiftCompiler>> {
    var arguments = [
      "build",
      "\u{2D}\u{2D}show\u{2D}bin\u{2D}path"
    ]
    if releaseConfiguration {
      arguments += ["\u{2D}\u{2D}configuration", "release"]
    }
    return runCustomSubcommand(
      arguments,
      in: package.location,
      reportProgress: reportProgress).map { URL(fileURLWithPath: $0) }
  }

  /// Tests the package.
  ///
  /// - Parameters:
  ///     - package: The package to test.
  ///     - reportProgress: Optional. A closure to execute for each line of the compiler’s output.
  ///     - progressReport: A line of output.
  @discardableResult public static func test(_ package: PackageRepository, reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress) -> Result<String, VersionedExternalProcessExecutionError<SwiftCompiler>> {

    var environment = ProcessInfo.processInfo.environment
    environment["XCTestConfigurationFilePath"] = nil // Causes issues when run from within Xcode.

    return runCustomSubcommand([
      "test",
      "\u{2D}\u{2D}enable\u{2D}code\u{2D}coverage",
      "\u{2D}\u{2D}enable\u{2D}test\u{2D}discovery"
    ], in: package.location, with: environment, reportProgress: reportProgress)
  }

  /// Resolves the package, fetching its dependencies.
  ///
  /// - Parameters:
  ///     - package: The package to resolve.
  ///     - reportProgress: Optional. A closure to execute for each line of the compiler’s output.
  ///     - progressReport: A line of output.
  @discardableResult public static func resolve(_ package: PackageRepository, reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress) -> Result<String, VersionedExternalProcessExecutionError<SwiftCompiler>> {
    return runCustomSubcommand(["package", "resolve"], in: package.location, reportProgress: reportProgress)
  }

  /// Regenerates the package’s test lists.
  ///
  /// - Parameters:
  ///     - package: The package for which to regenerate the test list.
  ///     - reportProgress: Optional. A closure to execute for each line of the compiler’s output.
  ///     - progressReport: A line of output.
  @discardableResult public static func regenerateTestLists(for package: PackageRepository, reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress) -> Result<String, VersionedExternalProcessExecutionError<SwiftCompiler>> {
    return runCustomSubcommand(["test", "\u{2D}\u{2D}generate\u{2D}linuxmain"], in: package.location, reportProgress: reportProgress)
  }

  // MARK: - VersionedExternalProcess

  public static let englishName: StrictString = "Swift"
  public static var deutscherNameInDativ: StrictString = "Swift"

  public static let commandName: String = "swift"
  #warning("Remove this.")
  public static let compatibleVersionRange = Version(5, 1, 1) /* Travis CI */ ... Version(5, 1, 2) /* Current */

  public static let searchCommands: [[String]] = [
    ["which", "swift"], // Swift
    ["xcrun", "\u{2D}\u{2D}find", "swift"], // Xcode
    ["swiftenv", "which", "swift"] // Swift Version Manager
  ]

  public static var versionQuery: [String] = ["\u{2D}\u{2D}version"]
}
