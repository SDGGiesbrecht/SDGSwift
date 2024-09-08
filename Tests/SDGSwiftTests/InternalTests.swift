/*
 InternalTests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

@testable import SDGSwift

import XCTest

import SDGSwiftTestUtilities

class InternalTests: SDGSwiftTestUtilities.TestCase {

  func testString() {
    XCTAssertEqual("".lastLine(), "")
  }

  func testURL() {
    XCTAssertEqual(URL(parsingOutput: "/some/path"), URL(fileURLWithPath: "/some/path"))
  }
}
