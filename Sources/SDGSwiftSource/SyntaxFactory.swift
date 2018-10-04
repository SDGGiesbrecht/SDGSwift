/*
 SyntaxFactory.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension SyntaxFactory {

    public static func makeToken(_ kind: TokenKind, leadingTrivia: Trivia = [], trailingTrivia: Trivia = []) -> TokenSyntax {
        return SyntaxFactory.makeToken(kind, presence: .present, leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
    }

    public static func makeProtocolStyleAccessorBlock(settable: Bool) -> AccessorBlockSyntax {
        var list: [AccessorDeclSyntax] = [
            SyntaxFactory.makeAccessorDecl(
                attributes: nil,
                modifier: nil,
                accessorKind: SyntaxFactory.makeContextualKeyword("get"),
                parameter: nil,
                body: nil)
        ]
        if settable {
            list.append(SyntaxFactory.makeAccessorDecl(
                attributes: nil,
                modifier: nil,
                accessorKind: SyntaxFactory.makeToken(.contextualKeyword("set"), leadingTrivia: .spaces(1)),
                parameter: nil,
                body: nil))
        }
        return SyntaxFactory.makeAccessorBlock(
            leftBrace: SyntaxFactory.makeToken(.leftBrace, leadingTrivia: .spaces(1), trailingTrivia: .spaces(1)),
            accessorListOrStmtList: SyntaxFactory.makeAccessorList(list),
            rightBrace: SyntaxFactory.makeToken(.rightBrace, leadingTrivia: .spaces(1)))
    }
}
