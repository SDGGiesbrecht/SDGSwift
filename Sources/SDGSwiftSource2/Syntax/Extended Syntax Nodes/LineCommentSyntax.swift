/*
 LineCommentSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A line comment.
public struct LineCommentSyntax: ExtendedSyntax, LineCommentSyntaxProtocol {

  // MARK: - Initialization

  /// Creates a line comment syntax node.
  ///
  /// - Parameters:
  ///   - openingQuotationMark: Optional. The opening quotation mark.
  ///   - string: The contents of the string.
  ///   - closingQuotationMark: Optional. The closing quotation mark.
  public init(
    delimiter: ExtendedTokenSyntax = ExtendedTokenSyntax(kind: .lineCommentDelimiter),
    indent: ExtendedTokenSyntax? = ExtendedTokenSyntax(kind: .whitespace(" ")),
    content: CommentContentSyntax
  ) {
    self.delimiter = delimiter
    self.indent = indent
    self.content = content
  }

  /// Parses a string literal.
  public init(source: String) {
    (self.delimiter, self.indent, self.content) = Self.parse(source: source)
  }

  // MARK: - Properties

  /// The delimiter.
  public let delimiter: ExtendedTokenSyntax

  /// The indent.
  public let indent: ExtendedTokenSyntax?

  /// The content.
  public let content: CommentContentSyntax

  // MARK: - LineCommentSyntaxProtocol

  internal static var delimiter: ExtendedTokenKind {
    return .lineCommentDelimiter
  }
}