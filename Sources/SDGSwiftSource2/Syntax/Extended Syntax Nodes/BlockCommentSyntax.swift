/*
 BlockCommentSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A block comment.
public struct BlockCommentSyntax: BlockCommentSyntaxProtocol, ExtendedSyntax {

  // MARK: - Initialization

  /// Parses a string literal.
  public init(source: String) {
    (
      self.openingDelimiter, self.openingVerticalMargin, self.content, self.closingVerticalMargin,
      self.closingDelimiterIndentation, self.closingDelimiter
    ) = Self.parse(source: source)
  }

  // MARK: - BlockCommentSyntaxProtocol

  internal static var openingDelimiter: ExtendedTokenKind {
    return .openingBlockCommentDelimiter
  }

  internal static var closingDelimiter: ExtendedTokenKind {
    return .closingBlockCommentDelimiter
  }

  /// The opening delimiter.
  public var openingDelimiter: ExtendedTokenSyntax

  /// The opening vertical margin (a possible newline between the delimiter and the content).
  public var openingVerticalMargin: ExtendedTokenSyntax?

  /// The content.
  public var content: [LineFragmentSyntax<FragmentSyntax<CommentContentSyntax>>]

  /// The closing vertical margin (a possible newline between the delimiter and the content).
  public var closingVerticalMargin: ExtendedTokenSyntax?

  /// The indentation of the closing delimiter (a possible space preceding it).
  public var closingDelimiterIndentation: ExtendedTokenSyntax?

  /// The closing delimiter.
  public var closingDelimiter: ExtendedTokenSyntax

  // MARK: - ExtendedSyntax

  public var children: [ExtendedSyntax] {
    var result: [ExtendedSyntax] = [openingDelimiter]
    if let openingVerticalMargin = openingVerticalMargin {
      result.append(openingVerticalMargin)
    }
    result.append(contentsOf: content)
    if let closingVerticalMargin = closingVerticalMargin {
      result.append(closingVerticalMargin)
    }
    if let closingDelimiterIndentation = closingDelimiterIndentation {
      result.append(closingDelimiterIndentation)
    }
    result.append(closingDelimiter)
    return result
  }
}
