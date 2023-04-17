/*
 BlockDocumentationSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A block documentation comment.
public struct BlockDocumentationSyntax: BlockCommentSyntaxProtocol, ExtendedSyntax {

  // MARK: - Initialization

  /// Parses a block documentation comment.
  public init(source: String) {
    (
      self.openingDelimiter, self.openingVerticalMargin, self.content, self.closingVerticalMargin,
      self.closingDelimiterIndentation, self.closingDelimiter
    ) = Self.parse(source: source)
  }

  // MARK: - BlockCommentSyntaxProtocol

  internal typealias Content = DocumentationContentSyntax

  internal static var openingDelimiter: ExtendedTokenKind {
    return .openingBlockDocumentationDelimiter
  }

  internal static var closingDelimiter: ExtendedTokenKind {
    return .closingBlockDocumentationDelimiter
  }

  /// The opening delimiter.
  var openingDelimiter: ExtendedTokenSyntax

  /// The opening vertical margin (a possible newline between the delimiter and the content).
  var openingVerticalMargin: ExtendedTokenSyntax?

  /// The content.
  public var content: [LineFragmentSyntax<FragmentSyntax<DocumentationContentSyntax>>]

  /// The closing vertical margin (a possible newline between the delimiter and the content).
  var closingVerticalMargin: ExtendedTokenSyntax?

  /// The indentation of the closing delimiter (a possible space preceding it).
  var closingDelimiterIndentation: ExtendedTokenSyntax?

  /// The closing delimiter.
  var closingDelimiter: ExtendedTokenSyntax
}
