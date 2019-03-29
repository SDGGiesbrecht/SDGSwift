/*
 AvailabilityLabeledArgumentSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

extension AvailabilityLabeledArgumentSyntax {

    internal func normalized() -> AvailabilityLabeledArgumentSyntax {
        var value = self.value
        switch value {
        default: // @exempt(from: tests) Should never occur.
            if BuildConfiguration.current == .debug { // @exempt(from: tests)
                print("Unidentified labelled availability argument value: \(type(of: value))")
            }
        }
        return SyntaxFactory.makeAvailabilityLabeledArgument(
            label: label.generallyNormalizedAndMissingInsteadOfNil(),
            colon: colon.generallyNormalizedAndMissingInsteadOfNil(trailingTrivia: .spaces(1)),
            value: value)
    }
}
