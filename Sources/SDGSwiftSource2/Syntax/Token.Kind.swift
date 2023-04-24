/*
 Token.Kind.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SwiftSyntax

extension Token {

  /// Enumerates the kinds of tokens.
  public enum Kind {

    // MARK: - Cases

    /// A token kind from SwiftSyntax.
    case swiftSyntax(TokenKind)

    /// Whitespace; a sequence of spaces (U+0020) or similar ASCII controls.
    case whitespace(String)
    /// Vertical whitespace; line breaks (U+000A) or similar ASCII controls.
    case lineBreaks(String)

    /// A pair of slashes delimiting a line comment.
    case lineCommentDelimiter
    /// A slash and an asterisk delimiting the start of a block comment.
    case openingBlockCommentDelimiter
    /// An asterisk and a slash delimiting the end of a block comment.
    case closingBlockCommentDelimiter
    /// Raw text in a comment.
    case commentText(String)
    /// A URL in a comment.
    case commentURL(String)
    /// A source heading delimiter.
    case mark(String)
    /// The text of a source heading.
    case sourceHeadingText(String)

    /// A trio of slashes delimiting a line documentation comment.
    case lineDocumentationDelimiter

    /// A slash and two asterisks delimiting the start of a block comment.
    case openingBlockDocumentationDelimiter

    /// An asterisk and a slash delimiting the end of a block comment.
    case closingBlockDocumentationDelimiter

    /// Source code.
    case source(String)

    /// An incomplete fragment of a token.
    case fragment(String)

    /// A script shebang.
    case shebang(String)

    /// The textual representation of this token kind.
    public var text: String {
      switch self {
      case .swiftSyntax(let swiftSyntax):
        return TokenSyntax(swiftSyntax, presence: .present).text
      case .lineCommentDelimiter:
        return "//"
      case .openingBlockCommentDelimiter:
        return "/*"
      case .closingBlockCommentDelimiter:
        return "*/"
      case .lineDocumentationDelimiter:
        return "///"
      case .openingBlockDocumentationDelimiter:
        return "/**"
      case .closingBlockDocumentationDelimiter:
        return "*/"
      case .whitespace(let text),
        .lineBreaks(let text),
        .commentText(let text),
        .commentURL(let text),
        .mark(let text),
        .sourceHeadingText(let text),
        .source(let text),
        .fragment(let text),
        .shebang(let text):
        return text
      }
    }
  }
}
