/*
 CMarkNode.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCMarkShims

internal typealias cmark_node = OpaquePointer?

extension Optional where Wrapped == OpaquePointer {

    private var literal: String? {
        if let cString = cmark_node_get_literal(self) {
            return String(cString: cString, encoding: .utf8)
        } else {
            return nil
        }
    }

    internal var syntax: ExtendedSyntax {
        switch cmark_node_get_type(self) {
        // #warning(Handle all of these.)
        // CMARK_NODE_DOCUMENT will never occur.
        case CMARK_NODE_BLOCK_QUOTE:
            print("Quote node.")
            return MarkdownSyntax(node: self)
        case CMARK_NODE_LIST:
            print("List node.")
            return MarkdownSyntax(node: self)
        case CMARK_NODE_ITEM:
            print("Item node.")
            return MarkdownSyntax(node: self)
        case CMARK_NODE_CODE_BLOCK:
            print("Code block node.")
            return MarkdownSyntax(node: self)
        case CMARK_NODE_HTML:
            print("HTML node.")
            return MarkdownSyntax(node: self)
        case CMARK_NODE_PARAGRAPH:
            print("Paragraph node.")
            return MarkdownSyntax(node: self)
        case CMARK_NODE_HEADER:
            return HeadingSyntax(node: self)
        case CMARK_NODE_HRULE:
            print("Horizontal rule node.")
            return MarkdownSyntax(node: self)
        case CMARK_NODE_SOFTBREAK:
            print("Softbreak node.")
            return MarkdownSyntax(node: self)
        case CMARK_NODE_LINEBREAK:
            print("Linebreak node.")
            return MarkdownSyntax(node: self)
        case CMARK_NODE_CODE:
            print("Code node.")
            return MarkdownSyntax(node: self)
        case CMARK_NODE_INLINE_HTML:
            print("Inline HTML node.")
            return MarkdownSyntax(node: self)
        case CMARK_NODE_EMPH:
            print("Emphasis node.")
            return MarkdownSyntax(node: self)
        case CMARK_NODE_STRONG:
            print("Strong node.")
            return MarkdownSyntax(node: self)
        case CMARK_NODE_LINK:
            print("Link node.")
            return MarkdownSyntax(node: self)
        case CMARK_NODE_IMAGE:
            print("Image node.")
            return MarkdownSyntax(node: self)
        default /* CMARK_NODE_TEXT */:
            return ExtendedTokenSyntax(text: self.literal ?? "", kind: .documentationText)
        }
    }
}
