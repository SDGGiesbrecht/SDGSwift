/*
 Inherited.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public struct Inherited : DependencyProtocol, Comparable {
    public func required() {}
    public static func ==(lhs: Self, rhs: Self) -> Bool {}
    public static func <(lhs: Self, rhs: Self) -> Bool {}
}

public class Superclass : Decodable, Encodable {
    public init(from decoder: Decoder) throws {}
    public func encode(to encoder: Encoder) throws {}
}
public class Subclass : Superclass {
    public init(from decoder: Decoder) throws {}
    public func encode(to encoder: Encoder) throws {}
}

public class AnotherSublass : UnknownSuperclass {
    public override func methodOverride() {}
}

public struct InheritingAssociatedType : RawRepresentable {
    public typealias RawValue = Int
}
