/*
 SourceLocation.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

import SymbolKit
  import SwiftSyntax

  extension SourceLocation {

    internal static func convertLine(fromSymbolGraph line: Int) -> Int {
      return line + 1
    }
    internal static func convertColumn(fromSymbolGraphCharacter character: Int) -> Int {
      return character + 1
    }

    internal var symbolKitPosition: SymbolGraph.LineList.SourceRange.Position? {
      guard let line = self.line,
        let column = self.column
      else {
        return nil
      }
      return SymbolGraph.LineList.SourceRange.Position(line: line − 1, character: column − 1)
    }
  }
