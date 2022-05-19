/*
 APITests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGSwift
import SDGSwiftDocumentation

import SymbolKit

import XCTest

import SDGXCTestUtilities

import SDGSwiftTestUtilities

class APITests: SDGSwiftTestUtilities.TestCase {

  func testSymbolGraphLoading() throws {
    for packageURL in documentationTestPackages {
      let package = PackageRepository(at: packageURL)
      #if PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
        _ = try? package.symbolGraphs().get()
      #else
        _ = try package.symbolGraphs().get()
      #endif
    }
  }
}
