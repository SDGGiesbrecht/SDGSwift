/*
 TypeReferenceAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

public struct TypeReferenceAPI : Comparable, Hashable {

    // MARK: - Initialization

    internal init(name: String, genericArguments: [TypeReferenceAPI]) {
        self.name = name.decomposedStringWithCanonicalMapping
        self.genericArguments = genericArguments
    }

    // MARK: - Properties

    private var name: String
    private var genericArguments: [TypeReferenceAPI]

    // MARK: - Output

    internal var description: String {
        var result = name
        if ¬genericArguments.isEmpty {
            result += "<" + genericArguments.map({ $0.description }).joined(separator: ", ") + ">"
        }
        return result
    }

    // MARK: - Comparable

    public static func < (precedingValue: TypeReferenceAPI, followingValue: TypeReferenceAPI) -> Bool {
        if precedingValue.name == followingValue.name {
            return precedingValue.genericArguments.lexicographicallyPrecedes(followingValue.genericArguments) // @exempt(from: tests) Unreachable with valid source.
        } else {
            // #workaround(Swift 4.1.2, Order differs between operating systems.)
            return precedingValue.name.scalars.lexicographicallyPrecedes(followingValue.name.scalars)
        }
    }

    // MARK: - Equatable

    public static func == (precedingValue: TypeReferenceAPI, followingValue: TypeReferenceAPI) -> Bool {
        return (precedingValue.name, precedingValue.genericArguments) == (followingValue.name, followingValue.genericArguments)
    }

    // MARK: - Hashable

    public var hashValue: Int {
        return name.hashValue
    }
}
