/*
 TupleTypeElementSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension TupleTypeElementSyntax {

    internal func normalized(comma: Bool) -> TupleTypeElementSyntax {
        return SyntaxFactory.makeTupleTypeElement(
            inOut: inOut?.generallyNormalized(trailingTrivia: .spaces(1)),
            name: name?.generallyNormalized(),
            secondName: secondName?.generallyNormalized(leadingTrivia: .spaces(1)),
            colon: colon?.generallyNormalized(trailingTrivia: .spaces(1)),
            type: type.normalized(),
            ellipsis: ellipsis?.generallyNormalized(),
            initializer: initializer?.normalizeForDefaultArgument(),
            trailingComma: comma ? SyntaxFactory.makeToken(.comma, trailingTrivia: .spaces(1)) : nil)
    }
}
