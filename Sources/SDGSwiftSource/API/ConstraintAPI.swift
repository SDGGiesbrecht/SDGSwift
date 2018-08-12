/*
 ConstraintAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

public enum ConstraintAPI : Comparable {

    // MARK: - Cases

    case conformance(TypeReferenceAPI, TypeReferenceAPI)
    case sameType(TypeReferenceAPI, TypeReferenceAPI)

    // MARK: - Normalization

    internal func normalized() -> ConstraintAPI {
        switch self {
        case .conformance:
            return self
        case .sameType(let one, let two):
            if one ≤ two {
                return self
            } else {
                return .sameType(two, one)
            }
        }
    }

    // MARK: - Properties

    internal var description: String {
        switch self {
        case .conformance(let type, let conformance):
            return type.description + " : " + conformance.description
        case .sameType(let one, let two):
            return one.description + " == " + two.description
        }
    }

    // MARK: - Comparable

    public static func < (precedingValue: ConstraintAPI, followingValue: ConstraintAPI) -> Bool {
        switch (precedingValue, followingValue) {
        case (.conformance, .sameType):
            return true
        case (.sameType, .conformance):
            return false
        default:
            // #workaround(Swift 4.1.2, Order differs between operating systems.)
            return precedingValue.description.scalars.lexicographicallyPrecedes(followingValue.description.scalars)
        }
    }

    // MARK: - Equatable

    public static func == (precedingValue: ConstraintAPI, followingValue: ConstraintAPI) -> Bool { // @exempt(from: tests) Unreachable with valid source.
        return precedingValue.description == followingValue.description
    }
}
