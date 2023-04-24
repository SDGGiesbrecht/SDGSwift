/*
 BlockComment.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A block comment.
public struct BlockComment: BlockCommentProtocol, SyntaxNode {

  // MARK: - Initialization

  /// Parses a block comment.
  public init?(source: String) {
    guard let parsed = Self.parse(source: source) else {
      return nil
    }
    (
      self.openingDelimiter, self.openingVerticalMargin, self.content, self.closingVerticalMargin,
      self.closingDelimiterIndentation, self.closingDelimiter
    ) = parsed
  }

  // MARK: - BlockCommentSyntaxProtocol

  internal static var openingDelimiter: Token.Kind {
    return .openingBlockCommentDelimiter
  }

  internal static var closingDelimiter: Token.Kind {
    return .closingBlockCommentDelimiter
  }

  /// The opening delimiter.
  public var openingDelimiter: Token

  /// The opening vertical margin (a possible newline between the delimiter and the content).
  public var openingVerticalMargin: Token?

  /// The content.
  public var content: [LineFragment<Fragment<CommentContent>>]

  /// The closing vertical margin (a possible newline between the delimiter and the content).
  public var closingVerticalMargin: Token?

  /// The indentation of the closing delimiter (a possible space preceding it).
  public var closingDelimiterIndentation: Token?

  /// The closing delimiter.
  public var closingDelimiter: Token
}
