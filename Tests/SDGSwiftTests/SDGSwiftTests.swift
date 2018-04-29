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

    func testBuild() {
        XCTAssertEqual(Build.development, Build.development)
        XCTAssertNotEqual(Build.version(Version(1, 0, 0)), Build.development)
    }

    func testGitError() {
        testCustomStringConvertibleConformance(of: Git.Error.unavailable, localizations: InterfaceLocalization.self, uniqueTestName: "Git Unavailable", overwriteSpecificationInsteadOfFailing: false)
    }

    func testLocalizations() {
        XCTAssert(_InterfaceLocalization.codeSet() ⊆ InterfaceLocalization.codeSet())
    }

    func testPackage() {
        XCTAssert(try Package(url: URL(string: "https://github.com/SDGGiesbrecht/SDGCornerstone")!).versions() ∋ Version(0, 1, 0), "Failed to detect available versions.")
    }

    func testSwiftCompiler() {
        do {
            try SwiftCompiler.runCustomSubcommand(["\u{2D}\u{2D}version"])
        } catch {
            XCTFail("\(error)")
        }

        withDefaultMockRepository { mock in
            try mock.resolve()
            try mock.build()
            #if canImport(ObjectiveC)
            try mock.regenerateTestLists()
            #endif
            if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] == nil {
                // When run from within Xcode, Xcode interferes with the child test process.
                try mock.test()
            }
        }
    }

    func testSwiftCompilerError() {
        testCustomStringConvertibleConformance(of: SwiftCompiler.Error.unavailable, localizations: InterfaceLocalization.self, uniqueTestName: "Unavailable", overwriteSpecificationInsteadOfFailing: false)
    }

    func testVersion() {
        XCTAssertNil(Version(firstIn: "Blah blah blah..."))
    }

    static var allTests = [
        ("testBuild", testBuild),
        ("testGitError", testGitError),
        ("testLocalizations", testLocalizations),
        ("testPackage", testPackage),
        ("testSwiftCompiler", testSwiftCompiler),
        ("testSwiftCompilerError", testSwiftCompilerError),
        ("testVersion", testVersion)
    ]
}
