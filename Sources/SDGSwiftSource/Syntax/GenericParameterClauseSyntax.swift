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

    var typesAndConstraints: (types: [TypeReferenceAPI], constraints: GenericWhereClauseSyntax?) {
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
}
