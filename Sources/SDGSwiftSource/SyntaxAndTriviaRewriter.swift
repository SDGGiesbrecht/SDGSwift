/*
 SyntaxAndTriviaRewriter.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLocalization

import SDGSwiftLocalizations

open class SyntaxAndTriviaRewriter : SyntaxRewriter {

    public final override func visit(_ node: TokenSyntax) -> Syntax {
        let leadingVisited = visitLeadingTrivia(of: node)
        let tokenVisited = visitToken(leadingVisited)
        guard let stillToken = tokenVisited as? TokenSyntax  else { return tokenVisited }
        return visitTrailingTrivia(of: stillToken)
    }

    private func visitLeadingTrivia(of token: TokenSyntax) -> TokenSyntax {
        return token.withLeadingTrivia(visit(token.leadingTrivia))
    }

    open func visitToken(_ node: TokenSyntax) -> Syntax {
        return super.visit(node)
    }

    private func visitTrailingTrivia(of token: TokenSyntax) -> TokenSyntax {
        return token.withTrailingTrivia(visit(token.trailingTrivia))
    }

    internal func visit(_ trivia: Trivia) -> Trivia {
        return Trivia(pieces: trivia.map({ visit($0) }))
    }

    internal func visit(_ trivia: TriviaPiece) -> TriviaPiece {
        return TriviaPiece(syntax: visit(trivia.syntax as TriviaSyntax) as! TriviaPieceSyntax)
    }

    internal func visit(_ node: TriviaSyntax) -> TriviaSyntax {
        let result: TriviaSyntax
        switch node {
        case let token as TokenTriviaSyntax:
            result = visit(token)
        case let comment as LineDocumentationSyntax:
            result = visit(comment)
        case let comment as BlockDocumentationSyntax:
            result = visit(comment)
        case let comment as LineCommentSyntax:
            result = visit(comment)
        case let comment as BlockCommentSyntax:
            result = visit(comment)
        case let triviaPiece as TriviaPieceSyntax:
            result = visit(triviaPiece)
        default:
            preconditionFailure(UserFacing<StrictString, APILocalization>({ localization in
                switch localization {
                case .englishCanada:
                    return StrictString("Unsupported trivia syntax type: \(type(of: node))")
                }
            }))
        }
        result.children = result.children.map({ visit($0) })
        return result
    }

    open func visit(_ node: TriviaPieceSyntax) -> TriviaPieceSyntax {
        return node
    }

    open func visit(_ node: LineCommentSyntax) -> LineCommentSyntax {
        return node
    }

    open func visit(_ node: BlockCommentSyntax) -> BlockCommentSyntax {
        return node
    }

    open func visit(_ node: LineDocumentationSyntax) -> LineCommentSyntax {
        return node
    }

    open func visit(_ node: BlockDocumentationSyntax) -> BlockCommentSyntax {
        return node
    }

    open func visit(_ node: TokenTriviaSyntax) -> TriviaSyntax {
        return node
    }
}
