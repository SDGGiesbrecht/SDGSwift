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

public struct TypeReferenceAPI : Comparable, Hashable {

    // MARK: - Initialization

    internal init(name: String, genericArguments: [TypeReferenceAPI]) {
        self.name = name.decomposedStringWithCanonicalMapping
        self.genericArguments = genericArguments
    }

    // MARK: - Properties

    private var name: String
    private var genericArguments: [TypeReferenceAPI]

    // MARK: - Output

    internal var nameDeclaration: TokenSyntax {
        return SyntaxFactory.makeToken(.identifier(name))
    }

    internal var genericParameterClauseDeclaration: GenericParameterClauseSyntax? {
        if self.genericArguments.isEmpty {
            return nil
        }

        var genericArguments: [GenericParameterSyntax] = []
        for index in self.genericArguments.indices {
            let argument = self.genericArguments[index]

            var trailingComma: TokenSyntax?
            if index ≠ self.genericArguments.index(before: self.genericArguments.endIndex) {
                trailingComma = SyntaxFactory.makeToken(.comma, trailingTrivia: .spaces(1))
            }

            genericArguments.append(SyntaxFactory.makeGenericParameter(
                name: argument.nameDeclaration,
                colon: nil,
                inheritedType: nil,
                trailingComma: trailingComma))
        }

        return SyntaxFactory.makeGenericParameterClause(
            leftAngleBracket: SyntaxFactory.makeToken(.leftAngle),
            genericParameterList: SyntaxFactory.makeGenericParameterList(genericArguments),
            rightAngleBracket: SyntaxFactory.makeToken(.rightAngle))
    }

    internal var declaration: SimpleTypeIdentifierSyntax {

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

        return SyntaxFactory.makeSimpleTypeIdentifier(
            name: nameDeclaration,
            genericArgumentClause: genericArgumentClause)
    }

    internal var identifierList: Set<String> {
        return genericArguments.reduce(into: Set([name])) { $0 ∪= $1.identifierList }
    }

    // MARK: - Comparable

    public static func < (precedingValue: TypeReferenceAPI, followingValue: TypeReferenceAPI) -> Bool {
        if precedingValue.name == followingValue.name {
            return precedingValue.genericArguments.lexicographicallyPrecedes(followingValue.genericArguments) // @exempt(from: tests) Unreachable with valid source.
        } else {
            // #workaround(Swift 4.1.2, Order differs between operating systems.)
            return precedingValue.name.scalars.lexicographicallyPrecedes(followingValue.name.scalars)
        }
    }

    // MARK: - Equatable

    public static func == (precedingValue: TypeReferenceAPI, followingValue: TypeReferenceAPI) -> Bool {
        return (precedingValue.name, precedingValue.genericArguments) == (followingValue.name, followingValue.genericArguments)
    }

    // MARK: - Hashable

    public var hashValue: Int {
        return name.hashValue
    }
}
