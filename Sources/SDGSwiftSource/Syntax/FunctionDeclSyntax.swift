/*
 FunctionDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGCollections

extension FunctionDeclSyntax : AccessControlled, FunctionLike, Member {

    internal func functionAPI() -> [FunctionAPI] {
        if ¬isPublic {
            return []
        }
        let name = identifier.text
        if name.hasPrefix("_") {
            return []
        }
        return [FunctionAPI(documentation: documentation, declaration: self)]
    }

    internal func normalizedAPIDeclaration() -> FunctionDeclSyntax {
        var newGenericParemeterClause: GenericParameterClauseSyntax?
        var newGenericWhereClause: GenericWhereClauseSyntax?
        if let originalGenericParameterClause = genericParameterClause {
            (newGenericParemeterClause, newGenericWhereClause) = originalGenericParameterClause.normalizedForAPIDeclaration()
        }

        if let originalGenericWhereClause = genericWhereClause {
            newGenericWhereClause = newGenericWhereClause?.adding(originalGenericWhereClause)
        }

        return SyntaxFactory.makeFunctionDecl(
            attributes: attributes?.normalizedForAPIDeclaration(),
            modifiers: modifiers?.normalizedForAPIDeclaration(operatorFunction: identifier.isOperator),
            funcKeyword: funcKeyword.generallyNormalized(trailingTrivia: .spaces(1)),
            identifier: identifier.generallyNormalized(),
            genericParameterClause: newGenericParemeterClause,
            signature: signature.normalizedForAPIDeclaration(),
            genericWhereClause: newGenericWhereClause,
            body: nil)
    }

    internal func overloadPattern() -> FunctionDeclSyntax {
        return SyntaxFactory.makeFunctionDecl(
            attributes: nil,
            modifiers: modifiers?.forOverloadPattern(),
            funcKeyword: funcKeyword,
            identifier: identifier,
            genericParameterClause: nil,
            signature: signature.forOverloadPattern(),
            genericWhereClause: nil,
            body: nil)
    }

    internal func name() -> FunctionDeclSyntax {
        return SyntaxFactory.makeFunctionDecl(
            attributes: nil,
            modifiers: nil,
            funcKeyword: SyntaxFactory.makeToken(.funcKeyword, presence: .missing),
            identifier: identifier,
            genericParameterClause: nil,
            signature: signature.forFunctionName(operator: identifier.isOperator),
            genericWhereClause: nil,
            body: nil)
    }

    internal func identifierList() -> Set<String> {
        return Set([identifier.text]) ∪ signature.identifierList()
    }

    // MARK: - FunctionLike

    internal var parameters: ParameterClauseSyntax {
        return signature.input
    }
}
