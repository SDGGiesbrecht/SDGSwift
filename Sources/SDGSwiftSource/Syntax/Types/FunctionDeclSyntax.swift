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

extension FunctionDeclSyntax : AccessControlled, APIDeclaration, Attributed, Generic, Member, OverloadableAPIDeclaration {

    internal func functionAPI() -> FunctionAPI? {
        if ¬isPublic ∨ isUnavailable() {
            return nil
        }
        let name = identifier.text
        if name.hasPrefix("_") {
            return nil
        }
        return FunctionAPI(documentation: documentation, declaration: self)
    }

    // MARK: - APIDeclaration

    internal func normalizedAPIDeclaration() -> FunctionDeclSyntax {
        let (newGenericParemeterClause, newGenericWhereClause) = normalizedGenerics()
        return SyntaxFactory.makeFunctionDecl(
            attributes: attributes?.normalizedForAPIDeclaration(),
            modifiers: modifiers?.normalizedForAPIDeclaration(operatorFunction: identifier.isOperator),
            funcKeyword: funcKeyword.generallyNormalizedAndMissingInsteadOfNil(trailingTrivia: .spaces(1)),
            identifier: identifier.generallyNormalizedAndMissingInsteadOfNil(),
            genericParameterClause: newGenericParemeterClause,
            signature: signature.normalizedForAPIDeclaration(),
            genericWhereClause: newGenericWhereClause,
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

    // MARK: - OverloadableAPIDeclaration

    internal func overloadPattern() -> FunctionDeclSyntax {
        return SyntaxFactory.makeFunctionDecl(
            attributes: nil,
            modifiers: modifiers?.forOverloadPattern(),
            funcKeyword: funcKeyword,
            identifier: identifier,
            genericParameterClause: nil,
            signature: signature.forOverloadPattern(operator: identifier.isOperator),
            genericWhereClause: nil,
            body: nil)
    }
}
