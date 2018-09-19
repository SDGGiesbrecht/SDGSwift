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

    public override func renderedHTML(localization: String, internalIdentifiers: Set<String>, symbolLinks: [String: String]) -> String {
        switch kind {
        case .quotationMark, .string, .whitespace, .newlines, .escape, .lineCommentDelimiter, .openingBlockCommentDelimiter, .closingBlockCommentDelimiter, .commentText, .commentURL, .mark, .lineDocumentationDelimiter, .openingBlockDocumentationDelimiter, .closingBlockDocumentationDelimiter, .bullet, .codeDelimiter, .language, .source, .headingDelimiter, .asterism, .fontModificationDelimiter, .linkDelimiter, .linkURL, .imageDelimiter, .quotationDelimiter, .parameter, .colon:
            return ""
        case .documentationText:
            return HTML.escape(text)
        case .callout:
            return "<p class=\u{22}callout‐label \(text.lowercased())\u{22}>" + HTML.escape(String(Callout(text)!.localizedText(localization))) + "</p>"
        case .lineSeparator:
            return "<br>"
        }
    }

    internal func syntaxHighlightingClass() -> String? {
        switch kind {

        case .quotationMark:
            return "string‐punctuation"

        case .string, .commentText, .documentationText:
            return "text"

        case .whitespace:
            return nil // Ignored.

        case .newlines, .commentURL, .source, .linkURL, .lineSeparator:
            return nil // Handled elsewhere.

        case .escape:
            return "punctuation"

        case .lineCommentDelimiter, .openingBlockCommentDelimiter, .closingBlockCommentDelimiter, .lineDocumentationDelimiter, .openingBlockDocumentationDelimiter, .closingBlockDocumentationDelimiter, .bullet, .codeDelimiter, .headingDelimiter, .asterism, .fontModificationDelimiter, .linkDelimiter, .imageDelimiter, .quotationDelimiter, .colon:
            return "comment‐punctuation"

        case .mark, .language, .callout:
            return "comment‐keyword"

        case .parameter:
            return "internal identifier"
        }
    }

    internal override func nestedSyntaxHighlightedHTML(internalIdentifiers: Set<String>, symbolLinks: [String: String]) -> String {
        if kind == .commentURL ∨ kind == .linkURL {
            return "<a href=\u{22}\(text)\u{22} class=\u{22}url\u{22}>\(text)</a>"
        } else {
            var source = HTML.escape(_text)
            if let `class` = syntaxHighlightingClass() {
                source.prepend(contentsOf: "<span class=\u{22}\(`class`)\u{22}>")
                source.append(contentsOf: "</span>")
            }
            return source
        }
    }

    // MARK: - TextOutputStreamable

    public override func write<Target>(to target: inout Target) where Target : TextOutputStream {
        _text.write(to: &target)
    }
}
