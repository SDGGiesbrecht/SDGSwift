/*
 XCTestManifests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest

extension SDGSwiftTests {
    static let __allTests = [
        ("testBuild", testBuild),
        ("testGitError", testGitError),
        ("testLinuxMainGenerationCompatibility", testLinuxMainGenerationCompatibility),
        ("testLocalizations", testLocalizations),
        ("testPackage", testPackage),
        ("testSwiftCompiler", testSwiftCompiler),
        ("testSwiftCompilerError", testSwiftCompilerError),
        ("testVersion", testVersion),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SDGSwiftTests.__allTests),
    ]
}
#endif
