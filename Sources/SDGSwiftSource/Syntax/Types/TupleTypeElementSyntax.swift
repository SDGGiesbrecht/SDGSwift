/*
 TupleTypeElementSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension TupleTypeElementSyntax {

    internal func normalized() -> TupleTypeElementSyntax {

        // #workaround(SwiftSyntax 0.40200.0, SwiftSyntax puts the trailing comma here.)
        let ellipsisToken: TokenSyntax?
        if ellipsis?.tokenKind == .comma {
            ellipsisToken = ellipsis?.generallyNormalized(trailingTrivia: .spaces(1))
        } else {
            ellipsisToken = ellipsis?.generallyNormalized()
        }

        // #workaround(SwiftSyntax 0.40200.0, Prevents invalid index use by SwiftSyntax.)
        let newInitializer = source().contains("=") ? initializer?.normalizeForDefaultArgument() : nil // @exempt(from: tests) Unknown where this would be present.

        return SyntaxFactory.makeTupleTypeElement(
            inOut: inOut?.generallyNormalized(trailingTrivia: .spaces(1)),
            name: name?.generallyNormalized(),
            secondName: secondName?.generallyNormalized(leadingTrivia: .spaces(1)),
            colon: colon?.generallyNormalized(trailingTrivia: .spaces(1)),
            type: type.normalized(),
            ellipsis: ellipsisToken,
            initializer: newInitializer,
            trailingComma: trailingComma?.generallyNormalized(trailingTrivia: .spaces(1)))
    }
}
