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

import TestUtilities

class SDGSwiftTests : TestCase {

    func testGitError() {
        testCustomStringConvertibleConformance(of: Git.Error.unavailable, localizations: InterfaceLocalization.self, uniqueTestName: "Git Unavailable", overwriteSpecificationInsteadOfFailing: false)
    }

    func testLocalizations() {
        XCTAssert(_InterfaceLocalization.codeSet() ⊆ InterfaceLocalization.codeSet())
    }

    func testSwiftCompiler() {
        withDefaultMockRepository { mock in
            try mock.resolve()
            try mock.build()
            if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] == nil {
                // When run from within Xcode, Xcode interferes with the child test process.
                try mock.test()
            }
        }
    }

    func testSwiftCompilerError() {
        testCustomStringConvertibleConformance(of: SwiftCompiler.Error.unavailable, localizations: InterfaceLocalization.self, uniqueTestName: "Unavailable", overwriteSpecificationInsteadOfFailing: false)
    }

    static var allTests = [
        ("testGitError", testGitError),
        ("testLocalizations", testLocalizations),
        ("testSwiftCompiler", testSwiftCompiler),
        ("testSwiftCompilerError", testSwiftCompilerError)
    ]
}
