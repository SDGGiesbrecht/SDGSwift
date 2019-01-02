/*
 PrecedenceGroupDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension PrecedenceGroupDeclSyntax : APIDeclaration, Attributed {

    internal func operatorAPI() -> PrecedenceGroupAPI? {
        if isUnavailable() {
            return nil
        }
        return PrecedenceGroupAPI(documentation: documentation, declaration: self)
    }

    // MARK: - APIDeclaration

    internal func normalizedAPIDeclaration() -> PrecedenceGroupDeclSyntax {
        return SyntaxFactory.makePrecedenceGroupDecl(
            attributes: attributes?.normalizedForAPIDeclaration(),
            modifiers: modifiers?.normalizedForAPIDeclaration(operatorFunction: false),
            precedencegroupKeyword: precedencegroupKeyword.generallyNormalizedAndMissingInsteadOfNil(trailingTrivia: .spaces(1)),
            identifier: identifier.generallyNormalizedAndMissingInsteadOfNil(),
            leftBrace: leftBrace.generallyNormalizedAndMissingInsteadOfNil(leadingTrivia: .spaces(1), trailingTrivia: .spaces(1)),
            groupAttributes: groupAttributes.normalizedForAPIDeclaration(),
            rightBrace: rightBrace.generallyNormalizedAndMissingInsteadOfNil(leadingTrivia: .spaces(1)))
    }

    internal func name() -> PrecedenceGroupDeclSyntax {
        return SyntaxFactory.makePrecedenceGroupDecl(
            attributes: nil,
            modifiers: nil,
            precedencegroupKeyword: SyntaxFactory.makeToken(.precedencegroupKeyword, presence: .missing),
            identifier: identifier,
            leftBrace: SyntaxFactory.makeToken(.leftBrace, presence: .missing),
            groupAttributes: SyntaxFactory.makeBlankPrecedenceGroupAttributeList(),
            rightBrace: SyntaxFactory.makeToken(.rightBrace, presence: .missing))
    }

    internal func identifierList() -> Set<String> {
        return [identifier.text]
    }

}
