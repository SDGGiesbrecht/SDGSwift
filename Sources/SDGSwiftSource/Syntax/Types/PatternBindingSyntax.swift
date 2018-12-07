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

    internal func flattenedForAPI() -> [PatternBindingSyntax] {
        return pattern.flattenedForAPI().map { (pattern, indexPath) in
            return SyntaxFactory.makePatternBinding(
                pattern: pattern,
                typeAnnotation: typeAnnotation?.normalizedForVariableBindingForAPIDeclaration(extractingFromIndexPath: indexPath),
                initializer: nil,
                accessor: accessor,
                trailingComma: nil)
        }
    }

    internal func normalizedForVariableAPIDeclaration(accessor: AccessorBlockSyntax) -> PatternBindingSyntax {

        // #workaround(SwiftSyntax 0.40200.0, Prevents invalid index use by SwiftSyntax.)
        var typeAnnotation = self.typeAnnotation
        if typeAnnotation?.source() == "" {
            typeAnnotation = nil
        }

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
