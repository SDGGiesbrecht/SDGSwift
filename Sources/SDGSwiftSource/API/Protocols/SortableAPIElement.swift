/*
 SortableAPIElement.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// An API element type whose instances can be sorted.
public protocol SortableAPIElement: APIElementProtocol, Comparable {}

extension SortableAPIElement {

  // MARK: - Comparable

  internal func comparisonIdentity() -> (String, String, String) {
    return (genericName.source(), possibleDeclaration?.source() ?? "", constraints?.source() ?? "")
  }

  public static func < (precedingValue: Self, followingValue: Self) -> Bool {
    return precedingValue.comparisonIdentity() < followingValue.comparisonIdentity()
  }

  // MARK: - Equatable

  public static func == (precedingValue: Self, followingValue: Self) -> Bool {
    return precedingValue.comparisonIdentity() == followingValue.comparisonIdentity()
  }
}
