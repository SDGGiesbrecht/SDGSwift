/*
 AvailabilityArgumentSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

extension AvailabilityArgumentSyntax {

    internal func normalized() -> AvailabilityArgumentSyntax {
        var entry = self.entry
        switch entry {
        case let token as TokenSyntax:
            entry = token.generallyNormalizedAndMissingInsteadOfNil()
        case let labeled as AvailabilityLabeledArgumentSyntax:
            entry = labeled.normalized()
        default: // @exempt(from: tests)
            entry.warnUnidentified()
        }
        return SyntaxFactory.makeAvailabilityArgument(
            entry: entry,
            trailingComma: trailingComma?.generallyNormalized(trailingTrivia: .spaces(1)))
    }
}
