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
        #if !os(Linux)
        try withMock(named: "DependentOnWarnings", dependentOn: ["Warnings"]) { package in
            try package.generateXcodeProject()
            let build = try package.build(for: .macOS)
            XCTAssertFalse(Xcode.warningsOccurred(during: build))
        }
        #endif
    }

    func testXcode() {
        let sdks: [Xcode.SDK] = [
            .macOS,
            .iOS(simulator: false),
            .iOS(simulator: true),
            .watchOS,
            .tvOS(simulator: false),
            .tvOS(simulator: true)
        ]

        #if os(Linux)

        withDefaultMockRepository { mock in
            XCTAssertNil(try? mock.xcodeProject())
            XCTAssertNil(try? mock.scheme())
            XCTAssertNil(try? mock.generateXcodeProject())
            for sdk in sdks {
                XCTAssertNil(try? mock.build(for: sdk))
                XCTAssertNil(try? mock.codeCoverageReport(on: sdk))
                XCTAssertNil(try? mock.derivedData(for: sdk))
            }
        }

        #else

        do {
            try Xcode.runCustomSubcommand(["\u{2D}version"])
        } catch {
            XCTFail("Could not locate Xcode.")
        }
        XCTAssertNotNil(try? Xcode.location())

        withDefaultMockRepository { mock in
            try mock.generateXcodeProject()
            XCTAssertNotNil(try mock.xcodeProject(), "Failed to locate Xcode project.")
            XCTAssertNotNil(try mock.scheme(), "Failed to locate Xcode scheme.")

            for sdk in sdks {
                print("Testing build for \(sdk.commandLineName)...")

                if let derived = try? mock.derivedData(for: sdk) {
                    try? FileManager.default.removeItem(at: derived)
                }

                do {
                    var log = Set<String>() // Xcode’s order is not deterministic.
                    try mock.build(for: sdk) { outputLine in
                        if let abbreviated = Xcode.abbreviate(output: outputLine) {
                            XCTAssert(abbreviated.count < 100
                                ∨ abbreviated.contains("warning:")
                                ∨ abbreviated.contains("error:"),
                                      "Output is too long: " + abbreviated)
                            log.insert(abbreviated)
                        }
                    }

                    var filtered = log.filter({ ¬$0.contains("ld: warning: directory not found for option \u{27}\u{2d}F") ∧ ¬$0.contains("SDKROOT =") ∧ $0 ≠ "ld: warning: " }) // Variable Xcode location and version.
                    filtered = filtered.filter({ ¬$0.hasPrefix("xcodebuild: MessageTracer: Falling back to default whitelist") }) // Depends on external code signing settings.
                    filtered = filtered.filter({ ¬$0.hasPrefix("codesign: [") }) // Depends on external code signing settings.
                    compare(filtered.sorted().joined(separator: "\n"), against: testSpecificationDirectory().appendingPathComponent("Xcode").appendingPathComponent("Build").appendingPathComponent(sdk.commandLineName + ".txt"), overwriteSpecificationInsteadOfFailing: false)
                } catch {
                    XCTFail("\(error)")
                }
            }

            let testSDKs: [Xcode.SDK] = [
                .macOS
                // .iOS(simulator: true), // Unavailable in CI.
                // .tvOS(simulator: true), // Unavailable in CI.
            ]
            for sdk in testSDKs {
                print("Testing testing on \(sdk.commandLineName)...")

                if let derived = try? mock.derivedData(for: sdk) {
                    try? FileManager.default.removeItem(at: derived)
                }

                do {
                    var log = Set<String>() // Xcode’s order is not deterministic.
                    try mock.test(on: sdk) { outputLine in
                        if let abbreviated = Xcode.abbreviate(output: outputLine) {
                            XCTAssert(abbreviated.count < 100
                                ∨ abbreviated.contains("warning:")
                                ∨ abbreviated.contains("error:")
                                ∨ abbreviated.contains("Failed"),
                                      "Output is too long: " + abbreviated)
                            log.insert(abbreviated)
                        }
                    }

                    var filtered = log.map({ String($0.scalars.filter({ $0 ∉ CharacterSet.decimalDigits })) }) // Remove dates & times
                    filtered = filtered.filter({ ¬$0.contains("Executed  test, with  failures") }) // Inconsistent number of occurrences. (???)
                    filtered = filtered.filter({ ¬$0.hasPrefix("CreateBuildDirectory ") }) // Inconsistent which target some directories are first created for.
                    filtered = filtered.filter({ ¬$0.hasPrefix("xcodebuild: MessageTracer: Falling back to default whitelist") }) // Depends on external code signing settings.
                    filtered = filtered.filter({ ¬$0.hasPrefix("codesign: [") }) // Depends on external code signing settings.
                    compare(filtered.sorted().joined(separator: "\n"), against: testSpecificationDirectory().appendingPathComponent("Xcode").appendingPathComponent("Test").appendingPathComponent(sdk.commandLineName + ".txt"), overwriteSpecificationInsteadOfFailing: false)
                } catch {
                    XCTFail("\(error)")
                }
            }
        }

        XCTAssert(¬Xcode.warningsOccurred(during: ""))
        #endif
    }

    func testXcodeCoverage() {
        #if !os(Linux)
        do {
            try Xcode.runCustomCoverageSubcommand(["help"])
        } catch {
            XCTFail("\(error)")
        }

        withDefaultMockRepository { mock in
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
            try mock.test(on: .macOS)
            guard let coverageReport = try mock.codeCoverageReport(on: .macOS, ignoreCoveredRegions: true) else {
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
        }
        #endif
    }

    func testXcodeError() {
        testCustomStringConvertibleConformance(of: Xcode.Error.unavailable, localizations: InterfaceLocalization.self, uniqueTestName: "Xcode Unavailable", overwriteSpecificationInsteadOfFailing: false)
        testCustomStringConvertibleConformance(of: Xcode.Error.noXcodeProject, localizations: InterfaceLocalization.self, uniqueTestName: "No Xcode Project", overwriteSpecificationInsteadOfFailing: false)
        testCustomStringConvertibleConformance(of: Xcode.Error.noPackageScheme, localizations: InterfaceLocalization.self, uniqueTestName: "No Package Scheme", overwriteSpecificationInsteadOfFailing: false)
        testCustomStringConvertibleConformance(of: Xcode.Error.noBuildDirectory, localizations: InterfaceLocalization.self, uniqueTestName: "No Build Directory", overwriteSpecificationInsteadOfFailing: false)
        testCustomStringConvertibleConformance(of: Xcode.Error.corruptTestCoverageReport, localizations: InterfaceLocalization.self, uniqueTestName: "Corrupt Test Coverage", overwriteSpecificationInsteadOfFailing: false)
    }
}
