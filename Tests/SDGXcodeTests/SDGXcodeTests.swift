/*
 SDGXcodeTests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGCollections
import SDGExternalProcess

import SDGPersistenceTestUtilities
import SDGLocalizationTestUtilities
import SDGXCTestUtilities

import SDGSwift
import SDGXcode
import SDGSwiftLocalizations

import SDGSwiftTestUtilities

class SDGXcodeTests : TestCase {

    func testXcode() {
        #if !os(Linux)
        do {
            try Xcode.runCustomSubcommand(["\u{2D}version"])
        } catch {
            XCTFail("Could not locate Xcode.")
        }

        withDefaultMockRepository { mock in
            try mock.generateXcodeProject()
            XCTAssertNotNil(try mock.xcodeProject(), "Failed to locate Xcode project.")
            XCTAssertNotNil(try mock.scheme(), "Failed to locate Xcode scheme.")

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
                do {
                    var log = Set<String>() // Xcode’s order is not deterministic.
                    try mock.build(for: sdk) { outputLine in
                        if let abbreviated = Xcode.abbreviate(output: outputLine) {
                            XCTAssert(abbreviated.count < 100 ∨ abbreviated.contains("warning:"), "Output is too long: " + abbreviated)
                            log.insert(abbreviated)
                        }
                    }

                    let filtered = log.filter({ ¬$0.contains("ld: warning: directory not found for option \u{27}\u{2d}F") }) // Variable Xcode location.
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
                do {
                    var log = Set<String>() // Xcode’s order is not deterministic.
                    try mock.test(on: sdk) { outputLine in
                        if let abbreviated = Xcode.abbreviate(output: outputLine) {
                            XCTAssert(abbreviated.count < 100 ∨ abbreviated.contains("warning:"), "Output is too long: " + abbreviated)
                            log.insert(abbreviated)
                        }
                    }

                    let filtered = log.map({ String($0.scalars.filter({ $0 ∉ CharacterSet.decimalDigits })) }) // Remove dates & times
                    compare(filtered.sorted().joined(separator: "\n"), against: testSpecificationDirectory().appendingPathComponent("Xcode").appendingPathComponent("Test").appendingPathComponent(sdk.commandLineName + ".txt"), overwriteSpecificationInsteadOfFailing: false)
                } catch {
                    XCTFail("\(error)")
                }
            }
        }
        #endif
    }

    func testXcodeError() {
        testCustomStringConvertibleConformance(of: Xcode.Error.unavailable, localizations: InterfaceLocalization.self, uniqueTestName: "Xcode Unavailable", overwriteSpecificationInsteadOfFailing: false)
        testCustomStringConvertibleConformance(of: Xcode.Error.noXcodeProject, localizations: InterfaceLocalization.self, uniqueTestName: "No Xcode Project", overwriteSpecificationInsteadOfFailing: false)
        testCustomStringConvertibleConformance(of: Xcode.Error.noPackageScheme, localizations: InterfaceLocalization.self, uniqueTestName: "No Package Scheme", overwriteSpecificationInsteadOfFailing: false)
    }
}
