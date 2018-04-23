/*
 SDGSwiftTests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections
import SDGLocalization
import SDGLocalizationTestUtilities
import SDGXCTestUtilities

import SDGSwiftLocalizations
import SDGSwift

let thisRepository = URL(fileURLWithPath: #file).deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent()

class SDGSwiftTests : TestCase {

    func testLocalizations() {
        XCTAssert(_InterfaceLocalization.codeSet() ⊆ InterfaceLocalization.codeSet())
    }

    func testSwiftCompiler() {
        do {
            try SwiftCompiler.build(thisRepository, reportProgress: { _ in })
        } catch {
            XCTFail("\(error)")
        }
    }

    func testSwiftCompilerError() {
        testCustomStringConvertibleConformance(of: SwiftCompiler.Error.unavailable, localizations: InterfaceLocalization.self, uniqueTestName: "Unavailable", overwriteSpecificationInsteadOfFailing: false)
    }

    static var allTests = [
        ("testLocalizations", testLocalizations),
        ("testSwiftCompiler", testSwiftCompiler),
        ("testSwiftCompilerError", testSwiftCompilerError)
    ]
}
