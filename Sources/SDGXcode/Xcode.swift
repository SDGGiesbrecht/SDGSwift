/*
 Xcode.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(WASI)  // #workaround(Swift 5.2.1, Web lacks Foundation.)
  import Foundation
#endif

import SDGControlFlow
import SDGLogic
import SDGMathematics
import SDGCollections
import SDGText
import SDGLocalization
import SDGExternalProcess
import SDGVersioning

import SDGSwiftLocalizations
import SDGSwift

/// Xcode.
public enum Xcode: VersionedExternalProcess {

  private static let currentMajor = Version(11)

  // MARK: - Locating

  #if !os(WASI)  // #workaround(Swift 5.2.1, Web lacks Foundation.)
    private static func coverageTool<Constraints>(
      versionConstraints: Constraints
    ) -> Result<ExternalProcess, VersionedExternalProcessLocationError<Xcode>>
    where Constraints: RangeFamily, Constraints.Bound == Version {
      return location(versionConstraints: versionConstraints)
        .map { xcodebuild in  // @exempt(from: tests) Unreachable on Linux.
          return ExternalProcess(
            at: xcodebuild.deletingLastPathComponent().appendingPathComponent("xccov")
          )
        }
    }
  #endif

  // MARK: - Usage

  private static let ignorableCommands: [String] = [
    "/bin/sh",
    "bitcode_strip",
    "builtin\u{2D}copy",
    "builtin\u{2D}create\u{2D}build\u{2D}directory",
    "builtin\u{2D}infoPlistUtility",
    "builtin\u{2D}productPackagingUtility",
    "builtin\u{2D}RegisterExecutionPolicyException",
    "builtin\u{2D}swiftHeaderTool",
    "builtin\u{2d}swiftStdLibTool",
    "cd",
    "chmod",
    "clang",
    "codesign",
    "directory",
    "ditto",
    "dsymutil",
    "export",
    "lipo",
    "ln",
    "mkdir",
    "swift",
    "swiftc",
    "touch",
    "xcodebuild",
    "write\u{2D}file",
  ]
  private static let abbreviableCommands: [String] = [
    "CodeSign",
    "Codesigning",
    "CompileC",
    "CompileSwift",
    "CompileSwiftSources",
    "Copying",
    "CopySwiftLibs",
    "CreateBuildDirectory",
    "CreateUniversalBinary",
    "GenerateDSYMFile",
    "Ditto",
    "Ld",
    "MergeSwiftModule",
    "MkDir",
    "ProcessInfoPlistFile",
    "ProcessProductPackaging",
    "RegisterExecutionPolicyException",
    "SwiftMergeGeneratedHeaders",
    "SymLink",
    "Touch",
    "WriteAuxiliaryFile",
  ]

  private static let otherIgnored: [String] = [
    "com.apple.dt.XCTest/IDETestRunSession\u{2D}",
    "Command line invocation:",
    "Beginning test session",
    "Build settings from command line:",
    "device_map.plist",
    "IDETestOperationsObserverDebug",
    "/Logs/",
    "Probing signature of",
    "replacing existing signature",
    "Writing diagnostic log for test session to:",
    ".xcresult",
  ]

  /// Abbreviates Xcode output to make it more readable.
  ///
  /// This function is intended for use in `reportProgress` to keep the log concise and manageable.
  ///
  /// - Parameters:
  ///     - output: The Xcode output to abbreviate.
  public static func abbreviate(output: String) -> String? {
    // @exempt(from: tests) Meaningless on Linux.
    if output.hasPrefix("$ ") {
      return output
    }
    if output.isEmpty ∨ ¬output.scalars.contains(where: { $0 ∉ CharacterSet.whitespaces }) {
      return nil
    }
    for ignored in otherIgnored {
      if output.contains(ignored) {
        return nil
      }
    }

    // Log style entry.
    let logComponents: [String] = output.components(separatedBy: " ")
    if logComponents.count ≥ 4,
      logComponents[0].scalars.allSatisfy({ $0 ∈ CharacterSet.decimalDigits ∪ ["\u{2D}"] }),
      logComponents[1].scalars.allSatisfy({
        // @exempt(from: tests) False coverage result.
        $0 ∈ CharacterSet.decimalDigits ∪ [":", ".", "+", "\u{2D}"]
      }),
      let process = logComponents[2].prefix(upTo: "[")?.contents
    {
      // @exempt(from: tests) False coverage result.
      return ([String(process) + ":"] + logComponents[3...]).joined(separator: " ")
    }

    // Command style entry.
    var indentation = ""
    var commandLine = output
    while commandLine.first == " " {
      indentation.append(commandLine.removeFirst())
    }
    if let pathSection = commandLine.components(separatedBy: " ").first?.contents {
      let path = String(pathSection)
      let command = String(path.components(separatedBy: "/").last!.contents)
      for ignorableCommand in Xcode.ignorableCommands where ignorableCommand == command {
        return nil
      }
      for abbreviableCommand in Xcode.abbreviableCommands where abbreviableCommand == command {
        let components = commandLine.components(separatedBy: "/")
        var result: String
        if components.count == 1 {
          result = commandLine
        } else {
          let file = String(components.last!.contents)
          let abbreviatedPath: String
          if path == command {
            abbreviatedPath = command
          } else {
            abbreviatedPath = "[...]/" + command
          }
          result = indentation + abbreviatedPath + " [...]/" + file
        }
        if let last = result.lastMatch(for: " (") {
          result.truncate(at: last.range.lowerBound)
        }
        return result
      }
    }

    // Other
    return output
  }

  #if !os(WASI)  // #workaround(Swift 5.2.1, Web lacks Foundation.)
    /// Builds the package.
    ///
    /// - Parameters:
    ///     - package: The package to build.
    ///     - sdk: The SDK to build for.
    ///     - reportProgress: Optional. A closure to execute for each line of output.
    ///     - progressReport: A line of output.
    @discardableResult public static func build(
      _ package: PackageRepository,
      for sdk: SDK,
      reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress
    ) -> Result<String, SchemeError> {

      switch scheme(for: package) {
      case .failure(let error):
        return .failure(error)
      case .success(let scheme):  // @exempt(from: tests) Unreachable on Linux.
        let earliestVersion = Version(8, 0, 0)
        let command = [
          "build",
          "\u{2D}sdk", sdk.commandLineName,
          "\u{2D}scheme", scheme,
        ]
        return runCustomSubcommand(
          command,
          in: package.location,
          versionConstraints: earliestVersion..<currentMajor.compatibleVersions.upperBound,
          reportProgress: reportProgress
        ).mapError { .xcodeError($0) }  // @exempt(from: tests)
      }
    }
  #endif

  /// Returns whether the log contains warnings.
  ///
  /// - Parameters:
  ///     - log: The Xcode output to check.
  public static func warningsOccurred(during log: String) -> Bool {
    for line in log.lines.lazy.map({ $0.line }) where line.contains(" warning:".scalars) {
      if SwiftCompiler._warningBelongsToDependency(line) {
        // @exempt(from: tests) Meaningless on Linux.
        continue
      }
      if line.contains("/SourcePackages/".scalars) {  // @exempt(from: tests)
        // Xcode‐managed SwiftPM dependency. Meaningless on Linux.
        continue
      }
      if line.contains("directory not found for option".scalars) {
        // @exempt(from: tests) Only triggered on the first build.
        // This above false positive occurs when a project generated by the Swift Package Manager attempts to build for watchOS.
        continue
      }
      if line.elementsEqual("ld: warning: ".scalars) {
        // @exempt(from: tests) Erratic.
        // Building for watchOS sometimes triggers unknown errors with no description.
        continue
      }
      return true
    }
    // @exempt(from: tests)
    return false
  }

  #if !os(WASI)  // #workaround(Swift 5.2.1, Web lacks Foundation.)
    private static func resultBundle(for project: PackageRepository, on sdk: SDK) -> URL {
      return project.location.appendingPathComponent(
        ".swiftpm/SDGSwift/Xcode Results/\(sdk.cacheDirectoryName).xcresult"
      )
    }

    /// Tests the package.
    ///
    /// - Parameters:
    ///     - package: The package to test.
    ///     - sdk: The SDK to run tests on.
    ///     - reportProgress: Optional. A closure to execute for each line of output.
    ///     - progressReport: A line of output.
    @discardableResult public static func test(
      _ package: PackageRepository,
      on sdk: SDK,
      reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress
    ) -> Result<String, SchemeError> {

      var earliestVersion = Version(8, 0, 0)
      var command = ["test"]

      switch sdk {
      case .iOS(simulator: true):  // @exempt(from: tests) Tested separately.
        earliestVersion.increase(to: Version(11, 0, 0))
        command += ["\u{2D}destination", "name=iPhone 11"]
      case .tvOS(simulator: true):  // @exempt(from: tests) Tested separately.
        earliestVersion.increase(to: Version(9, 0, 0))
        command += ["\u{2D}destination", "name=Apple TV 4K"]
      default:
        command += ["\u{2D}sdk", sdk.commandLineName]
      }

      switch scheme(for: package) {
      case .failure(let error):
        return .failure(error)
      case .success(let scheme):  // @exempt(from: tests) Unreachable on Linux.
        command += ["\u{2D}scheme", scheme]
      }

      command += ["\u{2D}enableCodeCoverage", "YES"]

      let resultBundlesAvailable = Version(11, 0, 0)
      if let resolved = version(
        forConstraints: earliestVersion..<currentMajor.compatibleVersions.upperBound
      ),
        resolved ≥ resultBundlesAvailable
      {
        // @exempt(from: tests)
        earliestVersion.increase(to: resultBundlesAvailable)
        let resultURL = resultBundle(for: package, on: sdk)
        command.append(contentsOf: ["\u{2D}resultBundlePath", resultURL.path])
        try? FileManager.default.removeItem(at: resultURL)
      }

      return runCustomSubcommand(
        command,
        in: package.location,
        versionConstraints: earliestVersion..<currentMajor.compatibleVersions.upperBound,
        reportProgress: reportProgress
      ).mapError { .xcodeError($0) }  // @exempt(from: tests)
    }

    // #workaround(workspace version 0.32.0, SwiftPM won’t compile.)
    #if !(os(Windows) || os(Android))
      /// Returns the code coverage report for the package.
      ///
      /// - Parameters:
      ///     - package: The package to test.
      ///     - sdk: The SDK to run tests on.
      ///     - ignoreCoveredRegions: Optional. Set to `true` if only coverage gaps are significant. When `true`, covered regions will be left out of the report, resulting in faster parsing.
      ///     - reportProgress: Optional. A closure to execute for each line of output.
      ///     - progressReport: A line of output.
      ///
      /// - Returns: The report, or `nil` if there is no code coverage information.
      public static func codeCoverageReport(
        for package: PackageRepository,
        on sdk: SDK,
        ignoreCoveredRegions: Bool = false,
        reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress
      ) -> Result<TestCoverageReport?, CoverageReportingError> {

        let ignoredDirectories: [URL] = package._directoriesIgnoredForTestCoverage()

        let resultBundle = self.resultBundle(for: package, on: sdk)

        let compatibleVersions = Version(11, 0, 0)..<currentMajor.compatibleVersions.upperBound
        let fileURLs: [URL]
        switch runCustomCoverageSubcommand(
          [
            "view",
            "\u{2D}\u{2D}file\u{2D}list",
            "\u{2D}\u{2D}archive", resultBundle.path,
          ],
          versionConstraints: compatibleVersions
        ) {
        case .failure(let error):
          return .failure(.xcodeError(error))
        case .success(let output):  // @exempt(from: tests) Unreachable on Linux.
          fileURLs = output.lines.map({ URL(fileURLWithPath: String($0.line)) })
            .filter({ file in  // @exempt(from: tests) Unreachable on Linux.
              if file.pathExtension ≠ "swift" {
                // @exempt(from: tests)
                // The report is unlikely to be readable.
                return false
              }
              if ignoredDirectories.contains(where: { file.is(in: $0) }) {
                // @exempt(from: tests)
                // Belongs to a dependency.
                return false
              }
              return true
            }).sorted()
        }

        var files: [FileTestCoverage] = []  // @exempt(from: tests) Unreachable on Linux.
        for fileURL in fileURLs {
          // @exempt(from: tests) Unreachable on Linux.
          let fileResult = autoreleasepool { () -> Result<Void, CoverageReportingError> in

            reportProgress(
              String(
                UserFacing<StrictString, InterfaceLocalization>({ localization in
                  let relativePath = fileURL.path(relativeTo: package.location)
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

            var report: String
            switch runCustomCoverageSubcommand(
              [
                "view",
                "\u{2D}\u{2D}file", fileURL.path,
                "\u{2D}\u{2D}archive", resultBundle.path,
              ],
              versionConstraints: compatibleVersions
            ) {
            case .failure(let error):
              return .failure(.xcodeError(error))
            case .success(let output):
              report = output
            }
            if let match = report.firstMatch(for: "IDEResultKitSerializationConverter\n") {
              report.removeSubrange(..<match.range.upperBound)
            }

            let source: String
            do {
              source = try String(from: fileURL)
            } catch {
              return .failure(.foundationError(error))
            }
            func toIntegerIgnoringWhitespace(_ string: String) -> Int? {
              let digitsOnly = string.replacingOccurrences(of: " ", with: "")
              if let integer = Int(digitsOnly) {
                return integer
              }
              if ¬digitsOnly.scalars.contains(where: {  // @exempt(from: tests)
                $0 ∉ Set<UnicodeScalar>(["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"])
              }) {
                // It is an integer; it is just to large.
                return Int.max
              }
              return nil
            }

            var regions: [CoverageRegion] = []
            while ¬report.isEmpty {
              let lineRange = report.prefix(through: "\n")?.range ?? report.bounds
              var line = String(report[lineRange])
              report.removeSubrange(lineRange)
              if line.contains("*") {
                continue
              }

              while line.hasSuffix("\n") {
                line.removeLast()
              }

              let base: String
              let hasSubranges: Bool
              if line.hasSuffix("[") {
                base = String(line.dropLast())
                hasSubranges = true
              } else {
                base = line
                hasSubranges = false
              }
              let components = base.components(separatedBy: ":") as [String]
              guard let lineString = components.first,
                let lineNumber = toIntegerIgnoringWhitespace(lineString),
                let columnString = components.last,
                let count = toIntegerIgnoringWhitespace(columnString)
              else {
                // @exempt(from: tests)
                return .failure(.corruptTestCoverageReport)
              }
              regions.append(
                CoverageRegion(
                  region: source._toIndex(line: lineNumber)..<source._toIndex(line: lineNumber + 1),
                  count: count
                )
              )

              if hasSubranges {
                guard let subrange = report.prefix(through: "]\n")?.range else {
                  // @exempt(from: tests)
                  return .failure(.corruptTestCoverageReport)
                }
                var substring = String(report[subrange])
                report.removeSubrange(subrange)
                while let nested = substring.firstNestingLevel(startingWith: "(", endingWith: ")") {
                  let regionString = nested.contents.contents
                  substring.removeSubrange(nested.container.range)

                  let components = regionString.components(separatedBy: ",") as [String]
                  guard components.count == 3,
                    let start = toIntegerIgnoringWhitespace(components[0]),
                    let length = toIntegerIgnoringWhitespace(components[1]),
                    let count = toIntegerIgnoringWhitespace(components[2])
                  else {
                    // @exempt(from: tests)
                    return .failure(.corruptTestCoverageReport)
                  }
                  regions.append(
                    CoverageRegion(
                      region: source._toIndex(
                        line: lineNumber,
                        column: start
                      )..<source._toIndex(line: lineNumber, column: start + length),
                      count: count
                    )
                  )
                }
              }
            }

            CoverageRegion._normalize(
              regions: &regions,
              source: source,
              ignoreCoveredRegions: ignoreCoveredRegions
            )

            files.append(FileTestCoverage(file: fileURL, regions: regions))

            return .success(())
          }

          switch fileResult {
          case .failure(let error):
            return .failure(error)
          case .success:
            break
          }
        }
        return .success(TestCoverageReport(files: files))
      }
    #endif

    /// Returns the main package scheme.
    ///
    /// - Parameters:
    ///     - package: The package.
    public static func scheme(for package: PackageRepository) -> Result<String, SchemeError> {

      let information: String
      switch runCustomSubcommand(
        ["\u{2D}list", "\u{2D}json"],
        in: package.location,
        versionConstraints: Version(8, 0, 0)..<currentMajor.compatibleVersions.upperBound
      ) {
      case .failure(let error):
        return .failure(.xcodeError(error))
      case .success(let output):  // @exempt(from: tests) Unreachable on Linux.
        information = output
      }

      let json: Any
      do {
        json = try JSONSerialization.jsonObject(with: information.file)
      } catch {  // @exempt(from: tests)
        return .failure(.foundationError(error))
      }

      if let jsonDictionary = json as? [String: Any],
        let workspaceData = jsonDictionary["workspace"]
          ?? jsonDictionary["project"],  // @exempt(from: tests)
        let workspaceDictionary = workspaceData as? [String: Any],
        let schemesData = workspaceDictionary["schemes"],
        let schemeList = schemesData as? [String],
        let packageScheme =
          schemeList
          .first(where: { $0.hasSuffix("\u{2D}Package") })  // @exempt(from: tests)
          ?? schemeList.first  // @exempt(from: tests)
      {  // @exempt(from: tests)
        return .success(packageScheme)
      }

      return .failure(.noPackageScheme)
    }

    /// Runs a custom subcommand of xccov.
    ///
    /// - Parameters:
    ///   - arguments: The arguments (leave “xccov” off the beginning).
    ///   - workingDirectory: Optional. A different working directory.
    ///   - environment: Optional. A different set of environment variables.
    ///   - versionConstraints: The acceptable range of versions.
    ///   - reportProgress: Optional. A closure to execute for each line of output.
    ///   - progressReport: A line of output.
    @discardableResult public static func runCustomCoverageSubcommand<Constraints>(
      _ arguments: [String],
      in workingDirectory: URL? = nil,
      with environment: [String: String]? = nil,
      versionConstraints: Constraints,
      reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress
    ) -> Result<String, VersionedExternalProcessExecutionError<Xcode>>
    where Constraints: RangeFamily, Constraints.Bound == Version {

      reportProgress("$ xccov " + arguments.joined(separator: " "))

      switch coverageTool(versionConstraints: versionConstraints) {
      case .failure(let error):
        return .failure(.locationError(error))
      case .success(let coverage):  // @exempt(from: tests) Unreachable on Linux.
        switch coverage.run(
          arguments,
          in: workingDirectory,
          with: environment,
          reportProgress: reportProgress
        ) {
        case .failure(let error):
          return .failure(.executionError(error))
        case .success(let output):
          return .success(output)
        }
      }
    }
  #endif

  // MARK: - VersionedExternalProcess

  public static let englishName: StrictString = "Xcode"
  public static var deutscherNameInDativ: StrictString = "Xcode"

  public static var commandName: String = "xcodebuild"

  public static let searchCommands: [[String]] = [
    ["xcrun", "\u{2D}\u{2D}find", "xcodebuild"]  // Xcode
  ]

  public static var versionQuery: [String] = ["\u{2D}version"]
}
