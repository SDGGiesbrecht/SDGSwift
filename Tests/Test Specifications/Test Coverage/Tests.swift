/*
 Tests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest
@testable import Mock

final class MockTests: XCTestCase {

  func testCoverage() {
    _ = covered()

    `switch` = false
    _ = branching()
    useClosure()
    `switch` = true
    _ = branching()
    useClosure()

    _ = withSupplementalPlaneCharacters()

    _ = ifElseStatement()

    _ = useCompleteRangeOperator()
  }

  static var allTests = [
    ("testCoverage", testCoverage)
  ]
}
