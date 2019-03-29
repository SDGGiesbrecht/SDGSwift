/*
 AttributeSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGMathematics
import SDGCollections

extension AttributeSyntax {

    internal func indicatesAbsence() -> Bool {
        switch attributeName.text {
        case "available":
            return tokenList?.contains(where: { token in
                switch token.tokenKind {
                case .identifier(let name):
                    if name ∈ Set(["unavailable", "deprecated", "obsoleted"]) {
                        return true
                    } else {
                        return false
                    }
                default:
                    return false
                }
            }) ?? false
        default:
            return false
        }
    }

    internal func normalizedForAPIDeclaration() -> AttributeSyntax? {
        let attribute = attributeName.text
        if attribute.hasPrefix("_") {
            return nil // @exempt(from: tests) Currently unreachable because SwiftSyntax does not properly detect these in 0.40200.0).
        }

        switch attribute {
        case "available":
            // Availability
            return normalized()
        case "escaping", "autoclosure", "discardableResult":
            // Call site
            return normalized()
        case "objc", "nonobjc", "objcMembers":
            // Objective‐C interface
            return normalized()
        case "IBOutlet", "IBDesignable", "IBInspectable", "GKInspectable":
            // Xcode interface
            return normalized()

        case "inlinable", "usableFromInline", "inline", "dynamicMemberLookup", "convention":
            // Implementation details
            return nil
        case "NSCopying", "NSManaged":
            // Objective‐C implementation details
            return SyntaxFactory.makeAttribute(
                atSignToken: SyntaxFactory.makeToken(.atSign),
                attributeName: SyntaxFactory.makeToken(.contextualKeyword("objc")),
                leftParen: nil,
                argument: nil,
                rightParen: nil,
                tokenList: nil)
        case "testable":
            // Not relevant to API symbols // @exempt(from: tests)
            return nil
        case "NSApplicationMain", "UIApplicationMain":
            // Not relevant to API // @exempt(from: tests)
            return nil
        case "requires_stored_property_inits", "warn_unqualified_access":
            // Source checks // @exempt(from: tests)
            return nil

        default: // @exempt(from: tests) Should never occur.
            if BuildConfiguration.current == .debug { // @exempt(from: tests)
                print("Unidentified attribute: \(attribute)")
            }
            return nil
        }

    }

    private func normalized() -> AttributeSyntax {
        if tokenList?.isEmpty ?? true {
            return SyntaxFactory.makeAttribute(
                atSignToken: atSignToken.generallyNormalizedAndMissingInsteadOfNil(),
                attributeName: attributeName.generallyNormalizedAndMissingInsteadOfNil(trailingTrivia: .spaces(1)),
                leftParen: nil,
                argument: nil,
                rightParen: nil,
                tokenList: nil)
        } else {
            return SyntaxFactory.makeAttribute(
                atSignToken: atSignToken.generallyNormalizedAndMissingInsteadOfNil(),
                attributeName: attributeName.generallyNormalizedAndMissingInsteadOfNil(),
                leftParen: leftParen?.generallyNormalized(),
                argument: nil,
                rightParen: leftParen?.generallyNormalized(),
                tokenList: tokenList?.normalizedForAPIAttribute())
        }
    }

    private enum Group : OrderedEnumeration {
        case unknown
        case availability
        case interfaceBuilder
        case objectiveC
        case discardability
        case escapability
        case autoclosure
    }
    private func group() -> Group {
        switch attributeName.text {
        case "available":
            return .availability
        case "escaping":
            return .escapability
        case "autoclosure":
            return .autoclosure
        case "discardableResult":
            return .discardability
        case "objc", "nonobjc", "objcMembers":
            return .objectiveC
        case "IBOutlet", "IBDesignable", "IBInspectable", "GKInspectable":
            // Objective‐C implementation details
            return .interfaceBuilder
        default:
            if BuildConfiguration.current == .debug { // @exempt(from: tests)
                print("Unidentified attribute: \(attributeName.text)")
            }
            return .unknown
        }
    }

    internal static func arrange(lhs: AttributeSyntax, rhs: AttributeSyntax) -> Bool {
        return (lhs.group(), lhs.attributeName.text) < (rhs.group(), rhs.attributeName.text)
    }
}
