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
            return nil
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
            // #workaround(“objc” should be inferred from other attributes.)
            // #workaround(“objcMembers” should be decomposed.)
            return normalized()
        case "IBOutlet", "IBDesignable", "IBInspectable", "GKInspectable" :
            // Xcode interface
            return normalized()

        case "inlinable", "usableFromInline", "dynamicMemberLookup", "convention":
            // Implementation details
            return nil
        case "NSCopying", "NSManaged" :
            // Objective‐C implementation details
            return nil
        case "testable":
            // Not relevant to API symbols
            return nil
        case "NSApplicationMain", "UIApplicationMain" :
            // Not relevant to API.
            return nil
        case "requires_stored_property_inits", "warn_unqualified_access":
            // Source checks
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
        case "IBOutlet", "IBDesignable", "IBInspectable", "GKInspectable":
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
