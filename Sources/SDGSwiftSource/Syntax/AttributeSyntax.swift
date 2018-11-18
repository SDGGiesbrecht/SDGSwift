/*
 AttributeSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGMathematics

extension AttributeSyntax {

    internal func normalizedForAPIDeclaration() -> AttributeSyntax? {
        let attribute = attributeName.text
        if attribute.hasPrefix("_") {
            return nil // @exempt(from: tests) #workaround(Requires function refactor.)
        }

        switch attribute {
        case "available":
            // Availability
            // #workaround(“available” should be parsed.)
            return normalized()
        case "escaping", "autoclosure", "discardableResult":
            // Call site // @exempt(from: tests) #workaround(Requires function refactor.)
            return normalized()
        case "objc", "nonobjc", "objcMembers":
            // Objective‐C interface // @exempt(from: tests) #workaround(Requires function refactor.)
            // #workaround(“objcMembers” should be decomposed.)
            return normalized()
        case "IBOutlet", "IBDesignable", "IBInspectable", "GKInspectable" :
            // Xcode interface // @exempt(from: tests) #workaround(Requires property refactor.)
            return normalized()

        case "inlinable", "usableFromInline", "dynamicMemberLookup", "convention":
            // Implementation details // @exempt(from: tests) #workaround(Requires function refactor.)
            return nil
        case "NSCopying", "NSManaged" :
            // Objective‐C implementation details // @exempt(from: tests) #workaround(Requires property refactor.)
            return SyntaxFactory.makeAttribute(
                atSignToken: SyntaxFactory.makeToken(.atSign),
                attributeName: SyntaxFactory.makeToken(.contextualKeyword("objc")),
                balancedTokens: SyntaxFactory.makeTokenList([])).normalized()
        case "testable":
            // Not relevant to API symbols // @exempt(from: tests)
            return nil
        case "NSApplicationMain", "UIApplicationMain" :
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
        return SyntaxFactory.makeAttribute(
            atSignToken: SyntaxFactory.makeToken(.atSign),
            attributeName: attributeName.generallyNormalized(),
            balancedTokens: balancedTokens.normalizedForAPIAttribute())
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
        case "IBOutlet", "IBDesignable", "IBInspectable", "GKInspectable" :
            return .interfaceBuilder
        default:
            if BuildConfiguration.current == .debug { // @exempt(from: tests)
                print("Unidentified attribute: \(attributeName.text)")
            }
            return .unknown
        }
    }

    internal static func arrange(lhs: AttributeSyntax, rhs: AttributeSyntax) -> Bool { // @exempt(from: tests) #workaround(Requires function refactor.)
        return (lhs.group(), lhs.attributeName.text) < (rhs.group(), rhs.attributeName.text)
    }
}
