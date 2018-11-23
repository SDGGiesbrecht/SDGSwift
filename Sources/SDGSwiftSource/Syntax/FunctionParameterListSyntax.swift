/*
 FunctionParameterListSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGCollections

extension FunctionParameterListSyntax {

    internal func normalizedForFunctionDeclaration() -> FunctionParameterListSyntax {
        return SyntaxFactory.makeFunctionParameterList(map({ $0.normalizedForFunctionDeclaration() }))
    }

    internal func forOverloadPattern() -> FunctionParameterListSyntax {
        return SyntaxFactory.makeFunctionParameterList(map({ $0.forOverloadPattern() }))
    }

    internal func forFunctionName() -> FunctionParameterListSyntax {
        return SyntaxFactory.makeFunctionParameterList(map({ $0.forFunctionName() }))
    }

    internal func identifierListForFunction() -> Set<String> {
        return reduce(into: Set<String>()) { $0 ∪= $1.identifierListForFunction() }
    }

    internal func normalizedForAssociatedValue() -> FunctionParameterListSyntax {
        return SyntaxFactory.makeFunctionParameterList(map({ $0.normalizedForAssociatedValue() }))
    }

    internal func forAssociatedValueName() -> FunctionParameterListSyntax {
        return SyntaxFactory.makeFunctionParameterList(map({ $0.forAssociatedValueName() }))
    }
}
