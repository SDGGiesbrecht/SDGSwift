/*
 SDGXcodeTests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGCollections
import SDGPersistence
import SDGExternalProcess

import SDGPersistenceTestUtilities
import SDGLocalizationTestUtilities
import SDGXCTestUtilities

import SDGSwift
import SDGXcode
import SDGSwiftLocalizations

import SDGSwiftTestUtilities

class SDGXcodeTests : TestCase {

    func testDependencyWarnings() throws {
        try withMock(named: "DependentOnWarnings", dependentOn: ["Warnings"]) { package in
            try package.generateXcodeProject()
            #if !os(Linux)
            let build = try package.build(for: .macOS).get()
            XCTAssertFalse(Xcode.warningsOccurred(during: build))
            #endif
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
            try mock.generateXcodeProject()
            XCTAssertNotNil(try mock.xcodeProject(), "Failed to locate Xcode project.")
            let mockScheme = try? mock.scheme().get()
            #if !os(Linux)
            XCTAssertNotNil(mockScheme, "Failed to locate Xcode scheme.")
            #endif

            let sdks: [Xcode.SDK] = [
                .macOS,
                .iOS(simulator: false),
                .iOS(simulator: true),
                .watchOS,
                .tvOS(simulator: false),
                .tvOS(simulator: true)
            ]
            for sdk in sdks {
                print("Testing build for \(sdk.commandLineName)...")

                if let derived = try? mock.derivedData(for: sdk).get() {
                    try? FileManager.default.removeItem(at: derived)
                }

                var log = Set<String>() // Xcode’s order is not deterministic.
                let processLog: (String) -> Void = { outputLine in
                    if let abbreviated = Xcode.abbreviate(output: outputLine) {
                        XCTAssert(abbreviated.count < 100
                            ∨ abbreviated.contains("warning:")
                            ∨ abbreviated.contains("error:"),
                                  "Output is too long: " + abbreviated)
                        log.insert(abbreviated)
                    }
                }
                #if os(Linux)
                _ = try? mock.build(for: sdk, reportProgress: processLog).get()
                #else
                _ = try mock.build(for: sdk, reportProgress: processLog).get()
                #endif

                var filtered = log.filter({ ¬$0.contains("ld: warning: directory not found for option \u{27}\u{2d}F") ∧ ¬$0.contains("SDKROOT =") ∧ $0 ≠ "ld: warning: " }) // Variable Xcode location and version.
                filtered = filtered.filter({ ¬$0.hasPrefix("xcodebuild: MessageTracer: Falling back to default whitelist") }) // Depends on external code signing settings.
                filtered = filtered.filter({ ¬$0.hasPrefix("codesign: [") }) // Depends on external code signing settings.
                #if !os(Linux)
                compare(filtered.sorted().joined(separator: "\n"), against: testSpecificationDirectory().appendingPathComponent("Xcode").appendingPathComponent("Build").appendingPathComponent(sdk.commandLineName + ".txt"), overwriteSpecificationInsteadOfFailing: false)
                #endif
            }

            let testSDKs: [Xcode.SDK] = [
                .macOS
                // .iOS(simulator: true), // Unavailable in CI.
                // .tvOS(simulator: true), // Unavailable in CI.
            ]
            for sdk in testSDKs {
                print("Testing testing on \(sdk.commandLineName)...")

                if let derived = try? mock.derivedData(for: sdk).get() {
                    try? FileManager.default.removeItem(at: derived)
                }

                var log = Set<String>() // Xcode’s order is not deterministic.
                let processLog: (String) -> Void = { outputLine in
                    if let abbreviated = Xcode.abbreviate(output: outputLine) {
                        XCTAssert(abbreviated.count < 100
                            ∨ abbreviated.contains("warning:")
                            ∨ abbreviated.contains("error:")
                            ∨ abbreviated.contains("Failed"),
                                  "Output is too long: " + abbreviated)
                        log.insert(abbreviated)
                    }
                }
                #if os(Linux)
                _ = try? mock.test(on: sdk, reportProgress: processLog)
                #else
                try mock.test(on: sdk, reportProgress: processLog)
                #endif

                var filtered = log.map({ String($0.scalars.filter({ $0 ∉ CharacterSet.decimalDigits })) }) // Remove dates & times
                filtered = filtered.filter({ ¬$0.contains("Executed  test, with  failures") }) // Inconsistent number of occurrences. (???)
                filtered = filtered.filter({ ¬$0.hasPrefix("CreateBuildDirectory ") }) // Inconsistent which target some directories are first created for.
                filtered = filtered.filter({ ¬$0.hasPrefix("xcodebuild: MessageTracer: Falling back to default whitelist") }) // Depends on external code signing settings.
                filtered = filtered.filter({ ¬$0.hasPrefix("codesign: [") }) // Depends on external code signing settings.
                #if !os(Linux)
                compare(filtered.sorted().joined(separator: "\n"), against: testSpecificationDirectory().appendingPathComponent("Xcode").appendingPathComponent("Test").appendingPathComponent(sdk.commandLineName + ".txt"), overwriteSpecificationInsteadOfFailing: false)
                #endif
            }
        }

        XCTAssert(¬Xcode.warningsOccurred(during: ""))
    }

    func testXcodeCoverage() throws {
        #if os(Linux)
        _ = try? Xcode.runCustomCoverageSubcommand(["help"])
        #else
        _ = try Xcode.runCustomCoverageSubcommand(["help"]).get()
        #endif

        try withDefaultMockRepository { mock in
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

            try mock.generateXcodeProject()
            #if os(Linux)
            _ = try? mock.test(on: .macOS)
            #else
            try mock.test(on: .macOS).ge
            #endif
            let possibleReport = try? mock.codeCoverageReport(on: .macOS, ignoreCoveredRegions: true).get()
            #if !os(Linux)
            guard let coverageReport = possibleReport else {
                XCTFail("No test coverage report found.")
                return
            }
            guard let file = coverageReport.files.first(where: { $0.file.lastPathComponent == "Mock.swift" }) else {
                XCTFail("File missing from coverage report.")
                return
            }
            var specification = try String(from: sourceURL)
            for range in file.regions.reversed() {
                specification.insert("!", at: range.region.upperBound)
                specification.insert("¡", at: range.region.lowerBound)
            }
            compare(specification, against: testSpecificationDirectory().appendingPathComponent("Coverage (Xcode).txt"), overwriteSpecificationInsteadOfFailing: false)
            #endif
        }
    }

    func testXcodeError() {
        testCustomStringConvertibleConformance(of: Xcode.Error.unavailable, localizations: InterfaceLocalization.self, uniqueTestName: "Xcode Unavailable", overwriteSpecificationInsteadOfFailing: false)
        testCustomStringConvertibleConformance(of: Xcode.Error.noXcodeProject, localizations: InterfaceLocalization.self, uniqueTestName: "No Xcode Project", overwriteSpecificationInsteadOfFailing: false)
        testCustomStringConvertibleConformance(of: Xcode.Error.noPackageScheme, localizations: InterfaceLocalization.self, uniqueTestName: "No Package Scheme", overwriteSpecificationInsteadOfFailing: false)
        testCustomStringConvertibleConformance(of: Xcode.Error.noBuildDirectory, localizations: InterfaceLocalization.self, uniqueTestName: "No Build Directory", overwriteSpecificationInsteadOfFailing: false)
        testCustomStringConvertibleConformance(of: Xcode.Error.corruptTestCoverageReport, localizations: InterfaceLocalization.self, uniqueTestName: "Corrupt Test Coverage", overwriteSpecificationInsteadOfFailing: false)
    }
}
