/*
 HeadingSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections
import SDGText
import SDGCMarkShims

public class HeadingSyntax : MarkdownSyntax {

    internal init(node: cmark_node, in documentation: String) {
        var precedingChildren: [ExtendedSyntax] = []

        let level = Int(cmark_node_get_header_level(node))

        let contentStart = node.lowerBound(in: documentation)

        var lineStart = documentation.scalars.startIndex
        if let newline = documentation.scalars.lastMatch(for: CharacterSet.newlinePattern, in: documentation.scalars.startIndex ..< contentStart) {
            lineStart = newline.range.upperBound
        }

        if let token = documentation.scalars.lastMatch(for: String(repeating: "#", count: level).scalars, in: lineStart ..< contentStart) {
            let delimiter = ExtendedTokenSyntax(text: "#", kind: .headingDelimiter)
            numberSignDelimiter = delimiter
            precedingChildren.append(delimiter)
        } else {
            numberSignDelimiter = nil
        }
        super.init(node: node, in: documentation, precedingChildren: precedingChildren)
    }

    /// Delimiter.
    public let numberSignDelimiter: ExtendedTokenSyntax?
}
