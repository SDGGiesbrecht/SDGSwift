/*
 ParameterClauseSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension ParameterClauseSyntax {

    internal func normalizedForFunctionDeclaration() -> ParameterClauseSyntax {
        return SyntaxFactory.makeParameterClause(
            leftParen: leftParen.generallyNormalizedAndMissingInsteadOfNil(),
            parameterList: parameterList.normalizedForFunctionDeclaration(),
            rightParen: rightParen.generallyNormalizedAndMissingInsteadOfNil())
    }

    internal func forOverloadPattern(operator: Bool) -> ParameterClauseSyntax {
        return SyntaxFactory.makeParameterClause(
            leftParen: leftParen.generallyNormalizedAndMissingInsteadOfNil(),
            parameterList: parameterList.forOverloadPattern(operator: `operator`),
            rightParen: rightParen.generallyNormalizedAndMissingInsteadOfNil())
    }

    internal func forFunctionName(operator: Bool) -> ParameterClauseSyntax {
        return SyntaxFactory.makeParameterClause(
            leftParen: leftParen.generallyNormalizedAndMissingInsteadOfNil(),
            parameterList: parameterList.forFunctionName(operator: `operator`),
            rightParen: rightParen.generallyNormalizedAndMissingInsteadOfNil())
    }

    internal func identifierListForFunction() -> Set<String> {
        return parameterList.identifierListForFunction()
    }

    internal func forSuperscriptName() -> ParameterClauseSyntax {
        return SyntaxFactory.makeParameterClause(
            leftParen: SyntaxFactory.makeToken(.leftSquareBracket),
            parameterList: parameterList.forFunctionName(operator: false),
            rightParen: SyntaxFactory.makeToken(.rightSquareBracket))
    }

    internal func normalizedForAssociatedValue() -> ParameterClauseSyntax {
        return SyntaxFactory.makeParameterClause(
            leftParen: leftParen.generallyNormalizedAndMissingInsteadOfNil(),
            parameterList: parameterList.normalizedForAssociatedValue(),
            rightParen: rightParen.generallyNormalizedAndMissingInsteadOfNil())
    }

    internal func forAssociatedValueName() -> ParameterClauseSyntax {
        return SyntaxFactory.makeParameterClause(
            leftParen: leftParen,
            parameterList: parameterList.forAssociatedValueName(),
            rightParen: rightParen)
    }
}
