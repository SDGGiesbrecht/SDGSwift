/*
 ExtendedTokenKind.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// Enumerates the kinds of extended tokens.
///
/// This type is comparable to `TokenKind`, but represents syntax not handled by the `SwiftSyntax` module.
public enum ExtendedTokenKind: Sendable {

  // MARK: - Cases

  /// The text of a literal string.
  case string(String)
  /// An ASCII quotation mark (U+0022) used to enclose a string literal.
  case quotationMark

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
    case .quotationMark:
      return "\u{22}"
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
    case .string(let text),
      .whitespace(let text),
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
