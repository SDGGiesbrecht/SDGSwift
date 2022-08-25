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

import SDGLogic
import SDGMathematics
import SDGCollections

import SDGSwiftSource
#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SwiftSyntax
  import SymbolKit
#endif

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  extension SyntaxProtocol {

    internal func smallest<Node>(
      _ type: Node.Type,
      at position: AbsolutePosition
    ) -> Node?
    where Node: SyntaxProtocol {
      guard positionAfterSkippingLeadingTrivia ≤ position,
        position ≤ endPositionBeforeTrailingTrivia
      else {
        return nil
      }
      for child in children {
        if let found = child.smallest(type, at: position) {
          return found
        }
      }
      return self as? Node
    }

    internal func smallestSubnode<P>(containing searchTerm: P) -> Syntax?
    where P: SDGCollections.Pattern, P.Element == Unicode.Scalar {
      return _smallestSubnode(containing: searchTerm)
    }

    internal func documentation(url: String, source: SourceFileSyntax) -> [SymbolDocumentation] {
      var result: [SymbolDocumentation] = []
      if let token = firstToken() {
        let leading = token.leadingTrivia
        let converter = SourceLocationConverter(file: url, tree: source)
        var cursor = positionAfterSkippingLeadingTrivia.utf8Offset
        var pendingLines: [SymbolGraph.LineList.Line] = []
        var lineBreakAlready: Bool = false
        func assemblePendingLines() {
          if ¬pendingLines.isEmpty {
            result.append(
              SymbolDocumentation(
                developerComments: SymbolGraph.LineList(lines: []),
                documentationComment: SymbolGraph.LineList(lines: pendingLines.reversed())
              )
            )
          }
          pendingLines = []
          lineBreakAlready = false
        }
        for index in leading.indices.lazy.reversed() {
          let trivia = leading[index]
          defer { cursor −= trivia.sourceLength.utf8Length }
          switch trivia {
          case .spaces, .tabs:
            break  // ignore
          case .verticalTabs(let count), .formfeeds(let count), .newlines(let count),
            .carriageReturns(let count), .carriageReturnLineFeeds(let count):
            if lineBreakAlready ∨ count > 1 {
              assemblePendingLines()
            }
            lineBreakAlready = true
          case .lineComment(var contents):
            assemblePendingLines()
            if let last = result.indices.last {
              var offset = 0
              if contents.scalars.count ≥ 2 {
                contents.scalars.removeFirst(2)
                offset += 2
              }
              while contents.scalars.first == " " {
                offset += 1
                contents.removeFirst()
              }
              var range: SymbolGraph.LineList.SourceRange?
              if let start = SourceLocation(offset: cursor + offset, converter: converter)
                .symbolKitPosition,
                let end = SourceLocation(
                  offset: cursor + offset + contents.utf8.count,
                  converter: converter
                ).symbolKitPosition
              {
                range = SymbolGraph.LineList.SourceRange(
                  start: start,
                  end: end
                )
              }
              result[last].developerComments.lines.prepend(
                SymbolGraph.LineList.Line(
                  text: contents,
                  range: range
                )
              )
            }
          case .blockComment, .garbageText:
            assemblePendingLines()
          case .docLineComment(var contents):
            lineBreakAlready = false
            var offset = 0
            if contents.scalars.count ≥ 3 {
              contents.scalars.removeFirst(3)
              offset += 3
            }
            if contents.scalars.first == " " {
              offset += 1
              contents.removeFirst()
            }
            var range: SymbolGraph.LineList.SourceRange?
            if let start = SourceLocation(offset: cursor + offset, converter: converter)
              .symbolKitPosition,
              let end = SourceLocation(
                offset: cursor + offset + contents.utf8.count,
                converter: converter
              ).symbolKitPosition
            {
              range = SymbolGraph.LineList.SourceRange(
                start: start,
                end: end
              )
            }
            pendingLines.append(
              SymbolGraph.LineList.Line(
                text: contents,
                range: range
              )
            )
          case .docBlockComment(var contents):
            var offset = cursor
            if contents.scalars.count ≥ 5 {
              contents.scalars.removeFirst(3)
              offset += 3
              contents.scalars.removeLast(2)
            }
            if contents.scalars.first == "\r" {
              contents.scalars.removeFirst()
              offset += 1
            }
            if contents.scalars.first == "\n" {
              contents.scalars.removeFirst()
              offset += 1
            }
            let indent = contents.scalars.prefix(while: { $0 == " " }).count
            var lines: [SymbolGraph.LineList.Line] = contents.lines.map { line in
              var trimmed = line.line
              var remainingMargin = indent
              var marginOffset = offset
              while remainingMargin > 0 ∧ trimmed.first == " " {
                trimmed.removeFirst()
                remainingMargin −= 1
                marginOffset += 1
              }
              var range: SymbolGraph.LineList.SourceRange?
              if let start = SourceLocation(offset: cursor + marginOffset, converter: converter)
                .symbolKitPosition,
                let end = SourceLocation(
                  offset: cursor + marginOffset + contents.utf8.count,
                  converter: converter
                ).symbolKitPosition
              {
                range = SymbolGraph.LineList.SourceRange(start: start, end: end)
              }
              return SymbolGraph.LineList.Line(text: String(trimmed), range: range)
            }
            if lines.last?.text.isEmpty == true {
              lines.removeLast()
            }
            result.append(
              SymbolDocumentation(
                developerComments: SymbolGraph.LineList(lines: []),
                documentationComment: SymbolGraph.LineList(lines: lines)
              )
            )
          }
        }
      }
      return result.reversed()
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
        uri: url,
        position: SymbolGraph.LineList.SourceRange.Position(
          line: line,
          character: character
        )
      )
    }
  }
#endif
