/*
 RoundTripSyntaxScanner.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGSwiftSource2

struct RoundTripSyntaxScanner: SyntaxScanner {

  // MARK: - Properties

  var result = ""

  // MARK: - SyntaxScanner

  mutating func visit(_ node: SyntaxNode) -> Bool {
    #warning("Debugging...")
    if false {
      print(type(of: node))
      if let markdown = node as? MarkdownNode {
        print(type(of: markdown.markdown))
        print(markdown.markdown.range)
      }
      print(node.text)
    }

    if let token = node as? Token {
      result.append(contentsOf: token.text)
    }
    return true
  }

  var cache = ParserCache()
}