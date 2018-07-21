/*
 InlineCodeSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGSwiftSyntaxShims
import SDGCMarkShims

public class InlineCodeSyntax : MarkdownSyntax {

    // MARK: - Initialization

    internal init(node: cmark_node, in documentation: String) {
        let openingDelimiter = ExtendedTokenSyntax(text: "`", kind: .codeDelimiter)
        self.openingDelimiter = openingDelimiter

        let source = ExtendedTokenSyntax(text: node.literal ?? "", kind: .source)
        self.source = source

        let closingDelimiter = ExtendedTokenSyntax(text: "`", kind: .codeDelimiter)
        self.closingDelimiter = closingDelimiter

        super.init(node: node, in: documentation, precedingChildren: [openingDelimiter, source, closingDelimiter])
    }

    // MARK: - Properties

    public let openingDelimiter: ExtendedTokenSyntax

    public let source: ExtendedTokenSyntax

    public let closingDelimiter: ExtendedTokenSyntax
}
