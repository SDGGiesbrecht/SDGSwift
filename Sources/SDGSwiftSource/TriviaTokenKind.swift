/*
 TriviaTokenKind.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// Enumerates the kinds of trivia tokens.
public enum TriviaTokenKind {

    // MARK: - Cases

    /// Whitespace; a sequence of spaces (U+0020) or similar ASCII controls.
    case whitespace

    /// A newline; a line feeds (U+000A) or similar ASCII controls.
    case newlines

    /// An ASCII grave accent (U+0060) used in Swift to escape identifiers.
    case escape

    /// A pair of slashes delimiting a line comment.
    case lineCommentDelimiter

    /// A slash and an asterisk delimiting the start of a block comment.
    case openingBlockCommentDelimiter

    /// An asterisk and a slash delimiting the end of a block comment.
    case closingBlockCommentDelimiter

    /// The text of a comment.
    case commentText

    /// A pair of slashes delimiting a line comment.
    case lineDocumentationDelimiter

    /// A slash and an asterisk delimiting the start of a block comment.
    case openingBlockDocumentationDelimiter

    /// An asterisk and a slash delimiting the end of a block comment.
    case closingBlockDocumentationDelimiter

    /// Documentation text.
    case documentationText

    // MARK: - Properties

    public var textFreedom: SyntaxElement.TextFreedom {
        switch self {
        case .whitespace, .escape, .commentText, .documentationText:
            return .arbitrary
        case .newlines, .lineCommentDelimiter, .openingBlockCommentDelimiter, .closingBlockCommentDelimiter, .lineDocumentationDelimiter, .openingBlockDocumentationDelimiter, .closingBlockDocumentationDelimiter:
            return .invariable
        }
    }
}
