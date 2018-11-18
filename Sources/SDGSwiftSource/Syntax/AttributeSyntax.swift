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
            // #warning(“objc” should be inferred from other attributes.)
            // #warning(“objcMembers” should be decomposed.)
            return normalized()
        case "IBOutlet", "IBDesignable", "IBInspectable", "GKInspectable":
            // Xcode interface
            return normalized()

        case "inlinable", "usableFromInline", "dynamicMemberLookup", "convention":
            // Implementation details
            return nil
        case "NSCopying", "NSManaged":
            // Objective‐C implementation details
            return nil
        case "testable":
            // Not relevant to API symbols
            return nil
        case "NSApplicationMain", "UIApplicationMain":
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

    internal static func arrange(lhs: AttributeSyntax, rhs: AttributeSyntax) -> Bool { // @exempt(from: tests) Not yet reachable.
        // #warning(Should use a more logical order.)
        return lhs.attributeName.text < rhs.attributeName.text
    }
}
