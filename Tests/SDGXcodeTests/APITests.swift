/*
 APITests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGCollections
import SDGText
import SDGPersistence
import SDGLocalization
import SDGExternalProcess
import SDGVersioning

import SDGSwift
import SDGXcode

import SDGSwiftLocalizations

import XCTest

import SDGPersistenceTestUtilities
import SDGLocalizationTestUtilities
import SDGXCTestUtilities

import SDGSwiftTestUtilities

class APITests: SDGSwiftTestUtilities.TestCase {

  func testDependencyWarnings() throws {
    #if !PLATFORM_LACKS_FOUNDATION_FILE_MANAGER
      #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
        try withMock(named: "DependentOnWarnings", dependentOn: ["Warnings"]) { package in
          #if !PLATFORM_LACKS_GIT
            #if PLATFORM_HAS_XCODE
              let build = try package.build(for: .macOS).get()
              XCTAssertFalse(
                Xcode.warningsOccurred(during: build),
                "Warning triggered in:\n\(build)"
              )
            #endif
          #endif
        }
      #endif
    #endif
  }

  func testXcode() throws {
    #if !PLATFORM_LACKS_FOUNDATION_FILE_MANAGER
      #if !PLATFORM_LACKS_FOUNDATION_PROCESS
        #if PLATFORM_HAS_XCODE
          _ = try Xcode.runCustomSubcommand(
            ["\u{2D}version"],
            versionConstraints: Version(Int.min)...Version(Int.max)
          ).get()
        #else
          _ = try? Xcode.runCustomSubcommand(
            ["\u{2D}version"],
            versionConstraints: Version(Int.min)...Version(Int.max)
          ).get()
        #endif
      #endif
      let xcodeLocation = try? Xcode.location(
        versionConstraints: Version(Int.min)...Version(Int.max)
      ).get()
      #if PLATFORM_HAS_XCODE
        XCTAssertNotNil(xcodeLocation)
      #else
        _ = xcodeLocation  // Not expected to exist.
      #endif

      #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
        try withDefaultMockRepository { mock in
          let mockScheme = try? mock.scheme().get()
          #if PLATFORM_HAS_XCODE
            XCTAssertNotNil(mockScheme, "Failed to locate Xcode scheme.")
          #endif

          let sdks: [Xcode.Platform] = [
            .macOS,
            .tvOS(simulator: false),
            .tvOS(simulator: true),
            .iOS(simulator: false),
            .iOS(simulator: true),
            .watchOS(simulator: false),
            .watchOS(simulator: true),
          ]
          for sdk in sdks {
            print("Testing build for \(sdk.commandLineBuildDestinationPlatformName)...")

            let derived = URL(fileURLWithPath: NSHomeDirectory())
              .appendingPathComponent("Library/Developer/Xcode/DerivedData")
            for subdirectory
              in (try? FileManager.default.contentsOfDirectory(
                at: derived,
                includingPropertiesForKeys: nil,
                options: .skipsSubdirectoryDescendants
              )) ?? []
            where subdirectory.lastPathComponent.contains("Mock") {
              try? FileManager.default.removeItem(at: subdirectory)
            }

            var log = Set<String>()  // Xcode’s order is not deterministic.
            let processLog: (String) -> Void = { outputLine in
              if let abbreviated = Xcode.abbreviate(output: outputLine) {
                XCTAssert(
                  abbreviated.count < 100
                    ∨ abbreviated.contains("warning:")
                    ∨ abbreviated.contains("error:")
                    ∨ abbreviated.contains("note:")
                    ∨ abbreviated.hasPrefix("$ "),
                  "Output is too long: " + abbreviated
                )
                log.insert(abbreviated)
              }
            }
            #if PLATFORM_HAS_XCODE
              _ = try mock.build(for: sdk, reportProgress: processLog).get()
            #else
              _ = try? mock.build(for: sdk, reportProgress: processLog).get()
            #endif

            // Variable Xcode location and version:
            var filtered: [String] = log.filter({
              ¬$0.contains("ld: warning: directory not found for option \u{27}\u{2d}F")
                ∧ ¬$0.contains("SDKROOT =") ∧ $0 ≠ "ld: warning: "
            })
            filtered = filtered.filter({ ¬$0.contains("XCTest.framework/XCTest") })
            filtered = filtered.filter({ ¬$0.contains("libXCTestSwiftSupport.dylib") })
            // Inconsistent path:
            filtered = filtered.map({ $0.truncated(after: "\u{2D}resultBundlePath") })
            // Depend on external code signing settings:
            filtered = filtered.filter({
              ¬$0.hasPrefix("xcodebuild: MessageTracer: Falling back to default whitelist")
            })
            filtered = filtered.filter({ ¬$0.hasPrefix("codesign: [") })
            // Inconsistent user:
            filtered = filtered.filter({ ¬$0.contains("IDEDerivedDataPathOverride") })
            // Inconsistently appear:
            filtered = filtered.filter({ ¬$0.contains("RegisterExecutionPolicyException") })
            filtered = filtered.filter({ ¬$0.contains("Operation not permitted") })
            filtered = filtered.filter({ line in
              ¬line.contains("Execution policy exception registration failed")
            })
            filtered = filtered.filter({ ¬$0.contains("Copying [...]/libswift") })
            filtered = filtered.filter({ ¬$0.contains("Codesigning [...]/libswift") })
            filtered = filtered.filter({ ¬$0.contains("Using new build system") })
            filtered = filtered.filter({ ¬$0.contains("unable to get a dev_t") })
            filtered = filtered.filter({ ¬$0.contains("CreateUniversalBinary") })
            // Inconsistent identifiers:
            filtered = filtered.filter({ ¬$0.contains("{ platform:macOS, arch:") })
            // Differ between 5.5 and 5.6
            filtered = filtered.filter({ ¬$0.hasPrefix("Copy ") })
            filtered = filtered.filter({ ¬$0.hasPrefix("Ditto ") })
            filtered = filtered.filter({ ¬$0.hasPrefix("EmitSwiftModule ") })
            filtered = filtered.filter({ ¬$0.hasPrefix("MergeSwiftModule ") })
            filtered = filtered.filter({ ¬$0.hasPrefix("PBXCp ") })
            filtered = filtered.filter({ ¬$0.hasPrefix("note: Building targets in") })
            // Inconsistent identifiers:
            filtered = filtered.filter({ ¬$0.contains("sdkstatcache") })
            // #workaround(Swift 5.7.2, Disabled while stradling versions.)
            #if PLATFORM_HAS_XCODE && compiler(>=5.8)
              compare(
                filtered.sorted().joined(separator: "\n"),
                against: testSpecificationDirectory()
                  .appendingPathComponent("Xcode")
                  .appendingPathComponent("Build")
                  .appendingPathComponent(sdk.commandLineSDKName + ".txt"),
                overwriteSpecificationInsteadOfFailing: false
              )
            #endif
          }

          let testSDKs: [Xcode.Platform] = [
            .macOS,
            .tvOS(simulator: true),
            .iOS(simulator: true),
            .watchOS(simulator: true),
          ]
          for sdk in testSDKs {
            print("Testing testing on \(sdk.commandLineBuildDestinationPlatformName)...")

            let derived = URL(fileURLWithPath: NSHomeDirectory())
              .appendingPathComponent("Library/Developer/Xcode/DerivedData")
            for subdirectory
              in (try? FileManager.default.contentsOfDirectory(
                at: derived,
                includingPropertiesForKeys: nil,
                options: .skipsSubdirectoryDescendants
              )) ?? []
            where subdirectory.lastPathComponent.contains("Mock") {
              try? FileManager.default.removeItem(at: subdirectory)
            }

            var log = Set<String>()  // Xcode’s order is not deterministic.
            let processLog: (String) -> Void = { outputLine in
              if let abbreviated = Xcode.abbreviate(output: outputLine) {
                XCTAssert(
                  abbreviated.count < 100
                    ∨ abbreviated.contains("warning:")
                    ∨ abbreviated.contains("error:")
                    ∨ abbreviated.contains("Failed")
                    ∨ abbreviated.contains("note:")
                    ∨ abbreviated.contains("failed")
                    ∨ abbreviated.contains("bug")
                    ∨ abbreviated.contains("Promise")
                    ∨ abbreviated.contains("Warning")
                    ∨ abbreviated.hasPrefix("$ "),
                  "Output is too long: " + abbreviated
                )
                log.insert(abbreviated)
              }
            }
            #if PLATFORM_HAS_XCODE
              _ = try mock.test(on: sdk, reportProgress: processLog).get()
            #else
              _ = try? mock.test(on: sdk, reportProgress: processLog).get()
            #endif

            // Remove dates & times:
            var filtered =
              log
              .map({ String($0.scalars.filter({ $0 ∉ CharacterSet.decimalDigits })) })
            // Inconsistent path:
            filtered = filtered.map({ $0.truncated(after: "\u{2D}resultBundlePath") })
            // Inconsistent number of occurrences: (???)
            filtered = filtered.filter({ ¬$0.contains("Executed  test, with  failures") })
            // Inconsistent which target some directories are first created for:
            filtered = filtered.filter({ ¬$0.hasPrefix("CreateBuildDirectory ") })
            // Depend on external code signing settings:
            filtered = filtered.filter({
              ¬$0.hasPrefix("xcodebuild: MessageTracer: Falling back to default whitelist")
            })
            filtered = filtered.filter({ ¬$0.hasPrefix("codesign: [") })
            // Inconsistent identifiers:
            filtered = filtered.filter({ ¬$0.contains("<DVTiPhoneSimulator:") })
            filtered = filtered.filter({ ¬$0.contains(" Promise ") })
            filtered = filtered.filter({ ¬$0.contains("<NSThread:") })
            // Inconsistent user:
            filtered = filtered.filter({ ¬$0.contains("IDEDerivedDataPathOverride") })
            // Inconsistently appear:
            filtered = filtered.filter({ ¬$0.contains("RegisterExecutionPolicyException") })
            filtered = filtered.filter({ ¬$0.contains("Operation not permitted") })
            filtered = filtered.filter({ line in
              ¬line.contains("Execution policy exception registration failed")
            })
            filtered = filtered.filter({ ¬$0.contains("Copying [...]/libswift") })
            filtered = filtered.filter({ ¬$0.contains("Codesigning [...]/libswift") })
            // Inconsistent identifiers:
            filtered = filtered.filter({ ¬$0.contains("SimDevice") })
            filtered = filtered.filter({ ¬$0.contains("} (.") })
            filtered = filtered.filter({ ¬$0.contains("application\u{2D}identifier") })
            filtered = filtered.filter({ ¬$0.contains("        \u{22}") })
            filtered = filtered.filter({ ¬$0.contains("Using new build system") })
            filtered = filtered.filter({ ¬$0.contains("unable to get a dev_t") })
            filtered = filtered.filter({ ¬$0.contains("XCTHTestRunSpecification") })
            filtered = filtered.filter({ $0 ≠ "(" })
            filtered = filtered.filter({ $0 ≠ ")" })
            filtered = filtered.filter({ $0 ≠ "{" })
            filtered = filtered.filter({ $0 ≠ "}" })
            // Inconsistent identifiers:
            filtered = filtered.filter({ ¬$0.contains("{ platform:macOS, arch:") })
            // Differ between 5.5 and 5.6
            filtered = filtered.filter({ ¬$0.hasPrefix("Copy ") })
            filtered = filtered.filter({ ¬$0.hasPrefix("Ditto ") })
            filtered = filtered.filter({ ¬$0.hasPrefix("EmitSwiftModule ") })
            filtered = filtered.filter({ ¬$0.hasPrefix("MergeSwiftModule ") })
            filtered = filtered.filter({ ¬$0.hasPrefix("PBXCp ") })
            filtered = filtered.filter({ ¬$0.hasPrefix("note: Building targets in") })
            #if PLATFORM_HAS_XCODE
              compare(
                filtered.sorted().joined(separator: "\n"),
                against: testSpecificationDirectory()
                  .appendingPathComponent("Xcode")
                  .appendingPathComponent("Test")
                  .appendingPathComponent(sdk.commandLineSDKName + ".txt"),
                overwriteSpecificationInsteadOfFailing: false
              )
            #endif
          }
        }
      #endif

      XCTAssert(¬Xcode.warningsOccurred(during: ""))

      #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
        try withDefaultMockRepository { package in
          _ = try? Xcode.build(package, for: .iOS(simulator: false)).get()
          _ = try? Xcode.test(package, on: .iOS(simulator: true)).get()
          _ = try? Xcode.codeCoverageReport(for: package, on: .iOS(simulator: true)).get()
        }
      #endif
    #endif
    _ = Xcode.versionQuery
  }

  func testXcodeAllArchitectures() throws {
    #if PLATFORM_HAS_XCODE
      try withMock(named: "MultipleArchitectures") { package in

        // Beginning in Xcode 13, basic builds are multi‐architecture, so failure is now expected even without explicitly requesting all architectures.
        _ = try? package.build(for: .macOS).get()

        switch package.build(for: .macOS, allArchitectures: true) {
        case .success(let output):
          XCTFail("Should have failed to build.\n\(output)")
        case .failure(let error):
          XCTAssert(
            error.presentableDescription().contains(
              "Float80".scalars.literal(for: StrictString.self)
            ),
            "Wrong error:\n\(error.presentableDescription())"
          )
        }
      }
    #endif
  }

  func testXcodeCoverage() throws {
    #if !PLATFORM_LACKS_FOUNDATION_FILE_MANAGER
      #if !PLATFORM_LACKS_FOUNDATION_PROCESS
        #if PLATFORM_HAS_XCODE
          _ = try Xcode.runCustomCoverageSubcommand(
            ["help"],
            versionConstraints: Version(0)..<Version(100)
          ).get()
        #else
          _ = try? Xcode.runCustomCoverageSubcommand(
            ["help"],
            versionConstraints: Version(0)..<Version(100)
          ).get()
        #endif
      #endif

      #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
        try withDefaultMockRepository { mock in
          let coverageFiles = thisRepository.location.appendingPathComponent(
            "Tests/Test Specifications/Test Coverage"
          )
          let sourceURL = coverageFiles.appendingPathComponent("Source.swift")
          let sourceDestination = mock.location.appendingPathComponent("Sources/Mock/Mock.swift")
          let testDestination = mock.location.appendingPathComponent(
            "Tests/MockTests/MockTests.swift"
          )
          try? FileManager.default.removeItem(at: sourceDestination)
          try FileManager.default.copy(
            sourceURL,
            to: sourceDestination
          )
          try? FileManager.default.removeItem(at: testDestination)
          try FileManager.default.copy(
            coverageFiles.appendingPathComponent("Tests.swift"),
            to: testDestination
          )

          #if PLATFORM_HAS_XCODE
            _ = try mock.test(on: .macOS).get()
          #else
            _ = try? mock.test(on: .macOS).get()
          #endif
          for localization in InterfaceLocalization.allCases {
            try LocalizationSetting(orderOfPrecedence: [localization.code]).do {

              let possibleReport = mock.codeCoverageReport(
                on: .macOS,
                ignoreCoveredRegions: true
              )
              #if !PLATFORM_HAS_XCODE
                func pretendToThrow() throws {}
                try pretendToThrow()
              #else
                let extractedReport = try possibleReport.get()
                guard let coverageReport = extractedReport else {
                  XCTFail("No test coverage report found.")
                  return
                }
                guard
                  let file = coverageReport.files.first(where: {
                    $0.file.lastPathComponent == "Mock.swift"
                  })
                else {
                  XCTFail("File missing from coverage report.")
                  return
                }
                do {
                  var specification = try String(from: sourceURL)
                  for range in file.regions.reversed() {
                    specification.insert(
                      "!",
                      at: specification.index(of: range.region.upperBound)
                    )
                    specification.insert(
                      "¡",
                      at: specification.index(of: range.region.lowerBound)
                    )
                  }
                  compare(
                    specification,
                    against: testSpecificationDirectory().appendingPathComponent(
                      "Coverage.txt"
                    ),
                    overwriteSpecificationInsteadOfFailing: false
                  )
                } catch {
                  XCTFail("Failed to load source.")
                }
              #endif
            }
          }
        }
      #endif
    #endif
  }

  func testXcodeError() {
    struct StandInError: PresentableError {
      func presentableDescription() -> StrictString {
        return "[...]"
      }
    }
    testCustomStringConvertibleConformance(
      of: Xcode.CoverageReportingError.xcodeError(
        .locationError(.unavailable(versionConstraints: "..."))
      ),
      localizations: InterfaceLocalization.self,
      uniqueTestName: "Xcode Unavailable",
      overwriteSpecificationInsteadOfFailing: false
    )
    testCustomStringConvertibleConformance(
      of: Xcode.SchemeError.noPackageScheme,
      localizations: InterfaceLocalization.self,
      uniqueTestName: "No Package Scheme",
      overwriteSpecificationInsteadOfFailing: false
    )
    testCustomStringConvertibleConformance(
      of: Xcode.CoverageReportingError.corruptTestCoverageReport,
      localizations: InterfaceLocalization.self,
      uniqueTestName: "Corrupt Test Coverage",
      overwriteSpecificationInsteadOfFailing: false
    )
    testCustomStringConvertibleConformance(
      of: Xcode.CoverageReportingError.foundationError(StandInError()),
      localizations: InterfaceLocalization.self,
      uniqueTestName: "Foundation",
      overwriteSpecificationInsteadOfFailing: false
    )
    testCustomStringConvertibleConformance(
      of: Xcode.CoverageReportingError.xcodeError(
        .locationError(.unavailable(versionConstraints: "..."))
      ),
      localizations: InterfaceLocalization.self,
      uniqueTestName: "Xcode Unavailable",
      overwriteSpecificationInsteadOfFailing: false
    )
    testCustomStringConvertibleConformance(
      of: VersionedExternalProcessExecutionError<Xcode>.executionError(
        .foundationError(StandInError())
      ),
      localizations: InterfaceLocalization.self,
      uniqueTestName: "Foundation",
      overwriteSpecificationInsteadOfFailing: false
    )
    testCustomStringConvertibleConformance(
      of: Xcode.SchemeError.xcodeError(.executionError(.foundationError(StandInError()))),
      localizations: InterfaceLocalization.self,
      uniqueTestName: "Foundation",
      overwriteSpecificationInsteadOfFailing: false
    )
    testCustomStringConvertibleConformance(
      of: Xcode.SchemeError.foundationError(StandInError()),
      localizations: InterfaceLocalization.self,
      uniqueTestName: "Foundation",
      overwriteSpecificationInsteadOfFailing: false
    )
  }

  func testXcodeSDK() {
    for sdk in [
      .macOS, .tvOS(simulator: false), .tvOS(simulator: true), .iOS(simulator: false),
      .iOS(simulator: true), .watchOS(simulator: false), .watchOS(simulator: true),
    ] as [Xcode.Platform] {
      _ = sdk.commandLineSDKName
      _ = sdk.commandLineBuildDestinationPlatformName
    }
  }
}
