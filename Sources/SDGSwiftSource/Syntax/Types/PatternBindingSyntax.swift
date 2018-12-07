/*
 PatternBindingSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension PatternBindingSyntax {

    internal func normalizedForVariableAPIDeclaration(accessor: AccessorBlockSyntax) -> PatternBindingSyntax {
        return SyntaxFactory.makePatternBinding(
            pattern: pattern.normalizedVariableBindingForAPIDeclaration(),
            typeAnnotation: typeAnnotation?.normalizedForVariableBindingForAPIDeclaration(),
            initializer: nil,
            accessor: accessor,
            trailingComma: nil)
    }

    internal func forVariableName() -> PatternBindingSyntax {
        return SyntaxFactory.makePatternBinding(
            pattern: pattern.variableBindingForName(),
            typeAnnotation: nil,
            initializer: nil,
            accessor: nil,
            trailingComma: nil)
    }
}
