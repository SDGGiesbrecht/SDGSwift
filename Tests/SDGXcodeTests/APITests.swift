/*
 APITests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

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
    #if !os(Windows)  // #workaround(Swift 5.3, No package manager on Windows yet.)
      for withGeneratedProject in [false, true] {
        try withMock(named: "DependentOnWarnings", dependentOn: ["Warnings"]) { package in
          #if !os(Android)  // #workaround(workspace version 0.35.2, Emulator lacks Swift.)
            if withGeneratedProject {
              _ = try package.generateXcodeProject().get()
            }
            #if !(os(Windows) || os(Linux))
              let build = try package.build(for: .macOS).get()
              XCTAssertFalse(
                Xcode.warningsOccurred(during: build),
                "Warning triggered in:\n\(build)"
              )
            #endif
          #endif
        }
      }
    #endif
  }

  func testSwiftCompiler() {
    // #workaround(Swift 5.3.1, Segmentation fault.)
    #if !os(Windows)
      FileManager.default.withTemporaryDirectory(appropriateFor: nil) { directory in
        let url = directory.appendingPathComponent("no such URL")
        let package = PackageRepository(at: url)
        _ = try? SwiftCompiler.generateXcodeProject(for: package).get()
      }
    #endif
  }

  func testXcode() throws {
    let noProject = PackageRepository(
      at: thisRepository.location.appendingPathComponent("Sources")
    )
    XCTAssertNil(try noProject.xcodeProject())

    #if os(Windows) || os(Linux) || os(Android)
      _ = try? Xcode.runCustomSubcommand(
        ["\u{2D}version"],
        versionConstraints: Version(Int.min)...Version(Int.max)
      ).get()
    #else
      _ = try Xcode.runCustomSubcommand(
        ["\u{2D}version"],
        versionConstraints: Version(Int.min)...Version(Int.max)
      ).get()
    #endif
    let xcodeLocation = try? Xcode.location(
      versionConstraints: Version(Int.min)...Version(Int.max)
    ).get()
    #if !(os(Windows) || os(Linux) || os(Android))
      XCTAssertNotNil(xcodeLocation)
    #endif

    // #workaround(Swift 5.3, SwiftPM won’t compile.)
    #if !(os(Windows) || os(Android))
      try withDefaultMockRepository { mock in
        for withGeneratedProject in [false, true] {
          if withGeneratedProject {
            _ = try mock.generateXcodeProject().get()
          }

          if withGeneratedProject {
            XCTAssertNotNil(try mock.xcodeProject(), "Failed to locate Xcode project.")
          }
          let mockScheme = try? mock.scheme().get()
          #if !os(Linux)
            XCTAssertNotNil(mockScheme, "Failed to locate Xcode scheme.")
          #endif

          var sdks: [Xcode.SDK] = [
            .macOS,
            .iOS(simulator: false),
            .iOS(simulator: true),
            .watchOS,
            .tvOS(simulator: false),
            .tvOS(simulator: true),
          ]
          if ¬withGeneratedProject {
            // #workaround(xcodebuild -version 12.1, watchOS cannot handle test targets.) @exempt(from: unicode)
            sdks.removeAll(where: { $0 == .watchOS })
          }
          for sdk in sdks {
            print("Testing build for \(sdk.commandLineName)...")

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
            #if os(Linux)
              _ = try? mock.build(for: sdk, reportProgress: processLog).get()
            #else
              _ = try mock.build(for: sdk, reportProgress: processLog).get()
            #endif

            // Variable Xcode location and version:
            var filtered: [String] = log.filter({
              ¬$0.contains("ld: warning: directory not found for option \u{27}\u{2d}F")
                ∧ ¬$0.contains("SDKROOT =") ∧ $0 ≠ "ld: warning: "
            })
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
            #if !os(Linux)
              compare(
                filtered.sorted().joined(separator: "\n"),
                against: testSpecificationDirectory()
                  .appendingPathComponent("Xcode")
                  .appendingPathComponent("Build" + (withGeneratedProject ? "" : " Package"))
                  .appendingPathComponent(sdk.commandLineName + ".txt"),
                overwriteSpecificationInsteadOfFailing: false
              )
            #endif
          }

          var testSDKs: [Xcode.SDK] = [
            .macOS
          ]
          if ProcessInfo.processInfo.environment["TRAVIS"] == nil {  // Unavailable in CI.
            testSDKs.append(contentsOf: [
              .iOS(simulator: true),
              .tvOS(simulator: true),
            ])
          }
          for sdk in testSDKs {
            print("Testing testing on \(sdk.commandLineName)...")

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
            #if os(Linux)
              _ = try? mock.test(on: sdk, reportProgress: processLog).get()
            #else
              _ = try mock.test(on: sdk, reportProgress: processLog).get()
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
            #if !os(Linux)
              compare(
                filtered.sorted().joined(separator: "\n"),
                against: testSpecificationDirectory()
                  .appendingPathComponent("Xcode")
                  .appendingPathComponent("Test" + (withGeneratedProject ? "" : " Package"))
                  .appendingPathComponent(sdk.commandLineName + ".txt"),
                overwriteSpecificationInsteadOfFailing: false
              )
            #endif
          }
        }
      }
    #endif

    XCTAssert(¬Xcode.warningsOccurred(during: ""))

    // #workaround(Swift 5.3, SwiftPM won’t compile.)
    #if !(os(Windows) || os(Android))
      try withDefaultMockRepository { package in
        _ = try? Xcode.build(package, for: .iOS(simulator: false)).get()
        _ = try? Xcode.test(package, on: .iOS(simulator: true)).get()
        _ = try? Xcode.codeCoverageReport(for: package, on: .iOS(simulator: true)).get()
      }
    #endif
  }

  func testXcodeCoverage() throws {
    #if os(Windows) || os(Linux) || os(Android)
      _ = try? Xcode.runCustomCoverageSubcommand(
        ["help"],
        versionConstraints: Version(0)..<Version(100)
      ).get()
    #else
      _ = try Xcode.runCustomCoverageSubcommand(
        ["help"],
        versionConstraints: Version(0)..<Version(100)
      ).get()
    #endif

    // #workaround(Swift 5.3, SwiftPM won’t compile.)
    #if !(os(Windows) || os(Android))
      try withDefaultMockRepository { mock in
        for withGeneratedProject in [false, true] {

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

          if withGeneratedProject {
            _ = try mock.generateXcodeProject().get()
          }
          #if os(Linux)
            _ = try? mock.test(on: .macOS).get()
          #else
            _ = try mock.test(on: .macOS).get()
          #endif
          for localization in InterfaceLocalization.allCases {
            LocalizationSetting(orderOfPrecedence: [localization.code]).do {
              let possibleReport = try? mock.codeCoverageReport(
                on: .macOS,
                ignoreCoveredRegions: true
              ).get()
              #if !os(Linux)
                guard let coverageReport = possibleReport else {
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
                    specification.insert("!", at: specification.index(of: range.region.upperBound))
                    specification.insert("¡", at: specification.index(of: range.region.lowerBound))
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
      }
    #endif
  }

  func testXcodeError() {
    struct StandInError: PresentableError {
      func presentableDescription() -> StrictString {
        return "[...]"
      }
    }
    // #workaround(Swift 5.3, SwiftPM won’t compile.)
    #if !(os(Windows) || os(Android))
      testCustomStringConvertibleConformance(
        of: Xcode.CoverageReportingError.xcodeError(
          .locationError(.unavailable(versionConstraints: "..."))
        ),
        localizations: InterfaceLocalization.self,
        uniqueTestName: "Xcode Unavailable",
        overwriteSpecificationInsteadOfFailing: false
      )
    #endif
    testCustomStringConvertibleConformance(
      of: Xcode.SchemeError.noPackageScheme,
      localizations: InterfaceLocalization.self,
      uniqueTestName: "No Package Scheme",
      overwriteSpecificationInsteadOfFailing: false
    )
    // #workaround(Swift 5.3, SwiftPM won’t compile.)
    #if !(os(Windows) || os(Android))
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
    #endif
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
}
