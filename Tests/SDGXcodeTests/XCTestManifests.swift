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

extension SDGXcodeTests {
    static let __allTests = [
        ("testLinuxMainGenerationCompatibility", testLinuxMainGenerationCompatibility),
        ("testXcode", testXcode),
        ("testXcodeCoverage", testXcodeCoverage),
        ("testXcodeError", testXcodeError)
    ]
}

#if !canImport(ObjectiveC)
// MARK: - #if !canImport(ObjectiveC)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SDGXcodeTests.__allTests)
    ]
}
#endif
