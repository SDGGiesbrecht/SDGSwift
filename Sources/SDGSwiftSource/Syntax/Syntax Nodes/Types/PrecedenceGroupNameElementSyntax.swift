/*
 PrecedenceGroupNameElementSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SwiftSyntax

extension PrecedenceGroupNameElementSyntax {

    internal func normalizedForAPIDeclaration(comma: Bool) -> PrecedenceGroupNameElementSyntax {
        return SyntaxFactory.makePrecedenceGroupNameElement(
            name: name.generallyNormalizedAndMissingInsteadOfNil(),
            trailingComma: comma ? SyntaxFactory.makeToken(.comma, trailingTrivia: .spaces(1)) : nil)
    }

    internal static func arrange(lhs: PrecedenceGroupNameElementSyntax, rhs: PrecedenceGroupNameElementSyntax) -> Bool {
        return lhs.name.text < rhs.name.text
    }
}
