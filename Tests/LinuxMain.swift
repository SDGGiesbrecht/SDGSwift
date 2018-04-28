/*
 LinuxMain.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest
@testable import SDGSwiftTests
@testable import SDGSwiftPackageManagerTests
@testable import DocumentationExampleTests
// Not SDGXcodeTests

XCTMain([
    testCase(SDGSwiftTests.allTests),
    testCase(SDGSwiftPackageManagerTests.allTests),
    testCase(ReadMeExampleTests.allTests)
    // Not SDGXcodeTests
])
