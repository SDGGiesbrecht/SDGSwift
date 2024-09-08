/*
 Inherited.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Dependency

import Hidden

public struct Inherited: DependencyProtocol, Comparable {
  public func required() {}
  public static func == (lhs: Self, rhs: Self) -> Bool { false }
  public static func < (lhs: Self, rhs: Self) -> Bool { false }
  public func requirement() {}
}

public class Superclass: Decodable, Encodable {
  internal init() {}
  public required init(from decoder: Decoder) throws {}
  public func encode(to encoder: Encoder) throws {}
}
public class Subclass: Superclass {
  public required init(from decoder: Decoder) throws {
    super.init()
  }
  public override func encode(to encoder: Encoder) throws {}
}

public class AnotherSublass: UnknownSuperclass {
  public override func methodOverride() {}
}

public struct InheritingAssociatedType: RawRepresentable {
  public typealias RawValue = Int
  public init?(rawValue: Int) {}
  public var rawValue: Int = 0
}
