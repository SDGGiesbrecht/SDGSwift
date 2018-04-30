/*
 SDGXcodeTests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLocalizationTestUtilities
import SDGXCTestUtilities

import SDGSwift
import SDGXcode
import SDGSwiftLocalizations

import SDGSwiftTestUtilities

class SDGXcodeTests : TestCase {

    func testXcode() {
        do {
            try Xcode.runCustomSubcommand(["\u{2D}version"])
        } catch {
            XCTFail("Could not locate Xcode.")
        }
    }

    func testXcodeError() {
        testCustomStringConvertibleConformance(of: Xcode.Error.unavailable, localizations: InterfaceLocalization.self, uniqueTestName: "Xcode Unavailable", overwriteSpecificationInsteadOfFailing: false)
    }

    func testXcodeProjectDetection() {
        withDefaultMockRepository { mock in
            try mock.generateXcodeProject()
            XCTAssertNotNil(try mock.xcodeProject(), "Failed to locate Xcode project.")
        }
    }

    static var allTests = [
        ("testXcode", testXcode),
        ("testXcodeError", testXcodeError),
        ("testXcodeProjectDetection", testXcodeProjectDetection)
    ]
}
