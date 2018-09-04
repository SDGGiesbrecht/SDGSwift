/*
 FontSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public class FontSyntax : MarkdownSyntax {

    // MARK: - Initialization

    internal init(node: cmark_node, in documentation: String, delimiter: String) {

        let openingDelimiter = ExtendedTokenSyntax(text: delimiter, kind: .fontModificationDelimiter)
        self.openingDelimiter = openingDelimiter

        let closingDelimiter = ExtendedTokenSyntax(text: delimiter, kind: .fontModificationDelimiter)
        self.closingDelimiter = closingDelimiter

        super.init(node: node, in: documentation, precedingChildren: [openingDelimiter], followingChildren: [closingDelimiter])
    }

    // MARK: - Properties

    public let openingDelimiter: ExtendedTokenSyntax

    public let closingDelimiter: ExtendedTokenSyntax

    // MARK: - ExtendedSyntax

    internal override var renderedHtmlElement: String? {
        if openingDelimiter.text.count == 2 {
            return "strong"
        } else {
            return "em"
        }
    }
}
