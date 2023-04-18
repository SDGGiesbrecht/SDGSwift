/*
 SwiftCompiler.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

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
import SDGLocalization
import SDGExternalProcess
import SDGVersioning

import SDGSwiftLocalizations

/// The Swift compiler.
public enum SwiftCompiler: VersionedExternalProcess {

  // MARK: - Static Properties

  private static let currentMajor = Version(5)

  #if !PLATFORM_LACKS_FOUNDATION_PROCESS
    // MARK: - Usage

    /// Builds the package.
    ///
    /// - Parameters:
    ///     - package: The package to build.
    ///     - releaseConfiguration: Optional. Whether or not to build in the release configuration. Defaults to `false`, i.e. the default debug configuration.
    ///     - reportProgress: Optional. A closure to execute for each line of the compiler’s output.
    @discardableResult public static func build(
      _ package: PackageRepository,
      releaseConfiguration: Bool = false,
      reportProgress: (_ progressReport: String) -> Void = { _ in }
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
  #endif

  public static func _warningBelongsToDependency(
    _ line: String.UnicodeScalarView.SubSequence
  ) -> Bool {
    if let possiblePath = line.prefix(
      upTo: ":".scalars.literal(for: String.ScalarView.SubSequence.self)
    )?.contents,
      possiblePath.contains("/.build/".scalars.literal(for: String.ScalarView.SubSequence.self))
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
    for line in log.lines.lazy.map({ $0.line })
    where line.contains("warning:".scalars.literal(for: String.ScalarView.SubSequence.self)) {
      if SwiftCompiler._warningBelongsToDependency(line) {
        continue
      }
      if line.hasPrefix("warning: unable to restore workspace state:".scalars.literal()) {
        // @exempt(from: tests) Difficult to trigger deliberately.
        // This warning is irrelevant; mismatched caches are cleared and the build continues.
        continue
      }
      return true
    }
    return false
  }

  #if !PLATFORM_LACKS_FOUNDATION_PROCESS
    /// The directory to which the products are built.
    ///
    /// - Parameters:
    ///     - package: The package to build.
    ///     - releaseConfiguration: Optional. Whether or not to build in the release configuration. Defaults to `false`, i.e. the default debug configuration.
    ///     - reportProgress: Optional. A closure to execute for each line of the compiler’s output.
    public static func productsDirectory(
      for package: PackageRepository,
      releaseConfiguration: Bool = false,
      reportProgress: (_ progressReport: String) -> Void = { _ in }
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
      ).map { URL(parsingOutput: $0) }
    }

    /// Runs a target in place.
    ///
    /// - Parameters:
    ///     - target: The target to run.
    ///     - package: The package containing the target to run.
    ///     - arguments: The arguments to supply to the target.
    ///     - environment: Optional. A different set of environment variables.
    ///     - releaseConfiguration: Optional. Whether or not to build in the release configuration. Defaults to `false`, i.e. the default debug configuration.
    ///     - ignoreStandardError: Optional. If `true`, standard error will be excluded from the output. The default is `false`.
    ///     - reportProgress: Optional. A closure to execute for each line of the compiler’s output.
    @discardableResult public static func run(
      _ target: String,
      from package: PackageRepository,
      arguments: [String] = [],
      environment: [String: String]? = nil,
      releaseConfiguration: Bool = false,
      ignoreStandardError: Bool = false,
      reportProgress: (_ progressReport: String) -> Void = { _ in }
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
        ignoreStandardError: ignoreStandardError,
        reportProgress: reportProgress
      )
    }

    /// Tests the package.
    ///
    /// - Parameters:
    ///     - package: The package to test.
    ///     - reportProgress: Optional. A closure to execute for each line of the compiler’s output.
    @discardableResult public static func test(
      _ package: PackageRepository,
      reportProgress: (_ progressReport: String) -> Void = { _ in }
    ) -> Result<String, VersionedExternalProcessExecutionError<SwiftCompiler>> {

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

        let testDiscoveryAutomatic = Version(5, 4, 0)
        if let resolved = version(
          forConstraints: earliest..<currentMajor.compatibleVersions.upperBound
        ),
          resolved ≥ testDiscoveryAutomatic
        {
          earliest.increase(to: testDiscoveryAutomatic)
        } else {
          arguments.append("\u{2D}\u{2D}enable\u{2D}test\u{2D}discovery")
        }
      }

      return runCustomSubcommand(
        arguments,
        in: package.location,
        versionConstraints: earliest..<currentMajor.compatibleVersions.upperBound,
        reportProgress: reportProgress
      )
    }

    /// Resolves the package, fetching its dependencies.
    ///
    /// - Parameters:
    ///     - package: The package to resolve.
    ///     - reportProgress: Optional. A closure to execute for each line of the compiler’s output.
    @discardableResult public static func resolve(
      _ package: PackageRepository,
      reportProgress: (_ progressReport: String) -> Void = { _ in }
    ) -> Result<String, VersionedExternalProcessExecutionError<SwiftCompiler>> {
      let earliest = Version(4, 0, 0)
      return runCustomSubcommand(
        ["package", "resolve"],
        in: package.location,
        versionConstraints: earliest..<currentMajor.compatibleVersions.upperBound,
        reportProgress: reportProgress
      )
    }

    /// Exports the symbol graphs and returns the URL of the directory containing the symbol graph files.
    ///
    /// - Parameters:
    ///     - package: The package whose symbol graph should be exported.
    ///     - reportProgress: Optional. A closure to execute for each line of the compiler’s output.
    public static func exportSymbolGraph(
      _ package: PackageRepository,
      reportProgress: (_ progressReport: String) -> Void = { _ in }  // @exempt(from: tests)
    ) -> Result<URL, VersionedExternalProcessExecutionError<SwiftCompiler>> {
      let earliest = Version(5, 3, 0)
      return runCustomSubcommand(
        ["package", "dump\u{2D}symbol\u{2D}graph"],
        in: package.location,
        versionConstraints: earliest..<currentMajor.compatibleVersions.upperBound,
        reportProgress: reportProgress
      ).map { output in
        let start =
          output.scalars.lastMatch(for: "Files written to ".scalars)?.range.upperBound
          ?? output.lines.indices.last?.samePosition(in: output.scalars)  // @exempt(from: tests)
          ?? output.scalars.startIndex
        let path = output.scalars[start...]
        return URL(fileURLWithPath: String(String.UnicodeScalarView(path)))
      }
    }

    // MARK: - Test Coverage

    private static func codeCoverageDataFile(
      for package: PackageRepository
    ) -> Swift.Result<Foundation.URL, VersionedExternalProcessExecutionError<Self>> {
      var earliest = Version(5, 2, 0)
      var arguments = ["test", "\u{2D}\u{2D}show\u{2D}codecov\u{2D}path"]

      let requiresEnablingCodeCoverage = Version(5, 8, 0)
      if let resolved = version(
        forConstraints: earliest..<currentMajor.compatibleVersions.upperBound
      ),
        resolved ≥ requiresEnablingCodeCoverage
      {
        earliest.increase(to: requiresEnablingCodeCoverage)
        arguments.append("\u{2D}\u{2D}enable\u{2D}code\u{2D}coverage")
      }

      return runCustomSubcommand(
        arguments,
        in: package.location,
        versionConstraints: earliest..<currentMajor.compatibleVersions.upperBound
      ).map { URL(parsingOutput: $0) }
    }

    /// Returns the code coverage report for the package.
    ///
    /// - Parameters:
    ///     - package: The package to test.
    ///     - ignoreCoveredRegions: Optional. Set to `true` if only coverage gaps are significant. When `true`, covered regions will be left out of the report, resulting in faster parsing.
    ///     - reportProgress: Optional. A closure to execute for each line of output.
    ///
    /// - Returns: The report, or `nil` if there is no code coverage information.
    public static func codeCoverageReport(
      for package: PackageRepository,
      ignoreCoveredRegions: Bool = false,
      reportProgress: (_ progressReport: String) -> Void = { _ in }
    ) -> Swift.Result<TestCoverageReport?, CoverageReportingError> {

      let coverageDataFile: Foundation.URL
      switch codeCoverageDataFile(for: package) {
      case .failure(let error):
        return .failure(.swiftError(error))
      case .success(let file):
        coverageDataFile = file
      }
      if ¬FileManager.default.fileExists(atPath: coverageDataFile.path) {
        return .success(nil)
      }

      let json: Any
      do {
        let coverageData = try Data(from: coverageDataFile)
        json = try JSONSerialization.jsonObject(with: coverageData)
      } catch {
        return .failure(.foundationError(error))
      }
      guard let coverageDataDictionary = json as? [String: Any],
        let data = coverageDataDictionary["data"] as? [Any]
      else {
        // @exempt(from: tests) Unreachable without mismatched Swift version.
        return .failure(.corruptTestCoverageReport)
      }

      let ignoredDirectories: [Foundation.URL] = package._directoriesIgnoredForTestCoverage()
      var fileReports: [FileTestCoverage] = []
      for entry in data {
        if let dictionary = entry as? [String: Any],
          let files = dictionary["files"] as? [Any]
        {
          for file in files {
            if let fileDictionary = file as? [String: Any],
              let fileName = fileDictionary["filename"] as? String
            {
              let url = URL(fileURLWithPath: fileName)

              if ¬ignoredDirectories.contains(where: { url.is(in: $0) }),
                url.pathExtension == "swift",
                url.lastPathComponent ≠ "LinuxMain.swift"
              {

                reportProgress(
                  String(
                    UserFacing<StrictString, InterfaceLocalization>({ localization in
                      let relativePath = url.path(relativeTo: package.location)
                      switch localization {
                      case .englishUnitedKingdom:
                        return "Parsing report for ‘\(relativePath)’..."
                      case .englishUnitedStates, .englishCanada:
                        return "Parsing report for “\(relativePath)”..."
                      case .deutschDeutschland:
                        return "Ergebnisse zu „\(relativePath)“ werden zerteilt ..."
                      }
                    }).resolved()
                  )
                )

                let source: String
                do {
                  source = try String(from: url)
                } catch {
                  return .failure(.foundationError(error))
                }
                var regions: [CoverageRegion<String.ScalarView.Index>] = []
                purgingAutoreleased {
                  if let segments = fileDictionary["segments"] as? [Any] {
                    for (index, segment) in segments.enumerated() {
                      if let segmentData = segment as? [Any],
                        segmentData.count ≥ 5,
                        let line = segmentData[0] as? Int,
                        let column = segmentData[1] as? Int,
                        let count = segmentData[2] as? Int,
                        let isExectuable = segmentData[3] as? Int,
                        isExectuable == 1
                      {

                        let start = source._toIndex(line: line, column: column)
                        let end: String.ScalarView.Index
                        let nextIndex = segments.index(after: index)
                        if nextIndex ≠ segments.endIndex,
                          let nextSegmentData = segments[nextIndex] as? [Any],
                          nextSegmentData.count ≥ 5,
                          let nextLine = nextSegmentData[0] as? Int,
                          let nextColumn = nextSegmentData[1] as? Int
                        {
                          end = source._toIndex(line: nextLine, column: nextColumn)
                        } else {
                          // @exempt(from: tests) Can a test region even be at the very end of a file?
                          end = source.scalars.endIndex
                        }

                        regions.append(CoverageRegion(region: start..<end, count: count))
                      }
                    }
                  }
                }

                CoverageRegion._normalize(
                  regions: &regions,
                  source: source,
                  ignoreCoveredRegions: ignoreCoveredRegions
                )
                let stabilized = regions.map { region in
                  return region.convert { index in
                    return source.offset(of: index)
                  }
                }
                fileReports.append(FileTestCoverage(file: url, regions: stabilized))
              }
            }
          }
        }
      }

      return .success(TestCoverageReport(files: fileReports))
    }
  #endif

  // MARK: - VersionedExternalProcess

  public static var englishName: StrictString { "Swift" }
  public static var deutscherNameInDativ: StrictString { "Swift" }

  public static var commandName: String { "swift" }

  public static var searchCommands: [[String]] {
    [
      ["which", "swift"],  // Swift
      ["xcrun", "\u{2D}\u{2D}find", "swift"],  // Xcode
      ["swiftenv", "which", "swift"],  // Swift Version Manager
    ]
  }

  public static var versionQuery: [String] { ["\u{2D}\u{2D}version"] }
}
