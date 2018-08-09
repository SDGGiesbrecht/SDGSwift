/*
 APIElement.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGLocalization

public class APIElement : Comparable, Hashable {

    public var name: String {
        primitiveMethod()
    }

    public var declaration: String? {
        primitiveMethod()
    }

    private var _constraints: [ConstraintAPI] = []
    public internal(set) var constraints: [ConstraintAPI] {
        get {
            return _constraints
        }
        set {
            _constraints = newValue.map({ $0.normalized() }).sorted()
        }
    }
    public internal(set) var compilationConditions: String?

    public var summary: [String] {
        primitiveMethod()
    }

    // MARK: - Description

    internal func appendConstraintDescriptions(to description: inout String) {
        if ¬constraints.isEmpty {
            description += " where " + constraints.map({ $0.description }).joined(separator: ", ")
        }
    }

    internal func appendCompilationConditions(to description: inout String) {
        if let conditions = compilationConditions {
            description += " • " + conditions
        }
    }

    // MARK: - Comparable

    public static func < (precedingValue: APIElement, followingValue: APIElement) -> Bool {
        // #workaround(Swift 4.1.2, Order differs between operating systems.)
        if precedingValue.name == followingValue.name {
            return (precedingValue.declaration ?? "").scalars.lexicographicallyPrecedes((followingValue.declaration ?? "").scalars) // @exempt(from: tests) Empty declarations should never occur.
        } else {
            return precedingValue.name.scalars.lexicographicallyPrecedes(followingValue.name.scalars)
        }
    }

    // MARK: - Equatable

    public static func == (precedingValue: APIElement, followingValue: APIElement) -> Bool { // @exempt(from: tests) Apparently not actually used by the sorting algorithm.
        return (precedingValue.name, precedingValue.declaration) == (followingValue.name, followingValue.declaration)
    }

    // MARK: - Hashable

    public var hashValue: Int {
        return declaration?.hashValue ?? name.hashValue // @exempt(from: tests) Fallback is theoretically unreachable.
    }
}
