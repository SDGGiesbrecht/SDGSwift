/*
 SyntaxFragment.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public enum SyntaxFragment {

    // MARK: - Cases

    /// A syntax element.
    case syntax(Syntax)

    /// Isolated trivia.
    case trivia(TriviaPiece, Trivia, Trivia.Index)

    // MARK: - Syntax Colouring

    internal func nestedSyntaxHighlightedHTML(internalIdentifiers: Set<String>) -> String {
        switch self {
        case .syntax(let syntaxNode):
            return syntaxNode.nestedSyntaxHighlightedHTML(internalIdentifiers: internalIdentifiers)
        case .trivia(let piece, let group, let index):
            return piece.syntax(siblings: group, index: index).nestedSyntaxHighlightedHTML(internalIdentifiers: internalIdentifiers)
        }
    }
}
