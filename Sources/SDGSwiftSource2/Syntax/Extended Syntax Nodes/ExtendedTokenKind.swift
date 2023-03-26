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
  /// Raw text in a comment.
  case commentText(String)
  /// A URL in a comment.
  case commentURL(String)
  /// A source heading delimiter.
  case mark(String)
  /// The text of a source heading.
  case sourceHeadingText(String)

  /// Source code.
  case source(String)

  // #workaround(Not parsed yet.)
  case skipped(String)

  /// The textual representation of this token kind.
  public var text: String {
    switch self {
    case .quotationMark:
      return "\u{22}"
    case .lineCommentDelimiter:
      return "//"
    case .string(let text),
      .whitespace(let text),
      .lineBreaks(let text),
      .commentText(let text),
      .commentURL(let text),
      .mark(let text),
      .sourceHeadingText(let text),
      .source(let text),
      .skipped(let text):
      return text
    }
  }
}
