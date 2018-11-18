/*
 GenericRequirementListSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGMathematics

extension GenericRequirementListSyntax : List {

    internal func normalized() -> GenericRequirementListSyntax {
        let requirements = map({ $0.normalizedGenericRequirement() }).sorted(by: GenericRequirementListSyntax.arrangeGenericRequirements)
        return SyntaxFactory.makeGenericRequirementList(requirements)
    }

    private enum Group : OrderedEnumeration {
        case conformance
        case sameType
        case unknown
    }
    private static func group(for requirement: Syntax) -> Group {
        switch requirement {
        case is ConformanceRequirementSyntax :
            return .conformance
        case is SameTypeRequirementSyntax :
            return .sameType
        default:
            if BuildConfiguration.current == .debug { // @exempt(from: tests)
                print("Unidentified generic requirement: \(type(of: requirement))")
            }
            return .unknown
        }
    }
    private static func arrangeGenericRequirements(lhs: Syntax, rhs: Syntax) -> Bool {
        return (group(for: lhs), lhs.source()) < (group(for: rhs), rhs.source())
    }

    // MARK: - List

    internal init(elementsOrEmpty elements: [Syntax]) {
        self = SyntaxFactory.makeGenericRequirementList(elements)
    }

    internal func adding(_ addition: Syntax) -> GenericRequirementListSyntax {
        if let genericParameter = addition as? GenericParameterSyntax {
            if let inheritance = genericParameter.inheritedType {
                return adding(SyntaxFactory.makeConformanceRequirement(
                    leftTypeIdentifier: SyntaxFactory.makeSimpleTypeIdentifier(
                        name: genericParameter.name,
                        genericArgumentClause: nil),
                    colon: SyntaxFactory.makeToken(.colon, leadingTrivia: .spaces(1), trailingTrivia: .spaces(1)),
                    rightTypeIdentifier: inheritance,
                    trailingComma: nil))
            } else {
                return self
            }
        } else {
            return SyntaxFactory.makeGenericRequirementList(Array(self).appending(addition)).normalized()
        }
    }

    // MARK: - Mergeable

    internal func merged(with other: GenericRequirementListSyntax) -> GenericRequirementListSyntax {
        return SyntaxFactory.makeGenericRequirementList(Array(self) + Array(other)).normalized()
    }
}
