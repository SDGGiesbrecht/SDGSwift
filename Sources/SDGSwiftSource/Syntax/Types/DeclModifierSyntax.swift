/*
 DeclModifierSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

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
                name: name.generallyNormalizedAndMissingInsteadOfNil(trailingTrivia: .spaces(1)),
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
                // External overridability.
                return normalize()
            case "final":
                // Internal overridability.
                return nil
            case "public", "internal", "fileprivate", "private":
                // Access control.
                return nil
            case "required":
                // Requirement.
                return normalize()
            case "convenience":
                // Designation.
                return normalize()
            case "override":
                // Subclassing.
                return nil
            case "mutating", "nonmutating":
                return normalize()
            case "indirect":
                return nil
            case "weak":
                return normalize()
            case "prefix", "postfix":
                // Operator position.
                return normalize()
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
        case requirement
        case designation
        case memoryManagement
        case classMembership
        case staticity
        case mutation
        case operatorPosition
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
                return .accessControl
            case "required":
                return .requirement // @exempt(from: tests) Cannot appear with any other groups for sorting.
            case "convenience":
                return .designation // @exempt(from: tests) Cannot appear with any other groups for sorting.
            case "weak":
                return .memoryManagement
            case "mutating", "nonmutating":
                return .mutation
            case "prefix", "postfix":
                return .operatorPosition // @exempt(from: tests) Cannot appear with any other groups for sorting.
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
            switch name.text {
            case "open", "public", "internal", "fileprivate", "private":
                return nil
            case "required":
                return nil
            case "convenience":
                return nil
            case "weak":
                return nil
            case "mutating", "nonmutating":
                return nil
            case "prefix", "postfix":
                return self
            default:
                if BuildConfiguration.current == .debug { // @exempt(from: tests)
                    print("Unidentified modifier: \(name.text)")
                }
                return nil
            }
        }
    }
}
