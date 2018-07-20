/*
 CMarkNode.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics
import SDGCMarkShims

internal typealias cmark_node = OpaquePointer?

extension OpaquePointer {

    internal func syntax(in documentation: String) -> ExtendedSyntax {
        return Optional(self).syntax(in: documentation)
    }
}

extension Optional where Wrapped == OpaquePointer {

    internal func lowerBound(in documentation: String) -> String.ScalarView.Index {
        return indexFor(line: Int(cmark_node_get_start_line(self)), column: Int(cmark_node_get_start_column(self)), in: documentation)
    }
    private func upperBound(in documentation: String) -> String.ScalarView.Index {
        return documentation.scalars.index(after: indexFor(line: Int(cmark_node_get_end_line(self)), column: Int(cmark_node_get_end_column(self)), in: documentation))
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
            print("Paragraph node.")
            return MarkdownSyntax(node: self, in: documentation)
        case CMARK_NODE_HEADER:
            return HeadingSyntax(node: self, in: documentation)
        case CMARK_NODE_HRULE:
            print("Horizontal rule node.")
            return MarkdownSyntax(node: self, in: documentation)
        case CMARK_NODE_SOFTBREAK:
            print("Softbreak node.")
            return MarkdownSyntax(node: self, in: documentation)
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
