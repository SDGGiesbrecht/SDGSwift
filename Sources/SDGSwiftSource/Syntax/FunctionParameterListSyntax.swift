/*
 FunctionParameterListSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension FunctionParameterListSyntax {

    internal func normalizedForFunctionDeclaration() -> FunctionParameterListSyntax {

    }

    internal func forOverloadPattern() -> FunctionParameterListSyntax {

    }

    internal func forFunctionName() -> FunctionParameterListSyntax {

    }

    internal func identifierListForFunction() -> Set<String> {

    }

    internal func normalizedForAssociatedValue() -> FunctionParameterListSyntax {
        return SyntaxFactory.makeFunctionParameterList(map({ $0.normalizedForAssociatedValue() }))
    }

    internal func forAssociatedValueName() -> FunctionParameterListSyntax {
        return SyntaxFactory.makeFunctionParameterList(map({ $0.forAssociatedValueName() }))
    }
}
