/*
 InitializerDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

extension InitializerDeclSyntax : AccessControlled, APIDeclaration, Attributed, Generic, OverloadableAPIDeclaration {

    internal var initializerAPI: InitializerAPI? {
        if ¬isPublic ∨ isUnavailable() {
            return nil
        }
        if parameters.parameterList.first?.firstName?.text.hasPrefix("_") == true {
            return nil
        }
        return InitializerAPI(documentation: documentation, declaration: self)
    }

    // MARK: - APIDeclaration

    internal func normalizedAPIDeclaration() -> InitializerDeclSyntax {
        let (newGenericParemeterClause, newGenericWhereClause) = normalizedGenerics()
        return SyntaxFactory.makeInitializerDecl(
            attributes: attributes?.normalizedForAPIDeclaration(),
            modifiers: modifiers?.normalizedForAPIDeclaration(operatorFunction: false),
            initKeyword: initKeyword.generallyNormalizedAndMissingInsteadOfNil(),
            optionalMark: optionalMark?.generallyNormalized(),
            genericParameterClause: newGenericParemeterClause,
            parameters: parameters.normalizedForFunctionDeclaration(),
            throwsOrRethrowsKeyword: throwsOrRethrowsKeyword?.generallyNormalized(leadingTrivia: .spaces(1)),
            genericWhereClause: newGenericWhereClause,
            body: nil)
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

    // MARK: - OverloadableAPIDeclaration

    internal func overloadPattern() -> InitializerDeclSyntax {
        return SyntaxFactory.makeInitializerDecl(
            attributes: nil,
            modifiers: nil,
            initKeyword: initKeyword,
            optionalMark: nil,
            genericParameterClause: nil,
            parameters: parameters.forOverloadPattern(operator: false),
            throwsOrRethrowsKeyword: nil,
            genericWhereClause: nil,
            body: nil)
    }
}
