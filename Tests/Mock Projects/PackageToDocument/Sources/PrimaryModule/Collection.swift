/*
 Collection.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public struct CollectionType: Collection {

  public typealias Index = Int
  public typealias Indices = DefaultIndices<Self>

  public var startIndex: Int {
    return 0
  }

  public var endIndex: Int {
    return 10
  }

  public func index(after i: Int) -> Int {
    return i + 1
  }

  public subscript(position: Int) -> Int {
    return position
  }
}
