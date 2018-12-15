/*
 GenericWhereClauseSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

extension GenericWhereClauseSyntax : Mergeable {

    internal func normalized() -> GenericWhereClauseSyntax {

        // #workaround(SwiftSyntax 0.40200.0, Prevents invalid index use by SwiftSyntax.)
        if source().isEmpty {
            return self
        }

        return SyntaxFactory.makeGenericWhereClause(
            whereKeyword: whereKeyword.generallyNormalizedAndMissingInsteadOfNil(leadingTrivia: .spaces(1), trailingTrivia: .spaces(1)),
            requirementList: requirementList.normalized())
    }

    // MARK: - Mergeable

    internal mutating func merge(with other: GenericWhereClauseSyntax) {
        var requirementList = self.requirementList
        requirementList.merge(with: other.requirementList)
        self = withRequirementList(requirementList)
    }
}
