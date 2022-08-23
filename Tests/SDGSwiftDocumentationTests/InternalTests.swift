/*
 InternalTests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

@testable import SDGSwiftDocumentation

import SymbolKit

import SDGSwiftTestUtilities

class InternalTests: SDGSwiftTestUtilities.TestCase {

  func testSymbolGraphLineList() {
    _ = SymbolGraph.LineList(blockSource: "/** ... */")
  }

  func testSymbolGraphLineListLine() {
    _ = SymbolGraph.LineList.Line(lineSource: "/// ...")
  }
}
