/*
 CMarkNode.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

  import SDGLogic
  import SDGMathematics

  import cmark_gfm

  extension UnsafeMutablePointer<cmark_node> {

    internal func lowerBound(in documentation: String) -> String.ScalarView.Index {
      var node = self
      var line: Int32 = 0
      var column: Int32 = 0
      while line == 0 ∨ column == 0 {
        line = cmark_node_get_start_line(node)
        column = cmark_node_get_start_column(node)
        if line == 0 ∨ column == 0 {
          let previous = cmark_node_previous(node)
          line = cmark_node_get_end_line(previous)
          column = cmark_node_get_end_column(previous)
        }
        node = cmark_node_parent(node)
      }

      return indexFor(line: Int(line), column: Int(column), in: documentation)
    }
    internal func upperBound(in documentation: String) -> String.ScalarView.Index {
      var node = self
      var line: Int32 = 0
      var column: Int32 = 0
      while line == 0 ∨ column == 0 {
        line = cmark_node_get_end_line(node)
        column = cmark_node_get_end_column(node)
        if line == 0 ∨ column == 0 {
          let next = cmark_node_next(node)
          line = cmark_node_get_start_line(next)
          column = cmark_node_get_start_column(next)
        }
        if let parent = cmark_node_parent(node) {
          node = parent
        } else {  // In trailing whitespace ignored by parser.
          return documentation.scalars.endIndex
        }
      }

      switch cmark_node_get_type(self) {
      case CMARK_NODE_DOCUMENT, CMARK_NODE_BLOCK_QUOTE, CMARK_NODE_LIST, CMARK_NODE_ITEM,
        CMARK_NODE_CODE_BLOCK, CMARK_NODE_HEADING, CMARK_NODE_PARAGRAPH, CMARK_NODE_TEXT:
        column += 1
      default:
        break
      }
      return indexFor(line: Int(line), column: Int(column), in: documentation)
    }
    private func indexFor(
      line: Int,
      column: Int,
      in documentation: String
    ) -> String.ScalarView.Index {
      let scalars = documentation.scalars
      let lines = documentation.lines
      let utf8 = documentation.utf8

      let lineIndex = lines.index(lines.startIndex, offsetBy: line − 1)
      let lineStartByteIndex = lineIndex.samePosition(in: scalars).samePosition(in: utf8)!
      var index =
        utf8.index(
          lineStartByteIndex,
          offsetBy: column − 1,
          limitedBy: utf8.endIndex
        ) ?? utf8.endIndex  // @exempt(from: tests) Only occurs when cmark exhibits bugs.
      var result: String.ScalarView.Index? = index.samePosition(in: scalars)
      while result == nil {  // @exempt(from: tests) Only occurs when CommonMark exhibits bugs.
        index = utf8.index(before: index)
        result = index.samePosition(in: scalars)
      }
      return result!
    }

    internal var literal: String? {
      if let cString = cmark_node_get_literal(self) {
        return String(cString: cString, encoding: .utf8)
      } else {  // @exempt(from: tests) Should never occur.
        return nil  // @exempt(from: tests)
      }
    }

    internal func syntax(in documentation: String) -> [ExtendedSyntax] {
      switch cmark_node_get_type(self) {
      // ..._DOCUMENT will never occur.
      // HTML nodes are undefined.
      case CMARK_NODE_BLOCK_QUOTE:
        return [QuotationSyntax(node: self, in: documentation)]
      case CMARK_NODE_LIST:
        let list = ListSyntax(node: self, in: documentation)
        return list.handlingCallouts ?? [list]
      case CMARK_NODE_ITEM:
        let list = ListEntrySyntax(node: self, in: documentation)
        return [list.asCallout ?? list]
      case CMARK_NODE_CODE_BLOCK:
        return [CodeBlockSyntax(node: self, in: documentation)]
      case CMARK_NODE_PARAGRAPH:
        return [ParagraphSyntax(node: self, in: documentation)]
      case CMARK_NODE_HEADING:
        return [HeadingSyntax(node: self, in: documentation)]
      case CMARK_NODE_THEMATIC_BREAK:
        return [
          ExtendedTokenSyntax(
            text: String(
              documentation.scalars[lowerBound(in: documentation)..<upperBound(in: documentation)]
            ),
            kind: .asterism
          )
        ]
      case CMARK_NODE_SOFTBREAK:
        return [ExtendedTokenSyntax(text: "\n", kind: .newlines)]
      case CMARK_NODE_LINEBREAK:
        return [LineSeparatorSyntax()]
      case CMARK_NODE_CODE:
        return [InlineCodeSyntax(node: self, in: documentation)]
      case CMARK_NODE_EMPH:
        return [FontSyntax(node: self, in: documentation, delimiter: "*")]
      case CMARK_NODE_STRONG:
        return [FontSyntax(node: self, in: documentation, delimiter: "**")]
      case CMARK_NODE_LINK:
        return [LinkSyntax(node: self, in: documentation)]
      case CMARK_NODE_IMAGE:
        return [ImageSyntax(node: self, in: documentation)]
      default /* CMARK_NODE_TEXT */:
        var text = String(
          documentation[lowerBound(in: documentation)..<upperBound(in: documentation)]
        )
        if text.hasSuffix("  ") {  // Line break is handled elsewhere.
          text.removeLast(2)
        }
        return [ExtendedTokenSyntax(text: text, kind: .documentationText)]
      }
    }
  }
