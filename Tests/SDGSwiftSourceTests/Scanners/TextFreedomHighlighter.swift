/*
 TextFreedomHighlighter.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGSwiftSource

struct TextFreedomHighlighter: Highlighter {

  // MARK: - Properties

  let targetTestFreedom: TextFreedom

  // MARK: - Highlighter

  func shouldHighlight(_ token: Token, context: ScanContext) -> Bool {
    return token.kind.textFreedom(localAncestors: context.localAncestors) == targetTestFreedom
  }

  var highlighted: String = ""

  // MARK: - SyntaxScanner

  var cache = ParserCache()
}
