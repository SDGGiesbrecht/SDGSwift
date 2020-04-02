/*
 SwiftCompiler.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow
import SDGLogic
import SDGMathematics
import SDGCollections
import SDGText
import SDGExternalProcess
import SDGVersioning

/// The Swift compiler.
public enum SwiftCompiler: VersionedExternalProcess {

  // MARK: - Static Properties

  public static let _currentMajor = Version(5)
  private static var currentMajor: Version {
    return _currentMajor
  }

  // MARK: - Usage

  public static func _ignoreProgress(_ output: String) {}

  /// Builds the package.
  ///
  /// - Parameters:
  ///     - package: The package to build.
  ///     - releaseConfiguration: Optional. Whether or not to build in the release configuration. Defaults to `false`, i.e. the default debug configuration.
  ///     - reportProgress: Optional. A closure to execute for each line of the compiler’s output.
  ///     - progressReport: A line of output.
  @discardableResult public static func build(
    _ package: PackageRepository,
    releaseConfiguration: Bool = false,
    reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress
  ) -> Result<String, VersionedExternalProcessExecutionError<SwiftCompiler>> {
    let earliest = Version(3, 0, 0)
    var arguments = ["build"]
    if releaseConfiguration {
      arguments += ["\u{2D}\u{2D}configuration", "release"]
    }
    return runCustomSubcommand(
      arguments,
      in: package.location,
      versionConstraints: earliest..<currentMajor.compatibleVersions.upperBound,
      reportProgress: reportProgress
    )
  }

  public static func _warningBelongsToDependency(_ line: String.UnicodeScalarView.SubSequence)
    -> Bool
  {
    if let possiblePath = line.prefix(upTo: ":".scalars)?.contents,
      possiblePath.contains("/.build/".scalars)
    {
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
    let earliest = Version(4, 0, 0)
    var arguments = [
      "build",
      "\u{2D}\u{2D}show\u{2D}bin\u{2D}path",
    ]
    if releaseConfiguration {
      arguments += ["\u{2D}\u{2D}configuration", "release"]
    }
    return runCustomSubcommand(
      arguments,
      in: package.location,
      versionConstraints: earliest..<currentMajor.compatibleVersions.upperBound,
      reportProgress: reportProgress
    ).map { URL(fileURLWithPath: $0) }
  }

  /// Runs a target in place.
  ///
  /// - Parameters:
  ///     - target: The target to run.
  ///     - package: The package containing the target to run.
  ///     - arguments: The arguments to supply to the target.
  ///     - environment: Optional. A different set of environment variables.
  ///     - releaseConfiguration: Optional. Whether or not to build in the release configuration. Defaults to `false`, i.e. the default debug configuration.
  ///     - reportProgress: Optional. A closure to execute for each line of the compiler’s output.
  ///     - progressReport: A line of output.
  @discardableResult public static func run(
    _ target: String,
    from package: PackageRepository,
    arguments: [String] = [],
    environment: [String: String]? = nil,
    releaseConfiguration: Bool = false,
    reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress
  ) -> Result<String, VersionedExternalProcessExecutionError<SwiftCompiler>> {
    let earliest = Version(4, 0, 0)
    var subcommandArguments = ["run"]
    if releaseConfiguration {
      subcommandArguments += ["\u{2D}\u{2D}configuration", "release"]
    }
    subcommandArguments.append(target)
    subcommandArguments.append(contentsOf: arguments)
    return runCustomSubcommand(
      subcommandArguments,
      in: package.location,
      with: environment,
      versionConstraints: earliest..<currentMajor.compatibleVersions.upperBound,
      reportProgress: reportProgress
    )
  }

  /// Tests the package.
  ///
  /// - Parameters:
  ///     - package: The package to test.
  ///     - reportProgress: Optional. A closure to execute for each line of the compiler’s output.
  ///     - progressReport: A line of output.
  @discardableResult public static func test(
    _ package: PackageRepository,
    reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress
  ) -> Result<String, VersionedExternalProcessExecutionError<SwiftCompiler>> {

    var environment = ProcessInfo.processInfo.environment
    environment["XCTestConfigurationFilePath"] = nil  // Causes issues when run from within Xcode.

    var earliest = Version(3, 0, 0)
    var arguments = [
      "test"
    ]

    let codeCoverageAvailable = Version(5, 0, 0)
    if let resolved = version(
      forConstraints: earliest..<currentMajor.compatibleVersions.upperBound
    ),
      resolved ≥ codeCoverageAvailable
    {
      earliest.increase(to: codeCoverageAvailable)
      arguments.append("\u{2D}\u{2D}enable\u{2D}code\u{2D}coverage")
    }
    let testDiscoveryAvailable = Version(5, 1, 0)
    if let resolved = version(
      forConstraints: earliest..<currentMajor.compatibleVersions.upperBound
    ),
      resolved ≥ testDiscoveryAvailable
    {
      earliest.increase(to: testDiscoveryAvailable)
      arguments.append("\u{2D}\u{2D}enable\u{2D}test\u{2D}discovery")
    }

    return runCustomSubcommand(
      arguments,
      in: package.location,
      with: environment,
      versionConstraints: earliest..<currentMajor.compatibleVersions.upperBound,
      reportProgress: reportProgress
    )
  }

  /// Resolves the package, fetching its dependencies.
  ///
  /// - Parameters:
  ///     - package: The package to resolve.
  ///     - reportProgress: Optional. A closure to execute for each line of the compiler’s output.
  ///     - progressReport: A line of output.
  @discardableResult public static func resolve(
    _ package: PackageRepository,
    reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress
  ) -> Result<String, VersionedExternalProcessExecutionError<SwiftCompiler>> {
    let earliest = Version(4, 0, 0)
    return runCustomSubcommand(
      ["package", "resolve"],
      in: package.location,
      versionConstraints: earliest..<currentMajor.compatibleVersions.upperBound,
      reportProgress: reportProgress
    )
  }

  // MARK: - VersionedExternalProcess

  public static let englishName: StrictString = "Swift"
  public static var deutscherNameInDativ: StrictString = "Swift"

  public static let commandName: String = "swift"

  public static let searchCommands: [[String]] = [
    ["which", "swift"],  // Swift
    ["xcrun", "\u{2D}\u{2D}find", "swift"],  // Xcode
    ["swiftenv", "which", "swift"],  // Swift Version Manager
  ]

  public static var versionQuery: [String] = ["\u{2D}\u{2D}version"]
}
