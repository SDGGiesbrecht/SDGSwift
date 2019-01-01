/*
 XCTestManifests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest

extension SDGSwiftConfigurationAPITests {
    static let __allTests = [
        ("testConfiguration", testConfiguration),
        ("testConfigurationError", testConfigurationError),
        ("testLinuxMainGenerationCompatibility", testLinuxMainGenerationCompatibility)
    ]
}

#if !canImport(ObjectiveC)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SDGSwiftConfigurationAPITests.__allTests)
    ]
}
#endif
