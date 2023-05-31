/*
 TriviaPieceNode.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SwiftSyntax

/// A trivia piece from the SwiftSyntax library.
public struct TriviaPieceNode: SyntaxNode {

  // MARK: - Initialization

    /// Creates a node from a `TriviaPiece` instance.
    ///
    /// - Parameters:
    ///   - piece: The trivia piece.
    ///   - precedingDocumentationContext: The contents of any preceding documentation fragments that are part of the same documentation comment.
    ///   - followingDocumentationContext: The contents of any following documentation fragments that are part of the same documentation comment.
    public init(
      _ piece: TriviaPiece,
      precedingDocumentationContext: String?,
      followingDocumentationContext: String?
    ) {
      self.piece = piece
      self.precedingDocumentationContext = precedingDocumentationContext
      self.followingDocumentationContext = followingDocumentationContext
    }

  // MARK: - Properties

    /// The trivia piece.
    public let piece: TriviaPiece

  internal let precedingDocumentationContext: String?
  internal let followingDocumentationContext: String?

  // MARK: - SyntaxNode

  public func children(cache: inout ParserCache) -> [SyntaxNode] {
      switch piece {
      case .spaces, .tabs:
        return [Token(kind: .whitespace(text()))]
      case .verticalTabs, .formfeeds, .newlines, .carriageReturns, .carriageReturnLineFeeds:
        return [Token(kind: .lineBreaks(text()))]
      case .lineComment:
        return [
          LineComment(source: text())
            ?? Token.unknown(text())  // @exempt(from: tests)
        ]
      case .blockComment:
        return [
          BlockComment(source: text())
            ?? Token.unknown(text())  // @exempt(from: tests)
        ]
      case .docLineComment:
        return [
          LineDocumentation(
            source: text(),
            precedingContentContext: precedingDocumentationContext,
            followingContentContext: followingDocumentationContext
          ) ?? Token.unknown(text())  // @exempt(from: tests)
        ]
      case .docBlockComment:
        return [
          BlockDocumentation(source: text())
            ?? Token.unknown(text())  // @exempt(from: tests)
        ]
      case .unexpectedText:  // @exempt(from: tests)
        return [Token.unknown(text())]
      case .shebang:
        return [Token(kind: .shebang(text()))]
      }
  }

  // MARK: - TextOutputStreamable

  public func write<Target>(
    to target: inout Target
  ) where Target: TextOutputStream {
      piece.write(to: &target)
  }
}
