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

extension SDGSwiftAPITests {
    static let __allTests = [
        ("testBuild", testBuild),
        ("testGit", testGit),
        ("testGitError", testGitError),
        ("testLinuxMainGenerationCompatibility", testLinuxMainGenerationCompatibility),
        ("testLocalizations", testLocalizations),
        ("testPackage", testPackage),
        ("testPackageError", testPackageError),
        ("testPackageRepository", testPackageRepository),
        ("testSwiftCompiler", testSwiftCompiler),
        ("testSwiftCompilerError", testSwiftCompilerError),
        ("testVersion", testVersion)
    ]
}

extension SDGSwiftRegressionTests {
    static let __allTests = [
        ("testDynamicLinking", testDynamicLinking),
        ("testLinuxMainGenerationCompatibility", testLinuxMainGenerationCompatibility)
    ]
}

#if !canImport(ObjectiveC)
// MARK: - #if !canImport(ObjectiveC)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SDGSwiftAPITests.__allTests),
        testCase(SDGSwiftRegressionTests.__allTests)
    ]
}
#endif
