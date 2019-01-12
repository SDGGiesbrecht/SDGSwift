/*
 Enumeration.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

enum InternalEnumeration {
    case a
    case b
    case c
}

public enum Enumeration {
    case a
    case b
    case c, d
}

public enum RawEnumeration: String {
    case a = "A"
    case b = "B"
    case c = "C"
}

public enum EnumerationWithAssociatedValues {
    case none
    case one(Bool)
    case two(Bool, Bool)
}

public enum EnumerationWithAvailablitiyRestrictions {
    @available(*, unavailable, renamed: "new") case old
    case new
}

public enum IndirectEnumeration {
    indirect case indirectCase
}
