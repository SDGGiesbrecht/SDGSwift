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
            leftParen: leftParen.generallyNormalized(),
            parameterList: parameterList.normalizedForFunctionDeclaration(),
            rightParen: rightParen.generallyNormalized())
    }

    internal func forOverloadPattern() -> ParameterClauseSyntax {
        return SyntaxFactory.makeParameterClause(
            leftParen: leftParen.generallyNormalized(),
            parameterList: parameterList.forOverloadPattern(),
            rightParen: rightParen.generallyNormalized())
    }

    internal func forFunctionName(operator: Bool) -> ParameterClauseSyntax {
        return SyntaxFactory.makeParameterClause(
            leftParen: leftParen.generallyNormalized(),
            parameterList: parameterList.forFunctionName(operator: `operator`),
            rightParen: rightParen.generallyNormalized())
    }

    internal func identifierListForFunction() -> Set<String> {
        return parameterList.identifierListForFunction()
    }

    internal func normalizedForAssociatedValue() -> ParameterClauseSyntax {
        return SyntaxFactory.makeParameterClause(
            leftParen: leftParen.generallyNormalized(),
            parameterList: parameterList.normalizedForAssociatedValue(),
            rightParen: rightParen.generallyNormalized())
    }

    internal func forAssociatedValueName() -> ParameterClauseSyntax {
        return SyntaxFactory.makeParameterClause(
            leftParen: leftParen,
            parameterList: parameterList.forAssociatedValueName(),
            rightParen: rightParen)
    }
}
