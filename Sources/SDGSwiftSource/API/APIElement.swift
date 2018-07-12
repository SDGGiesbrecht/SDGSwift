/*
 APIElement.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLocalization

public class APIElement : Comparable {

    public var name: String {
        primitiveMethod()
    }

    public var declaration: String? {
        primitiveMethod()
    }

    public var summary: [String] {
        primitiveMethod()
    }

    // MARK: - Comparable

    public static func < (precedingValue: APIElement, followingValue: APIElement) -> Bool {
        // #workaround(Swift 4.1.2, Order differs between operating systems.)
        return precedingValue.name.scalars.lexicographicallyPrecedes(followingValue.name.scalars)
    }

    public static func == (precedingValue: APIElement, followingValue: APIElement) -> Bool {
        // #workaround(Swift 4.1.2, Order differs between operating systems.)
        return precedingValue.name == followingValue.name
    }
}
