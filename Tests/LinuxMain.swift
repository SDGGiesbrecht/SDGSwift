/*
 LinuxMain.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest

import SDGSwiftConfigurationTests
import SDGSwiftDocumentationExampleTests
import SDGSwiftPackageManagerTests
import SDGSwiftSourceTests
import SDGSwiftTests
import SDGXcodeTests

var tests = [XCTestCaseEntry]()
tests += SDGSwiftConfigurationTests.__allTests()
tests += SDGSwiftDocumentationExampleTests.__allTests()
tests += SDGSwiftPackageManagerTests.__allTests()
tests += SDGSwiftSourceTests.__allTests()
tests += SDGSwiftTests.__allTests()
tests += SDGXcodeTests.__allTests()

XCTMain(tests)
