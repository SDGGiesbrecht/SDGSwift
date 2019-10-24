/*
 APITests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

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

import SDGSwift
import SDGXcode

import SDGSwiftLocalizations

import XCTest

import SDGPersistenceTestUtilities
import SDGLocalizationTestUtilities
import SDGXCTestUtilities

import SDGSwiftTestUtilities

class APITests : TestCase {

    func testDependencyWarnings() throws {
        for withGeneratedProject in [false, true] {
            try withMock(named: "DependentOnWarnings", dependentOn: ["Warnings"]) { package in
                if withGeneratedProject {
                    _ = try package.generateXcodeProject().get()
                }
                #if !os(Linux)
                let build = try package.build(for: .macOS).get()
                XCTAssertFalse(Xcode.warningsOccurred(during: build))
                #endif
            }
        }
    }

    func testXcode() throws {
        #if os(Linux)
        _ = try? Xcode.runCustomSubcommand(["\u{2D}version"]).get()
        #else
        _ = try Xcode.runCustomSubcommand(["\u{2D}version"]).get()
        #endif
        let xcodeLocation = try? Xcode.location().get()
        #if !os(Linux)
        XCTAssertNotNil(xcodeLocation)
        #endif

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
                    .tvOS(simulator: true)
                ]
                if ¬withGeneratedProject {
                    // #workaround(xcodebuild -version 11.1, WatchOS cannot handle test targets.)
                    sdks.removeAll(where: { $0 == .watchOS })
                }
                for sdk in sdks {
                    print("Testing build for \(sdk.commandLineName)...")

                    let derived = mock.stableDerivedData
                    try? FileManager.default.removeItem(at: derived)

                    var log = Set<String>() // Xcode’s order is not deterministic.
                    let processLog: (String) -> Void = { outputLine in
                        if let abbreviated = Xcode.abbreviate(output: outputLine) {
                            XCTAssert(abbreviated.count < 100
                                ∨ abbreviated.contains("warning:")
                                ∨ abbreviated.contains("error:")
                                ∨ abbreviated.contains("note:"),
                                      "Output is too long: " + abbreviated)
                            log.insert(abbreviated)
                        }
                    }
                    #if os(Linux)
                    _ = try? mock.build(for: sdk, derivedData: derived, reportProgress: processLog).get()
                    #else
                    _ = try mock.build(for: sdk, derivedData: derived, reportProgress: processLog).get()
                    #endif

                    var filtered = log.filter({ ¬$0.contains("ld: warning: directory not found for option \u{27}\u{2d}F") ∧ ¬$0.contains("SDKROOT =") ∧ $0 ≠ "ld: warning: " }) // Variable Xcode location and version.
                    filtered = filtered.filter({ ¬$0.hasPrefix("xcodebuild: MessageTracer: Falling back to default whitelist") }) // Depends on external code signing settings.
                    filtered = filtered.filter({ ¬$0.hasPrefix("codesign: [") }) // Depends on external code signing settings.
                    #if !os(Linux)
                    compare(
                        filtered.sorted().joined(separator: "\n"),
                        against: testSpecificationDirectory()
                            .appendingPathComponent("Xcode")
                            .appendingPathComponent("Build" + (withGeneratedProject ? "" : " Package"))
                            .appendingPathComponent(sdk.commandLineName + ".txt"),
                        overwriteSpecificationInsteadOfFailing: false)
                    #endif
                }

                var testSDKs: [Xcode.SDK] = [
                    .macOS
                ]
                if ProcessInfo.processInfo.environment["TRAVIS"] == nil { // Unavailable in CI.
                    testSDKs.append(contentsOf: [
                        .iOS(simulator: true),
                        .tvOS(simulator: true)
                    ])
                }
                for sdk in testSDKs {
                    print("Testing testing on \(sdk.commandLineName)...")

                    let derived = mock.stableDerivedData
                    try? FileManager.default.removeItem(at: derived)

                    var log = Set<String>() // Xcode’s order is not deterministic.
                    let processLog: (String) -> Void = { outputLine in
                        if let abbreviated = Xcode.abbreviate(output: outputLine) {
                            XCTAssert(abbreviated.count < 100
                                ∨ abbreviated.contains("warning:")
                                ∨ abbreviated.contains("error:")
                                ∨ abbreviated.contains("Failed")
                                ∨ abbreviated.contains("note:")
                                ∨ abbreviated.contains("failed")
                                ∨ abbreviated.contains("bug")
                                ∨ abbreviated.contains("Promise")
                                ∨ abbreviated.contains("Warning")
                                ∨ abbreviated.hasPrefix("$ "),
                                      "Output is too long: " + abbreviated)
                            log.insert(abbreviated)
                        }
                    }
                    #if os(Linux)
                    _ = try? mock.test(on: sdk, derivedData: derived, reportProgress: processLog).get()
                    #else
                    _ = try mock.test(on: sdk, derivedData: derived, reportProgress: processLog).get()
                    #endif

                    var filtered = log.map({ String($0.scalars.filter({ $0 ∉ CharacterSet.decimalDigits })) }) // Remove dates & times
                    filtered = log.map({ $0.truncated(after: "-derivedDataPath") }) // Inconsistent path.
                    filtered = filtered.filter({ ¬$0.contains("Executed  test, with  failures") }) // Inconsistent number of occurrences. (???)
                    filtered = filtered.filter({ ¬$0.hasPrefix("CreateBuildDirectory ") }) // Inconsistent which target some directories are first created for.
                    filtered = filtered.filter({ ¬$0.hasPrefix("xcodebuild: MessageTracer: Falling back to default whitelist") }) // Depends on external code signing settings.
                    filtered = filtered.filter({ ¬$0.hasPrefix("codesign: [") }) // Depends on external code signing settings.
                    filtered = filtered.filter({ ¬$0.contains("<DVTiPhoneSimulator:") }) // Inconsistent identifiers.
                    filtered = filtered.filter({ ¬$0.contains(" Promise ") }) // Inconsistent identifiers.
                    filtered = filtered.filter({ ¬$0.contains("<NSThread:") }) // Inconsistent identifiers.
                    filtered = filtered.filter({ ¬$0.contains("IDEDerivedDataPathOverride") }) // Inconsistent user.
                    #if !os(Linux)
                    compare(
                        filtered.sorted().joined(separator: "\n"),
                        against: testSpecificationDirectory()
                            .appendingPathComponent("Xcode")
                            .appendingPathComponent("Test" + (withGeneratedProject ? "" : " Package"))
                            .appendingPathComponent(sdk.commandLineName + ".txt"),
                        overwriteSpecificationInsteadOfFailing: false)
                    #endif
                }
            }
        }

        XCTAssert(¬Xcode.warningsOccurred(during: ""))
    }

    func testXcodeCoverage() throws {
        #if os(Linux)
        _ = try? Xcode.runCustomCoverageSubcommand(["help"]).get()
        #else
        _ = try Xcode.runCustomCoverageSubcommand(["help"]).get()
        #endif

        try withDefaultMockRepository { mock in
            for withGeneratedProject in [false, true] {
                let derivedData = mock.stableDerivedData

                let coverageFiles = thisRepository.location.appendingPathComponent("Tests/Test Specifications/Test Coverage")
                let sourceURL = coverageFiles.appendingPathComponent("Source.swift")
                let sourceDestination = mock.location.appendingPathComponent("Sources/Mock/Mock.swift")
                let testDestination = mock.location.appendingPathComponent("Tests/MockTests/MockTests.swift")
                try? FileManager.default.removeItem(at: sourceDestination)
                try FileManager.default.copy(
                    sourceURL,
                    to: sourceDestination)
                try? FileManager.default.removeItem(at: testDestination)
                try FileManager.default.copy(
                    coverageFiles.appendingPathComponent("Tests.swift"),
                    to: testDestination)

                if withGeneratedProject {
                    _ = try mock.generateXcodeProject().get()
                }
                #if os(Linux)
                _ = try? mock.test(on: .macOS, derivedData: derivedData).get()
                #else
                _ = try mock.test(on: .macOS, derivedData: derivedData).get()
                #endif
                for localization in InterfaceLocalization.allCases {
                    LocalizationSetting(orderOfPrecedence: [localization.code]).do {
                        let possibleReport = try? mock.codeCoverageReport(
                            on: .macOS,
                            derivedData: derivedData,
                            ignoreCoveredRegions: true).get()
                        #if !os(Linux)
                        guard let coverageReport = possibleReport else {
                            XCTFail("No test coverage report found.")
                            return
                        }
                        guard let file = coverageReport.files.first(where: { $0.file.lastPathComponent == "Mock.swift" }) else {
                            XCTFail("File missing from coverage report.")
                            return
                        }
                        do {
                            var specification = try String(from: sourceURL)
                            for range in file.regions.reversed() {
                                specification.insert("!", at: range.region.upperBound)
                                specification.insert("¡", at: range.region.lowerBound)
                            }
                            compare(specification, against: testSpecificationDirectory().appendingPathComponent("Coverage (Xcode).txt"), overwriteSpecificationInsteadOfFailing: false)
                        } catch {
                            XCTFail("Failed to load source.")
                        }
                        #endif
                    }
                }
            }
        }
    }

    func testXcodeError() {
        struct StandInError : PresentableError {
            func presentableDescription() -> StrictString {
                return "[...]"
            }
        }
        testCustomStringConvertibleConformance(of: Xcode.CoverageReportingError.buildDirectoryError(.schemeError(.xcodeError(.locationError(.unavailable)))), localizations: InterfaceLocalization.self, uniqueTestName: "Xcode Unavailable", overwriteSpecificationInsteadOfFailing: false)
        testCustomStringConvertibleConformance(of: Xcode.CoverageReportingError.buildDirectoryError(.schemeError(.noXcodeProject)), localizations: InterfaceLocalization.self, uniqueTestName: "No Xcode Project", overwriteSpecificationInsteadOfFailing: false)
        testCustomStringConvertibleConformance(of: Xcode.CoverageReportingError.buildDirectoryError(.schemeError(.noPackageScheme)), localizations: InterfaceLocalization.self, uniqueTestName: "No Package Scheme", overwriteSpecificationInsteadOfFailing: false)
        testCustomStringConvertibleConformance(of: Xcode.CoverageReportingError.buildDirectoryError(.noBuildDirectory), localizations: InterfaceLocalization.self, uniqueTestName: "No Build Directory", overwriteSpecificationInsteadOfFailing: false)
        testCustomStringConvertibleConformance(of: Xcode.CoverageReportingError.corruptTestCoverageReport, localizations: InterfaceLocalization.self, uniqueTestName: "Corrupt Test Coverage", overwriteSpecificationInsteadOfFailing: false)
        testCustomStringConvertibleConformance(of: Xcode.CoverageReportingError.packageManagerError(.packageManagerError(StandInError(), [])), localizations: InterfaceLocalization.self, uniqueTestName: "Package Manager", overwriteSpecificationInsteadOfFailing: false)
        testCustomStringConvertibleConformance(of: Xcode.CoverageReportingError.foundationError(StandInError()), localizations: InterfaceLocalization.self, uniqueTestName: "Foundation", overwriteSpecificationInsteadOfFailing: false)
        testCustomStringConvertibleConformance(of: Xcode.CoverageReportingError.xcodeError(.locationError(.unavailable)), localizations: InterfaceLocalization.self, uniqueTestName: "Xcode Unavailable", overwriteSpecificationInsteadOfFailing: false)
        testCustomStringConvertibleConformance(of: Xcode.Error.executionError(.foundationError(StandInError())), localizations: InterfaceLocalization.self, uniqueTestName: "Foundation", overwriteSpecificationInsteadOfFailing: false)
        testCustomStringConvertibleConformance(of: Xcode.SchemeError.foundationError(StandInError()), localizations: InterfaceLocalization.self, uniqueTestName: "Foundation", overwriteSpecificationInsteadOfFailing: false)
    }
}
