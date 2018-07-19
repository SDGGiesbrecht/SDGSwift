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
        func nodeSource() -> String {
            if let cString = cmark_node_get_literal(node) {
                var pointer = cString
                while cString ≠ nil {
                    let pointee = UInt8(bitPattern: pointer.pointee)
                    print(pointee)
                    if pointee == 0 {
                        break
                    } else {
                       pointer = pointer.advanced(by: 1)
                    }
                }
                return String(cString: cString, encoding: .utf8) ?? ""
            } else {
                return ""
            }
        }

        switch cmark_node_get_type(node) {
        // #warning(Handle all of these.)
        // CMARK_NODE_DOCUMENT will never occur.
        case CMARK_NODE_BLOCK_QUOTE:
            print("Quote node.")
            return MarkdownSyntax(node: node)
        case CMARK_NODE_LIST:
            print("List node.")
            return MarkdownSyntax(node: node)
        case CMARK_NODE_ITEM:
            print("Item node.")
            return MarkdownSyntax(node: node)
        case CMARK_NODE_CODE_BLOCK:
            print("Code block node.")
            return MarkdownSyntax(node: node)
        case CMARK_NODE_HTML:
            print("HTML node.")
            return MarkdownSyntax(node: node)
        case CMARK_NODE_PARAGRAPH:
            print("Paragraph node.")
            return MarkdownSyntax(node: node)
        case CMARK_NODE_HEADER:
            print("Header node.")
            return MarkdownSyntax(node: node)
        case CMARK_NODE_HRULE:
            print("Horizontal rule node.")
            return MarkdownSyntax(node: node)
        case CMARK_NODE_SOFTBREAK:
            print("Softbreak node.")
            return MarkdownSyntax(node: node)
        case CMARK_NODE_LINEBREAK:
            print("Linebreak node.")
            return MarkdownSyntax(node: node)
        case CMARK_NODE_CODE:
            print("Code node.")
            return MarkdownSyntax(node: node)
        case CMARK_NODE_INLINE_HTML:
            print("Inline HTML node.")
            return MarkdownSyntax(node: node)
        case CMARK_NODE_EMPH:
            print("Emphasis node.")
            return MarkdownSyntax(node: node)
        case CMARK_NODE_STRONG:
            print("Strong node.")
            return MarkdownSyntax(node: node)
        case CMARK_NODE_LINK:
            print("Link node.")
            return MarkdownSyntax(node: node)
        case CMARK_NODE_IMAGE:
            print("Image node.")
            return MarkdownSyntax(node: node)
        default /* CMARK_NODE_TEXT */:
            return ExtendedTokenSyntax(text: nodeSource(), kind: .documentationText)
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
