/*
 XCTestManifests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !canImport(ObjectiveC)
import XCTest

extension ReadMeExampleTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__ReadMeExampleTests = [
        ("testLinuxMainGenerationCompatibility", testLinuxMainGenerationCompatibility),
        ("testReadMe", testReadMe),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ReadMeExampleTests.__allTests__ReadMeExampleTests),
    ]
}
#endif
