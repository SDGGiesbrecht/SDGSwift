/*
 PrecedenceGroupRelationSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension PrecedenceGroupRelationSyntax {

    internal func normalizedForAPIDeclaration() -> PrecedenceGroupRelationSyntax {
        return SyntaxFactory.makePrecedenceGroupRelation(
            higherThanOrLowerThan: higherThanOrLowerThan.generallyNormalizedAndMissingInsteadOfNil(leadingTrivia: .spaces(1)),
            colon: colon.generallyNormalizedAndMissingInsteadOfNil(trailingTrivia: .spaces(1)),
            otherNames: otherNames.normalizedForAPIDeclaration())
    }
}
