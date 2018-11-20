/*
 FunctionSignatureSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension FunctionSignatureSyntax {

    internal func normalizedForAPIDeclaration() -> FunctionSignatureSyntax {
        return SyntaxFactory.makeFunctionSignature(
            input: input.normalizedForFunctionDeclaration(),
            throwsOrRethrowsKeyword: throwsOrRethrowsKeyword?.generallyNormalized(leadingTrivia: .spaces(1)),
            output: output?.normalizedForFunctionDeclaration())
    }

    internal func forOverloadPattern() -> FunctionSignatureSyntax {

    }

    internal func forFunctionName() -> FunctionSignatureSyntax {

    }

    internal func identifierList() -> Set<String> {

    }
}
