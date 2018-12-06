/*
 TypeDeclaration.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

internal protocol TypeDeclaration : AccessControlled, Attributed {
    static var keyword: TokenKind { get }
    var identifier: TokenSyntax { get }
    var genericParameterClause: GenericParameterClauseSyntax? { get }
    var inheritanceClause: TypeInheritanceClauseSyntax? { get }
    var genericWhereClause: GenericWhereClauseSyntax? { get }

    func normalizedAPIDeclaration() -> (declaration: TypeDeclaration, constraints: GenericWhereClauseSyntax?)
    func name() -> TypeDeclaration
    func identifierList() -> Set<String>
}

extension TypeDeclaration {

    internal var typeAPI: TypeAPI? {
        if ¬isPublic ∨ isUnavailable() {
            return nil
        }

        if identifier.text.hasPrefix("_") {
            return nil
        }

        return TypeAPI(
            documentation: documentation,
            declaration: self,
            conformances: inheritanceClause?.conformances ?? [],
            children: apiChildren())
    }
}
