/*
 Generic.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

internal protocol Generic : Constrained {
    var genericParameterClause: GenericParameterClauseSyntax? { get }
}

extension Generic {

    internal func normalizedGenerics() -> (GenericParameterClauseSyntax?, GenericWhereClauseSyntax?) {
        var newGenericParemeterClause: GenericParameterClauseSyntax?
        var newGenericWhereClause: GenericWhereClauseSyntax?
        if let originalGenericParameterClause = genericParameterClause {
            (newGenericParemeterClause, newGenericWhereClause) = originalGenericParameterClause.normalizedForAPIDeclaration()
        }

        // #workaround(SwiftSyntax 0.40200.0, Prevents invalid index use by SwiftSyntax.)
        var genericWhereClause: GenericWhereClauseSyntax?
        if self.genericWhereClause?.source().contains("where") == true {
            genericWhereClause = self.genericWhereClause
        }

        newGenericWhereClause.merge(with: genericWhereClause?.normalized())
        return (newGenericParemeterClause, newGenericWhereClause)
    }
}
