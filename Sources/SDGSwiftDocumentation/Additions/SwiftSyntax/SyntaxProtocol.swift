/*
 SyntaxProtocol.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGCollections

import SDGSwiftSource
#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SwiftSyntax
  import SymbolKit
#endif

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  extension SyntaxProtocol {

    internal func smallestSubnode<P>(containing searchTerm: P) -> Syntax?
    where P: SDGCollections.Pattern, P.Element == Unicode.Scalar {
      return _smallestSubnode(containing: searchTerm)
    }

    internal var documentation: SymbolGraph.LineList? {
      guard let token = firstToken() else {
        return nil  // @exempt(from: tests) Unreachable.
      }
      let leading = token.leadingTrivia
      var scanningLines = false
      var lines: [SymbolGraph.LineList.Line] = []
      scan: for index in leading.indices.lazy.reversed() {
        let trivia = leading[index]
        switch trivia {
        case .spaces, .tabs, .verticalTabs, .formfeeds, .newlines, .carriageReturns,
          .carriageReturnLineFeeds:
          continue scan
        case .lineComment, .blockComment, .garbageText:
          break scan
        case .docLineComment(let line):
          lines.append(SymbolGraph.LineList.Line(lineSource: line))
          scanningLines = true
        case .docBlockComment(let block):
          if scanningLines {
            break scan
          } else {
            return SymbolGraph.LineList(blockSource: block)
          }
        }
      }
      if lines.isEmpty {
        return nil
      } else {
        return SymbolGraph.LineList(lines: lines.reversed())
      }
    }

    internal func location(url: String, source: SourceFileSyntax) -> SymbolGraph.Symbol.Location? {
      let start = SourceLocation(
        offset: positionAfterSkippingLeadingTrivia.utf8Offset,
        converter: SourceLocationConverter(file: url, tree: source)
      )
      guard let url = start.file,
        let line = start.line,
        let character = start.column
      else {
        return nil
      }
      return SymbolGraph.Symbol.Location(
        url: url,
        position: SymbolGraph.LineList.SourceRange.Position(
          line: line,
          character: character
        )
      )
    }
  }
#endif
