/*
 InitializerClauseSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension InitializerClauseSyntax {

    internal func normalizeForDefaultArgument() -> InitializerClauseSyntax { // @exempt(from: tests) #workaround(Requires function refactor.)
        return SyntaxFactory.makeInitializerClause(
            equal: equal.generallyNormalized(leadingTrivia: .spaces(1), trailingTrivia: .spaces(1)),
            value: SyntaxFactory.makeIdentifierExpr(
                identifier: SyntaxFactory.makeToken(.contextualKeyword("default")),
                declNameArguments: nil))
    }
}
