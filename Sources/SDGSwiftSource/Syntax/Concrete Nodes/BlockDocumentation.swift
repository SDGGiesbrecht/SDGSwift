/*
 BlockDocumentation.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A block documentation comment.
public struct BlockDocumentation: BlockCommentProtocol, SyntaxNode {

  // MARK: - Initialization

  /// Parses a block documentation comment.
  ///
  /// - Parameters:
  ///   - source: The source.
  public init?(source: String) {
    guard let parsed = Self.parse(source: source) else {
      return nil
    }
    (
      self.openingDelimiter, self.openingVerticalMargin, self.content, self.closingVerticalMargin,
      self.closingDelimiterIndentation, self.closingDelimiter
    ) = parsed
  }

  // MARK: - BlockCommentProtocol

  internal typealias Content = DocumentationContent

  internal static var openingDelimiter: Token.Kind {
    return .openingBlockDocumentationDelimiter
  }

  internal static var closingDelimiter: Token.Kind {
    return .closingBlockDocumentationDelimiter
  }

  /// The opening delimiter.
  public let openingDelimiter: Token

  /// The opening vertical margin (a possible newline between the delimiter and the content).
  public let openingVerticalMargin: Token?

  /// The content.
  public let content: [LineFragment<Fragment<DocumentationContent>>]

  /// The closing vertical margin (a possible newline between the delimiter and the content).
  public let closingVerticalMargin: Token?

  /// The indentation of the closing delimiter (a possible space preceding it).
  public let closingDelimiterIndentation: Token?

  /// The closing delimiter.
  public let closingDelimiter: Token
}
