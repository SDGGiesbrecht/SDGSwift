/*
 SyntaxFragment.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

  import SwiftSyntax

  /// A fragment of a larger syntax tree.
  public enum SyntaxFragment {

    // MARK: - Cases

    /// A syntax element.
    case syntax(Syntax)

    /// An extended syntax element.
    case extendedSyntax(ExtendedSyntax)

    /// Isolated trivia.
    case trivia(TriviaPiece, Trivia, Trivia.Index)

    // MARK: - Source

    internal func source() -> String {
      switch self {
      case .syntax(let syntax):
        return syntax.source()
      case .extendedSyntax(let syntax):
        return syntax.text
      case .trivia(let trivia, _, _):
        return trivia.text
      }
    }

    // MARK: - Syntax Colouring

    internal func nestedSyntaxHighlightedHTML(
      internalIdentifiers: Set<String>,
      symbolLinks: [String: String]
    ) -> String {
      switch self {
      case .syntax(let syntaxNode):
        return syntaxNode.nestedSyntaxHighlightedHTML(
          internalIdentifiers: internalIdentifiers,
          symbolLinks: symbolLinks
        )
      case .extendedSyntax(let syntaxNode):
        return syntaxNode.nestedSyntaxHighlightedHTML(
          internalIdentifiers: internalIdentifiers,
          symbolLinks: symbolLinks
        )
      case .trivia(let piece, let group, let index):
        return piece.syntax(siblings: group, index: index).nestedSyntaxHighlightedHTML(
          internalIdentifiers: internalIdentifiers,
          symbolLinks: symbolLinks
        )
      }
    }
  }
