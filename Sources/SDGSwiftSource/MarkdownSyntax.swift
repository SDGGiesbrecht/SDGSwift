/*
 MarkdownSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGCMarkShims

public class MarkdownSyntax : ExtendedSyntax {

    internal static func parse(node: cmark_node) -> ExtendedSyntax {
        let source: String
        if let cString = cmark_node_get_literal(node) {
            source = String(cString: cString)
        } else {
            source = ""
        }

        switch cmark_node_get_type(node) {
        // #warning(Handle all of these.)
        case CMARK_NODE_BLOCK_QUOTE:
            print("Quote node.")
            print(source)
            return MarkdownSyntax(node: node)
        case CMARK_NODE_LIST:
            print("List node.")
            print(source)
            return MarkdownSyntax(node: node)
        case CMARK_NODE_ITEM:
            print("Item node.")
            print(source)
            return MarkdownSyntax(node: node)
        case CMARK_NODE_CODE_BLOCK:
            print("Code block node.")
            print(source)
            return MarkdownSyntax(node: node)
        case CMARK_NODE_HTML:
            print("HTML node.")
            print(source)
            return MarkdownSyntax(node: node)
        case CMARK_NODE_PARAGRAPH:
            print("Paragraph node.")
            print(source)
            return MarkdownSyntax(node: node)
        case CMARK_NODE_HEADER:
            print("Header node.")
            print(source)
            return MarkdownSyntax(node: node)
        case CMARK_NODE_HRULE:
            print("Horizontal rule node.")
            print(source)
            return MarkdownSyntax(node: node)
        case CMARK_NODE_TEXT:
            return ExtendedTokenSyntax(text: source, kind: .documentationText)
        case CMARK_NODE_SOFTBREAK:
            print("Softbreak node.")
            print(source)
            return MarkdownSyntax(node: node)
        case CMARK_NODE_LINEBREAK:
            print("Linebreak node.")
            print(source)
            return MarkdownSyntax(node: node)
        case CMARK_NODE_CODE:
            print("Code node.")
            print(source)
            return MarkdownSyntax(node: node)
        case CMARK_NODE_INLINE_HTML:
            print("Inline HTML node.")
            print(source)
            return MarkdownSyntax(node: node)
        case CMARK_NODE_EMPH:
            print("Emphasis node.")
            print(source)
            return MarkdownSyntax(node: node)
        case CMARK_NODE_STRONG:
            print("Strong node.")
            print(source)
            return MarkdownSyntax(node: node)
        case CMARK_NODE_LINK:
            print("Link node.")
            print(source)
            return MarkdownSyntax(node: node)
        case CMARK_NODE_IMAGE:
            print("Image node.")
            print(source)
            return MarkdownSyntax(node: node)
        default /* CMARK_NODE_DOCUMENT */:
            return ExtendedTokenSyntax(text: source, kind: .documentationText)
        }
    }

    // MARK: - Initialization

    internal init(node: cmark_node) {
        var children: [ExtendedSyntax] = []
        if var child = cmark_node_first_child(node) {
            children.append(MarkdownSyntax.parse(node: child))
            while let next = cmark_node_next(child) {
                children.append(MarkdownSyntax.parse(node: child))
                child = next
            }
        }
        super.init(children: children)
    }
}
