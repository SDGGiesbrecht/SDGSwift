/*
 EnumDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

extension EnumDeclSyntax : AccessControlled, Attributed, Constrained, Generic, TypeDeclaration {

    // MARK: - TypeDeclaration

    internal var genericParameterClause: GenericParameterClauseSyntax? {
        return genericParameters
    }

    internal func normalizedAPIDeclaration() -> (declaration: EnumDeclSyntax, constraints: GenericWhereClauseSyntax?) {
        let (newGenericParemeterClause, newGenericWhereClause) = normalizedGenerics()
        return (SyntaxFactory.makeEnumDecl(
            attributes: attributes?.normalizedForAPIDeclaration(),
            modifiers: modifiers?.normalizedForAPIDeclaration(operatorFunction: false),
            enumKeyword: enumKeyword.generallyNormalizedAndMissingInsteadOfNil(trailingTrivia: .spaces(1)),
            identifier: identifier.generallyNormalizedAndMissingInsteadOfNil(),
            genericParameters: newGenericParemeterClause,
            inheritanceClause: nil,
            genericWhereClause: nil,
            members: SyntaxFactory.makeBlankMemberDeclBlock()),
                newGenericWhereClause)
    }

    internal func name() -> EnumDeclSyntax {
        return SyntaxFactory.makeEnumDecl(
            attributes: nil,
            modifiers: nil,
            enumKeyword: SyntaxFactory.makeToken(.enumKeyword, presence: .missing),
            identifier: identifier,
            genericParameters: genericParameterClause,
            inheritanceClause: nil,
            genericWhereClause: nil,
            members: SyntaxFactory.makeBlankMemberDeclBlock())
    }
}
