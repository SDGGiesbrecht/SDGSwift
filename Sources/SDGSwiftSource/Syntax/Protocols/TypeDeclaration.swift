/*
 TypeDeclaration.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGCollections

internal protocol TypeDeclaration : AccessControlled, Attributed, Generic {
    var identifier: TokenSyntax { get }
    var inheritanceClause: TypeInheritanceClauseSyntax? { get }

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

        var children = apiChildren()
        if let conformances = inheritanceClause?.conformances {
            children.append(contentsOf: conformances.lazy.map({ APIElement.conformance($0) }))
        }
        return TypeAPI(
            documentation: documentation,
            declaration: self,
            children: children)
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
