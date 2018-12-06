/*
 GenericParameterClauseSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

extension GenericParameterClauseSyntax {

    internal var typesAndConstraints: (types: [TypeReferenceAPI], constraints: GenericWhereClauseSyntax?) {
        var types: [TypeReferenceAPI] = []
        var constraints: GenericWhereClauseSyntax?
        for parameter in genericParameterList {
            let type = TypeReferenceAPI(name: parameter.name.text, genericArguments: [])
            types.append(type)
            if let inheritance = parameter.inheritedType {
                constraints = constraints.adding(SyntaxFactory.makeConformanceRequirement(
                    leftTypeIdentifier: SyntaxFactory.makeSimpleTypeIdentifier(
                        name: parameter.name,
                        genericArgumentClause: nil),
                    colon: SyntaxFactory.makeToken(.colon, leadingTrivia: .spaces(1), trailingTrivia: .spaces(1)),
                    rightTypeIdentifier: inheritance,
                    trailingComma: nil))
            }
        }
        return (types, constraints)
    }

    internal func normalizedForAPIDeclaration() -> (GenericParameterClauseSyntax?, GenericWhereClauseSyntax?) {
        let (newParameters, newConstraints) = genericParameterList.normalizedForAPIDeclaration()
        let parameters = SyntaxFactory.makeGenericParameterClause(
            leftAngleBracket: leftAngleBracket.generallyNormalizedAndMissingInsteadOfNil(),
            genericParameterList: newParameters,
            rightAngleBracket: rightAngleBracket.generallyNormalizedAndMissingInsteadOfNil())
        var constraints: GenericWhereClauseSyntax?
        if let new = newConstraints {
            constraints = SyntaxFactory.makeGenericWhereClause(
                whereKeyword: SyntaxFactory.makeToken(.whereKeyword, leadingTrivia: .spaces(1), trailingTrivia: .spaces(1)),
                requirementList: new)
        }
        return (parameters, constraints)
    }

    internal func identifierList() -> Set<String> {
        return Set(genericParameterList.map({ $0.name.text }))
    }
}
