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
import SDGCollections

internal protocol TypeDeclaration : AccessControlled, Attributed, Generic {
    static var keyword: TokenKind { get }
    var identifier: TokenSyntax { get }
    var inheritanceClause: TypeInheritanceClauseSyntax? { get }

    func withGenericWhereClause(_ newChild: GenericWhereClauseSyntax?) -> Self

    func normalizedAPIDeclaration() -> (declaration: Self, constraints: GenericWhereClauseSyntax?)
    func name() -> Self
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

    internal func identifierList() -> Set<String> {
        var result: Set<String> = [identifier.text]
        if let genericParameters = genericParameterClause {

            // #workaround(SwiftSyntax 0.40200.0, Prevents invalid index use by SwiftSyntax.)
            if ¬genericParameters.source().contains("<") {
                return result
            }

            result ∪= genericParameters.identifierList()
        }
        return result
    }
}
