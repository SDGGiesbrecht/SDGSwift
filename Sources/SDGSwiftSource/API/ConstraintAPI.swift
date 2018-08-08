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

public enum ConstraintAPI {

    // MARK: - Cases

    case conformance(TypeReferenceAPI, ConformanceAPI)
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
            return type.description + " : " + conformance.name
        case .sameType(let one, let two):
            return one.description + " == " + two.description
        }
    }
}
