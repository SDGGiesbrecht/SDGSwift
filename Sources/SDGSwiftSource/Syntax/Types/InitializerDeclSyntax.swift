/*
 InitializerDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

extension InitializerDeclSyntax : AccessControlled, Attributed, Generic {

    internal var initializerAPI: InitializerAPI? {
        if ¬isPublic ∨ isUnavailable() {
            return nil
        }
        if parameters.parameterList.first?.firstName?.text.hasPrefix("_") == true {
            return nil
        }
        return InitializerAPI(documentation: documentation, declaration: self)
    }

    internal func normalizedAPIDeclaration() -> (declaration: InitializerDeclSyntax, constraints: GenericWhereClauseSyntax?) {
        let (newGenericParemeterClause, newGenericWhereClause) = normalizedGenerics()
        return (SyntaxFactory.makeInitializerDecl(
            attributes: attributes?.normalizedForAPIDeclaration(),
            modifiers: modifiers?.normalizedForAPIDeclaration(operatorFunction: false),
            initKeyword: initKeyword.generallyNormalizedAndMissingInsteadOfNil(),
            optionalMark: optionalMark?.generallyNormalized(),
            genericParameterClause: newGenericParemeterClause,
            parameters: parameters.normalizedForFunctionDeclaration(),
            throwsOrRethrowsKeyword: throwsOrRethrowsKeyword?.generallyNormalized(leadingTrivia: .spaces(1)),
            genericWhereClause: newGenericWhereClause,
            body: nil),
                newGenericWhereClause)
    }

    internal func name() -> InitializerDeclSyntax {
        return SyntaxFactory.makeInitializerDecl(
            attributes: nil,
            modifiers: nil,
            initKeyword: initKeyword,
            optionalMark: nil,
            genericParameterClause: nil,
            parameters: parameters.forFunctionName(operator: false),
            throwsOrRethrowsKeyword: nil,
            genericWhereClause: nil,
            body: nil)
    }

    internal func identifierList() -> Set<String> {
        return parameters.identifierListForFunction()
    }
}
