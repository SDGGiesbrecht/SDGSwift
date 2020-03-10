/*
 RegressionTests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest

import SDGSwiftTestUtilities

class RegressionTests: SDGSwiftTestUtilities.TestCase {

  func testSchemeDetectionWithMutlipleLibrariesAndTool() throws {
    // Untracked.

    #if !(os(Windows) || os(Linux) || os(Android))
      try withMock(named: "MultipleSchemes") { package in
        let scheme = try package.scheme().get()
        XCTAssertEqual(scheme, "SomePackage\u{2D}Package")
      }
    #endif
  }
}
