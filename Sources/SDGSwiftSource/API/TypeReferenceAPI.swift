/*
 TypeReferenceAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGCollections

public struct TypeReferenceAPI : Hashable {

    // MARK: - Initialization

    internal init(name: String, genericArguments: [TypeReferenceAPI], isOptional: Bool = false) {
        self.name = name.decomposedStringWithCanonicalMapping
        self.genericArguments = genericArguments
        self.isOptional = isOptional
    }

    // MARK: - Properties

    internal let name: String
    internal let genericArguments: [TypeReferenceAPI]
    internal let isOptional: Bool

    // MARK: - Output

    internal var nameDeclaration: TokenSyntax {
        return SyntaxFactory.makeToken(.identifier(name))
    }

    internal var declaration: TypeSyntax {

        var genericArgumentClause: GenericArgumentClauseSyntax?
        if ¬genericArguments.isEmpty {
            var genericArguments: [GenericArgumentSyntax] = []
            for index in self.genericArguments.indices {
                let argument = self.genericArguments[index]

                var trailingComma: TokenSyntax?
                if index ≠ self.genericArguments.index(before: self.genericArguments.endIndex) {
                    trailingComma = SyntaxFactory.makeToken(.comma, trailingTrivia: .spaces(1))
                }

                genericArguments.append(SyntaxFactory.makeGenericArgument(
                    argumentType: argument.declaration,
                    trailingComma: trailingComma))
            }

            genericArgumentClause = SyntaxFactory.makeGenericArgumentClause(
                leftAngleBracket: SyntaxFactory.makeToken(.leftAngle),
                arguments: SyntaxFactory.makeGenericArgumentList(genericArguments),
                rightAngleBracket: SyntaxFactory.makeToken(.rightAngle))
        }

        let simple = SyntaxFactory.makeSimpleTypeIdentifier(
            name: nameDeclaration,
            genericArgumentClause: genericArgumentClause)

        if isOptional {
            return SyntaxFactory.makeOptionalType(
                wrappedType: simple,
                questionMark: SyntaxFactory.makeToken(.postfixQuestionMark))
        } else {
            return simple
        }
    }
}
