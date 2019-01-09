/*
 Trivia.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension Trivia {

    // MARK: - Properties

    public func source() -> String {
        return String(map({ $0.text }).joined())
    }

    // MARK: - Location

    public func lowerBound(in context: TriviaContext) -> String.ScalarView.Index {
        if context.leading {
            return context.token.lowerTriviaBound(in: context.tokenContext)
        } else {
            return context.token.upperSyntaxBound(in: context.tokenContext)
        }
    }

    public func upperBound(in context: TriviaContext) -> String.ScalarView.Index {
        if context.leading {
            return context.token.lowerSyntaxBound(in: context.tokenContext)
        } else {
            return context.token.upperTriviaBound(in: context.tokenContext)
        }
    }

    public func range(in context: TriviaContext) -> Range<String.ScalarView.Index> {
        return lowerBound(in: context) ..< upperBound(in: context)
    }

    // MARK: - Syntax Tree

    public func parentToken(context: TriviaContext) -> TokenSyntax? {
        return context.token
    }

    public func last() -> TriviaPiece? {
        var result: TriviaPiece?
        for element in self {
            result = element
        }
        return result
    }

    public func previousTrivia(context: TriviaContext) -> Trivia? {
        return context.token.previousToken()?.trailingTrivia
    }

    public func nextTrivia(context: TriviaContext) -> Trivia? {
        return context.token.nextToken()?.leadingTrivia
    }

    // MARK: - Syntax Highlighting

    internal func nestedSyntaxHighlightedHTML(internalIdentifiers: Set<String>, symbolLinks: [String: String]) -> String {
        var result = ""
        for index in indices {
            let piece = self[index]

            let extended = piece.syntax(siblings: self, index: index)
            result += extended.nestedSyntaxHighlightedHTML(internalIdentifiers: internalIdentifiers, symbolLinks: symbolLinks)
        }
        return result
    }
}
