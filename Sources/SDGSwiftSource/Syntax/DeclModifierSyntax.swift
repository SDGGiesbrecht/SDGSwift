/*
 DeclModifierSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGMathematics

extension DeclModifierSyntax {

    internal func normalizedForAPIDeclaration() -> DeclModifierSyntax? {
        let modifier = name.text
        switch modifier {
        case "mutating":
            return SyntaxFactory.makeDeclModifier(
                name: name.generallyNormalized(),
                detail: nil)
        case "indirect":
            return nil
        default: // @exempt(from: tests) Should never occur.
            if BuildConfiguration.current == .debug { // @exempt(from: tests)
                print("Unidentified modifier: \(modifier)")
            }
            return nil
        }
    }

    private enum Group : OrderedEnumeration {
        case unknown
        case indirection
        case mutation
    }
    private func group() -> Group {
        switch name.text {
        case "indirect":
            return .indirection
        case "mutating":
            return .mutation
        default:
            if BuildConfiguration.current == .debug { // @exempt(from: tests)
                print("Unidentified modifier: \(name.text)")
            }
            return .unknown
        }
    }

    internal static func arrange(lhs: DeclModifierSyntax, rhs: DeclModifierSyntax) -> Bool {
        return (lhs.group(), lhs.name.text) < (rhs.group(), rhs.name.text)
    }
}
