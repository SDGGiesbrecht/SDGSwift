/*
 ExtendedTokenSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

/// A syntax node representing a single token.
///
/// This type is comparable to `TokenSyntax`, but represents syntax not handled by the `SwiftSyntax` module.
public class ExtendedTokenSyntax : ExtendedSyntax {

    // MARK: - Initialization

    internal init(text: String, kind: ExtendedTokenKind) {
        self._text = text
        self.kind = kind
        super.init(children: [])
    }

    // MARK: - Properties

    private let _text: String

    /// The kind of the token.
    public let kind: ExtendedTokenKind

    // MARK: - ExtendedSyntax

    public override func renderedHTML() -> String {
        switch kind {
        case .quotationMark, .string, .whitespace, .newlines, .escape, .lineCommentDelimiter, .openingBlockCommentDelimiter, .closingBlockCommentDelimiter, .commentText, .commentURL, .mark, .lineDocumentationDelimiter, .openingBlockDocumentationDelimiter, .closingBlockDocumentationDelimiter:
            return syntaxColouredHTML()
        case .documentationText, .callout:
            return text
        case .bullet, .codeDelimiter, .language, .source, .headingDelimiter, .asterism, .fontModificationDelimiter, .linkDelimiter, .linkURL, .imageDelimiter, .quotationDelimiter, .colon:
            return ""
        case .lineSeparator:
            return "<br>"
        }
    }

    internal func syntaxHighlightingClass() -> String? {
        switch kind {

        case .quotationMark, .escape, .lineCommentDelimiter, .openingBlockCommentDelimiter, .closingBlockCommentDelimiter, .lineDocumentationDelimiter, .openingBlockDocumentationDelimiter, .closingBlockDocumentationDelimiter, .bullet, .codeDelimiter, .headingDelimiter, .asterism, .fontModificationDelimiter, .linkDelimiter, .imageDelimiter, .quotationDelimiter, .colon:
            return "punctuation"

        case .string:
            return "string"

        case .whitespace:
            return nil // Ignored.

        case .newlines:
            // #warning(This may need disambiguation.)
            return nil

        case .commentText, .documentationText:
            return "comment"

        case .commentURL, .linkURL:
            return "url"

        case .mark, .language:
            return "keyword"

        case .source, .lineSeparator:
            return nil // Handled elsewhere.

        case .callout:
            return "callout"
        }
    }

    internal override func nestedSyntaxHighlightedHTML(inline: Bool, internalIdentifiers: Set<String>) -> String {
        var source = _text
        if let `class` = syntaxHighlightingClass() {
            source.prepend(contentsOf: "<span class=\u{22}\(`class`)\u{22}>")
            source.append(contentsOf: "</span>")
        }
        return source
    }

    // MARK: - TextOutputStreamable

    public override func write<Target>(to target: inout Target) where Target : TextOutputStream {
        _text.write(to: &target)
    }
}
