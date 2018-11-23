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

    internal func normalizedForAPIDeclaration(operatorFunction: Bool) -> DeclModifierSyntax? {
        func normalize() -> DeclModifierSyntax {
            return SyntaxFactory.makeDeclModifier(
                name: name.generallyNormalized(trailingTrivia: .spaces(1)),
                detail: nil)
        }
        switch name.tokenKind {
        case .staticKeyword, .classKeyword:
            // Type membership.
            return operatorFunction ? nil : normalize()
        default:
            let conditionalKeyword = name.text
            switch conditionalKeyword {
            case "open":
                // Overridability.
                return normalize()
            case "public", "internal", "fileprivate", "private":
                // Access control.
                return nil
            case "mutating":
                return normalize()
            case "indirect":
                return nil
            default: // @exempt(from: tests) Should never occur.
                if BuildConfiguration.current == .debug { // @exempt(from: tests)
                    print("Unidentified modifier: \(conditionalKeyword)")
                }
                return nil
            }
        }
    }

    private enum Group : OrderedEnumeration {
        case unknown
        case accessControl
        case classMembership
        case staticity
        case mutation
    }
    private func group() -> Group {
        switch name.tokenKind {
        case .staticKeyword:
            return .staticity
        case .classKeyword:
            return .classMembership
        default:
            switch name.text {
            case "open", "public", "internal", "fileprivate", "private":
                // Access control.
                return .accessControl
            case "mutating":
                return .mutation
            default:
                if BuildConfiguration.current == .debug { // @exempt(from: tests)
                    print("Unidentified modifier: \(name.text)")
                }
                return .unknown
            }
        }
    }

    internal static func arrange(lhs: DeclModifierSyntax, rhs: DeclModifierSyntax) -> Bool {
        return (lhs.group(), lhs.name.text) < (rhs.group(), rhs.name.text)
    }

    internal func forOverloadPattern() -> DeclModifierSyntax? {
        switch name.tokenKind {
        case .staticKeyword:
             return self
        case .classKeyword:
            return withName(SyntaxFactory.makeToken(.staticKeyword, trailingTrivia: name.trailingTrivia))
        default:
            return nil
        }
    }
}
