/*
 RegressionTests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest

import SDGSwiftTestUtilities

class RegressionTests: SDGSwiftTestUtilities.TestCase {

  func testDependencyCustomSchemesNotSelected() throws {
    // Untracked.

    #if !(os(Windows) || os(WASI) || os(Linux) || os(tvOS) || os(iOS) || os(Android) || os(watchOS))
      try withMock(named: "WithCustomScheme") { package in
        let scheme = try package.scheme().get()
        XCTAssertEqual(scheme, "WithCustomScheme\u{2D}Package")
      }
    #endif
  }

  func testSchemeDetectionWithMutlipleLibrariesAndTool() throws {
    // Untracked.

    #if !(os(Windows) || os(WASI) || os(Linux) || os(tvOS) || os(iOS) || os(Android) || os(watchOS))
      try withMock(named: "MultipleSchemes") { package in
        let scheme = try package.scheme().get()
        XCTAssertEqual(scheme, "SomePackage\u{2D}Package")
      }
    #endif
  }
}
