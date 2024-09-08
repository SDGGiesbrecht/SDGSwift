/*
 Xcode.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

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
import SDGSwift

/// Xcode.
public enum Xcode: VersionedExternalProcess {

  private static let currentMajor = Version(14)

  // MARK: - Locating

  private static func coverageTool<Constraints>(
    versionConstraints: Constraints
  ) -> Result<ExternalProcess, VersionedExternalProcessLocationError<Xcode>>
  where
    Constraints: RangeFamily,
    Constraints.Bound == Version
  {  // @exempt(from: tests) Unreachable on tvOS.
    return location(versionConstraints: versionConstraints)
      .map { xcodebuild in  // @exempt(from: tests) Unreachable on Linux.
        return ExternalProcess(
          at: xcodebuild.deletingLastPathComponent().appendingPathComponent("xccov")
        )
      }
  }

  // MARK: - Usage

  private static let ignorableCommands: [String] = [
    "appintentsmetadataprocessor",
    "/bin/sh",
    "bitcode_strip",
    "builtin\u{2D}copy",
    "builtin\u{2D}create\u{2D}build\u{2D}directory",
    "builtin\u{2D}infoPlistUtility",
    "builtin\u{2D}productPackagingUtility",
    "builtin\u{2D}RegisterExecutionPolicyException",
    "builtin\u{2D}Swift\u{2D}Compilation",
    "builtin\u{2D}Swift\u{2D}Compilation\u{2D}Requirements",
    "builtin\u{2D}SwiftDriver",
    "builtin\u{2D}swiftHeaderTool",
    "builtin\u{2d}swiftStdLibTool",
    "builtin\u{2d}swiftTaskExecution",
    "cd",
    "chmod",
    "clang",
    "clang\u{2D}stat\u{2D}cache",
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
    "swift\u{2D}frontend",
    "touch",
    "xcodebuild",
    "write\u{2D}file",
  ]
  private static let abbreviableCommands: [String] = [
    "ClangStatCache",
    "CodeSign",
    "Codesigning",
    "CompileC",
    "CompileSwift",
    "CompileSwiftSources",
    "Copy",
    "Copying",
    "CopySwiftLibs",
    "CreateBuildDirectory",
    "CreateUniversalBinary",
    "GenerateDSYMFile",
    "Ditto",
    "Ld",
    "MergeSwiftModule",
    "MkDir",
    "PBXCp",
    "ProcessInfoPlistFile",
    "ProcessProductPackaging",
    "RegisterExecutionPolicyException",
    "SwiftCompile",
    "SwiftDriver",
    "SwiftDriverJobDiscovery",
    "SwiftEmitModule",
    "SwiftMergeGeneratedHeaders",
    "SymLink",
    "Touch",
    "WriteAuxiliaryFile",
  ]

  private static let otherIgnored: [String] = [
    "[Arbitration]",
    "com.apple.dt.XCTest/IDETestRunSession\u{2D}",
    "Command line invocation:",
    "Create build description",
    "Beginning test session",
    "Build description path:",
    "Build description signature:",
    "Build settings from command line:",
    "device_map.plist",
    "IDEPackageSupportUseBuiltinSCM",
    "IDETestOperationsObserverDebug",
    "/Logs/",
    "MTLIOAccelDevice",
    "Probing signature of",
    "replacing existing signature",
    "set currentTestRunOperation",
    "    Signing Identity:",
    "SwiftDriver\u{5C} Compilation",
    "User defaults from command line:",
    "Writing diagnostic log for test session to:",
    "xcodebuild[",
    ".xcresult",
    "XCTHTestRunner",
    "XCTTestIdentifier",
  ]

  /// Abbreviates Xcode output to make it more readable.
  ///
  /// This function is intended for use in `reportProgress` to keep the log concise and manageable.
  ///
  /// - Parameters:
  ///     - output: The Xcode output to abbreviate.
  public static func abbreviate(
    output: String
  ) -> String? {  // @exempt(from: tests) Meaningless on Linux.
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
          // @exempt(from: tests) Does not occur in current Xcode release.
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

  #if !PLATFORM_LACKS_FOUNDATION_PROCESS
    /// Builds the package.
    ///
    /// - Parameters:
    ///     - package: The package to build.
    ///     - platform: The platform to build for.
    ///     - allArchitectures: Optional. Pass `true` to build for all architectures.
    ///     - reportProgress: Optional. A closure to execute for each line of output.
    @discardableResult public static func build(
      _ package: PackageRepository,
      for platform: Platform,
      allArchitectures: Bool = false,
      reportProgress: (_ progressReport: String) -> Void = { _ in }  // @exempt(from: tests)
    ) -> Result<String, SchemeError> {

      switch scheme(for: package) {
      case .failure(let error):
        return .failure(error)
      case .success(let scheme):  // @exempt(from: tests) Unreachable on Linux.
        var earliestVersion = Version(8, 0, 0)
        var command = ["build"]

        let destinationNeeded = Version(13)
        if let resolved = version(
          forConstraints: earliestVersion..<currentMajor.compatibleVersions.upperBound
        ),
          resolved ≥ destinationNeeded
        {
          earliestVersion.increase(to: destinationNeeded)
          command += [
            "\u{2D}destination",
            "generic/platform=\(platform.commandLineBuildDestinationPlatformName)",
          ]
        } else {  // @exempt(from: tests)
          command += ["\u{2D}sdk", platform.commandLineSDKName]
        }

        command += ["\u{2D}scheme", scheme]
        if allArchitectures {
          command.append("ONLY_ACTIVE_ARCH=NO")
        }

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
    for line in log.lines.lazy.map({ $0.line })
    where line.contains(" warning:".scalars.literal(for: String.ScalarView.SubSequence.self)) {
      if SwiftCompiler._warningBelongsToDependency(line) {
        // @exempt(from: tests) Meaningless on Linux.
        continue
      }
      if line.contains(
        "/SourcePackages/".scalars.literal(for: String.ScalarView.SubSequence.self)
      ) {  // @exempt(from: tests)
        // @exempt(from: tests) Xcode‐managed SwiftPM dependency. Meaningless on Linux.
        continue
      }
      if line.contains(
        "directory not found for option".scalars.literal(for: String.ScalarView.SubSequence.self)
      ) {
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

  private static func resultBundle(
    for project: PackageRepository,
    on platform: Platform
  ) -> URL {  // @exempt(from: tests) Unreachable on tvOS.
    return project.location.appendingPathComponent(
      ".swiftpm/SDGSwift/Xcode Results/\(platform.cacheDirectoryName).xcresult"
    )
  }

  #if !PLATFORM_LACKS_FOUNDATION_PROCESS
    /// Tests the package.
    ///
    /// - Parameters:
    ///     - package: The package to test.
    ///     - platform: The platform to run tests on.
    ///     - reportProgress: Optional. A closure to execute for each line of output.
    @discardableResult public static func test(
      _ package: PackageRepository,
      on platform: Platform,
      reportProgress: (_ progressReport: String) -> Void = { _ in }  // @exempt(from: tests)
    ) -> Result<String, SchemeError> {

      var earliestVersion = Version(8, 0, 0)
      var command = ["test"]

      switch platform {
      case .tvOS(simulator: true):  // @exempt(from: tests) Tested separately.
        earliestVersion.increase(to: Version(9, 0, 0))

        var tv4K = "Apple TV 4K"

        let parenthesesNeeded = Version(12, 5)
        var appendix = ""
        if let resolved = version(
          forConstraints: earliestVersion..<currentMajor.compatibleVersions.upperBound
        ),
          resolved ≥ parenthesesNeeded
        {
          // @exempt(from: tests) Unreachable on Linux.
          earliestVersion.increase(to: parenthesesNeeded)
          appendix = " (2nd generation)"
        }

        let thirdGenerationNeeded = Version(14, 1)
        if let resolved = version(
          forConstraints: earliestVersion..<currentMajor.compatibleVersions.upperBound
        ),
          resolved ≥ thirdGenerationNeeded
        {
          // @exempt(from: tests) Unreachable on Linux.
          earliestVersion.increase(to: thirdGenerationNeeded)
          appendix = " (3rd generation)"
        }

        tv4K.append(contentsOf: appendix)

        command += ["\u{2D}destination", "platform=tvOS Simulator,name=\(tv4K)"]
      case .iOS(simulator: true):  // @exempt(from: tests) Tested separately.
        earliestVersion.increase(to: Version(11, 0, 0))
        var iphoneVersion = "11"

        let iPhone12Available = Version(12, 1)
        if let resolved = version(
          forConstraints: earliestVersion..<currentMajor.compatibleVersions.upperBound
        ),
          resolved ≥ iPhone12Available
        {
          // @exempt(from: tests) Unreachable on Linux.
          earliestVersion.increase(to: iPhone12Available)
          iphoneVersion = "12"
        }

        let iPhone14Available = Version(14)
        if let resolved = version(
          forConstraints: earliestVersion..<currentMajor.compatibleVersions.upperBound
        ),
          resolved ≥ iPhone14Available
        {
          // @exempt(from: tests) Unreachable on Linux.
          earliestVersion.increase(to: iPhone14Available)
          iphoneVersion = "14"
        }

        command += ["\u{2D}destination", "platform=iOS Simulator,name=iPhone \(iphoneVersion)"]
      case .watchOS(simulator: true):
        earliestVersion.increase(to: Version(12, 5, 0))
        var watchSeries = "6 \u{2D} 40mm"

        let series8Available = Version(14)
        if let resolved = version(
          forConstraints: earliestVersion..<currentMajor.compatibleVersions.upperBound
        ),
          resolved ≥ series8Available
        {
          // @exempt(from: tests) Unreachable on Linux.
          earliestVersion.increase(to: series8Available)
          watchSeries = "8 (41mm)"
        }

        command += [
          "\u{2D}destination", "platform=watchOS Simulator,name=Apple Watch Series \(watchSeries)",
        ]
      default:
        let deviceNeeded = Version(13)
        if let resolved = version(
          forConstraints: earliestVersion..<currentMajor.compatibleVersions.upperBound
        ),
          resolved ≥ deviceNeeded
        {
          // @exempt(from: tests) Unreachable on Linux.
          earliestVersion.increase(to: deviceNeeded)
          command += [
            "\u{2D}destination", "platform=\(platform.commandLineBuildDestinationPlatformName)",
          ]
        } else {  // @exempt(from: tests)
          command += ["\u{2D}sdk", platform.commandLineSDKName]
        }
      }

      switch scheme(for: package) {
      case .failure(let error):
        return .failure(error)
      case .success(let scheme):  // @exempt(from: tests) Unreachable on Linux.
        command += ["\u{2D}scheme", scheme]
      }

      // @exempt(from: tests) Unreachable on Linux.
      command += ["\u{2D}enableCodeCoverage", "YES"]

      let resultBundlesAvailable = Version(11, 0, 0)
      if let resolved = version(
        forConstraints: earliestVersion..<currentMajor.compatibleVersions.upperBound
      ),
        resolved ≥ resultBundlesAvailable
      {
        // @exempt(from: tests)
        earliestVersion.increase(to: resultBundlesAvailable)
        let resultURL = resultBundle(for: package, on: platform)
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

    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
      /// Returns the code coverage report for the package.
      ///
      /// - Parameters:
      ///     - package: The package to test.
      ///     - platform: The platform to run tests on.
      ///     - ignoreCoveredRegions: Optional. Set to `true` if only coverage gaps are significant. When `true`, covered regions will be left out of the report, resulting in faster parsing.
      ///     - reportProgress: Optional. A closure to execute for each line of output.
      ///
      /// - Returns: The report, or `nil` if there is no code coverage information.
      public static func codeCoverageReport(
        for package: PackageRepository,
        on platform: Platform,
        ignoreCoveredRegions: Bool = false,
        reportProgress: (_ progressReport: String) -> Void = { _ in }  // @exempt(from: tests)
      ) -> Result<TestCoverageReport?, CoverageReportingError> {

        let ignoredDirectories: [URL] = package._directoriesIgnoredForTestCoverage()

        let resultBundle = self.resultBundle(for: package, on: platform)

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
              if file.pathComponents.contains("DerivedData")
                ∨ ignoredDirectories.contains(where: { file.is(in: $0) })
              {
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
          let fileResult = purgingAutoreleased { () -> Result<Void, CoverageReportingError> in

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

            var regions: [CoverageRegion<String.ScalarView.Index>] = []
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
                  region: source._toIndex(
                    line: lineNumber
                  )..<source._toIndex(line: lineNumber + 1),
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
                while let nested = substring.firstMatch(
                  for: NestingPattern(opening: "(", closing: ")")
                ) {
                  let regionString = nested.levelContents.contents
                  substring.removeSubrange(nested.contents.bounds)

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

            let stabilized = regions.map { region in
              return region.convert { index in
                return source.offset(of: index)
              }
            }
            files.append(FileTestCoverage(file: fileURL, regions: stabilized))

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

      var information: String
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
      // @exempt(from: tests) Unreachable on Linux.

      // Drop any logs.
      information.drop(upTo: "{")

      if information.contains("https://feedbackassistant.apple.com") {
        // The first braces were warning information from the log.
        information.removeFirst()
        information.drop(upTo: "{")
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
        let nameData = workspaceDictionary["name"],
        let name = nameData as? String,
        let schemesData = workspaceDictionary["schemes"],
        let schemeList = schemesData as? [String],
        let packageScheme =
          schemeList.first(where: { $0 == "\(name)\u{2D}Package" })  // @exempt(from: tests)
          ?? schemeList.first(where: { $0 == name })  // @exempt(from: tests)
          ?? schemeList.first(where: { $0.hasSuffix("\u{2D}Package") })  // @exempt(from: tests)
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
    @discardableResult public static func runCustomCoverageSubcommand<Constraints>(
      _ arguments: [String],
      in workingDirectory: URL? = nil,
      with environment: [String: String]? = nil,
      versionConstraints: Constraints,
      reportProgress: (_ progressReport: String) -> Void = { _ in }
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

  public static var englishName: StrictString { "Xcode" }
  public static var deutscherNameInDativ: StrictString { "Xcode" }

  public static var commandName: String { "xcodebuild" }

  public static var searchCommands: [[String]] {
    [
      ["xcrun", "\u{2D}\u{2D}find", "xcodebuild"]  // Xcode
    ]
  }

  public static var versionQuery: [String] { ["\u{2D}version"] }
}
