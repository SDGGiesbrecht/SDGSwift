/*
 Structure.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public struct Structure: Error {
  public static let staticProperty: Bool = false
  public static func staticMethod() {}
  public init() {}
  public let property: Bool = false
  public let _hiddenProperty: Int = 0
  public subscript(`subscript`: Int) -> Bool { return false }
  public func method() {}
}
