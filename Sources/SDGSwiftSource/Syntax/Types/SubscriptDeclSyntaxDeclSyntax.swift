/*
 SubscriptDeclSyntaxDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

extension SubscriptDeclSyntax : AccessControlled, Accessor, Attributed, FunctionLike, Generic, Member {

    internal var subscriptAPI: SubscriptAPI? {
        if ¬isPublic ∨ isUnavailable() {
            return nil
        }
        return SubscriptAPI(
            documentation: documentation,
            declaration: self)
    }

    internal func normalizedAPIDeclaration() -> (declaration: SubscriptDeclSyntax, constraints: GenericWhereClauseSyntax?) {
        let (newGenericParemeterClause, newGenericWhereClause) = normalizedGenerics()
        return (SyntaxFactory.makeSubscriptDecl(
            attributes: attributes?.normalizedForAPIDeclaration(),
            modifiers: modifiers?.normalizedForAPIDeclaration(operatorFunction: false),
            subscriptKeyword: subscriptKeyword.generallyNormalizedAndMissingInsteadOfNil(),
            genericParameterClause: newGenericParemeterClause,
            indices: indices.normalizedForFunctionDeclaration(),
            result: result.normalizedForSubscriptDeclaration(),
            genericWhereClause: nil,
            accessor: accessor?.normalizedForAPIDeclaration()),
                newGenericWhereClause)
    }

    internal func name() -> SubscriptDeclSyntax {
        return SyntaxFactory.makeSubscriptDecl(
            attributes: nil,
            modifiers: nil,
            subscriptKeyword: SyntaxFactory.makeToken(.subscriptKeyword, presence: .missing),
            genericParameterClause: nil,
            indices: indices.forFunctionName(operator: false),
            result: SyntaxFactory.makeBlankReturnClause(),
            genericWhereClause: nil,
            accessor: nil)
    }

    internal func identifierList() -> Set<String> {
        return indices.identifierListForFunction()
    }

    // MARK: - Accessor

    var keyword: TokenSyntax {
        return subscriptKeyword
    }

    var accessors: AccessorBlockSyntax? {
        return accessor
    }

    // MARK: - FunctionLike

    var parameters: ParameterClauseSyntax {
        return indices
    }
}
