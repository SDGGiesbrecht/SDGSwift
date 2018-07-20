/*
 CMarkNode.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGMathematics
import SDGCMarkShims

internal typealias cmark_node = OpaquePointer?

extension OpaquePointer {

    internal func syntax(in documentation: String) -> ExtendedSyntax {
        return Optional(self).syntax(in: documentation)
    }

    internal func lowerBound(in documentation: String) -> String.ScalarView.Index {
        return Optional(self).lowerBound(in: documentation)
    }
    internal func upperBound(in documentation: String) -> String.ScalarView.Index {
        return Optional(self).upperBound(in: documentation)
    }
}

extension Optional where Wrapped == OpaquePointer {

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
            node = cmark_node_parent(node)
        }

        let last = indexFor(line: Int(line), column: Int(column), in: documentation)
        return documentation.scalars.index(after: last)
    }
    private func indexFor(line: Int, column: Int, in documentation: String) -> String.ScalarView.Index {
        let scalars = documentation.scalars
        let lines = documentation.lines
        let utf8 = documentation.utf8

        let lineIndex = lines.index(lines.startIndex, offsetBy: line − 1)
        let lineStartByteIndex = lineIndex.samePosition(in: scalars).samePosition(in: utf8)!
        let index = utf8.index(lineStartByteIndex, offsetBy: column − 1)
        return index.samePosition(in: scalars)
    }

    private var literal: String? {
        if let cString = cmark_node_get_literal(self) {
            return String(cString: cString, encoding: .utf8)
        } else {
            return nil
        }
    }

    internal func syntax(in documentation: String) -> ExtendedSyntax {
        switch cmark_node_get_type(self) {
            // #warning(Handle all of these.)
        // CMARK_NODE_DOCUMENT will never occur.
        case CMARK_NODE_BLOCK_QUOTE:
            print("Quote node.")
            return MarkdownSyntax(node: self, in: documentation)
        case CMARK_NODE_LIST:
            print("List node.")
            return MarkdownSyntax(node: self, in: documentation)
        case CMARK_NODE_ITEM:
            print("Item node.")
            return MarkdownSyntax(node: self, in: documentation)
        case CMARK_NODE_CODE_BLOCK:
            print("Code block node.")
            return MarkdownSyntax(node: self, in: documentation)
        case CMARK_NODE_HTML:
            print("HTML node.")
            return MarkdownSyntax(node: self, in: documentation)
        case CMARK_NODE_PARAGRAPH:
            return ParagraphSyntax(node: self, in: documentation)
        case CMARK_NODE_HEADER:
            return HeadingSyntax(node: self, in: documentation)
        case CMARK_NODE_HRULE:
            print("Horizontal rule node.")
            return MarkdownSyntax(node: self, in: documentation)
        case CMARK_NODE_SOFTBREAK:
            return ExtendedTokenSyntax(text: "\n", kind: .newlines)
        case CMARK_NODE_LINEBREAK:
            print("Linebreak node.")
            return MarkdownSyntax(node: self, in: documentation)
        case CMARK_NODE_CODE:
            print("Code node.")
            return MarkdownSyntax(node: self, in: documentation)
        case CMARK_NODE_INLINE_HTML:
            print("Inline HTML node.")
            return MarkdownSyntax(node: self, in: documentation)
        case CMARK_NODE_EMPH:
            print("Emphasis node.")
            return MarkdownSyntax(node: self, in: documentation)
        case CMARK_NODE_STRONG:
            print("Strong node.")
            return MarkdownSyntax(node: self, in: documentation)
        case CMARK_NODE_LINK:
            print("Link node.")
            return MarkdownSyntax(node: self, in: documentation)
        case CMARK_NODE_IMAGE:
            print("Image node.")
            return MarkdownSyntax(node: self, in: documentation)
        default /* CMARK_NODE_TEXT */:
            return ExtendedTokenSyntax(text: self.literal ?? "", kind: .documentationText)
        }
    }
}
