/*
 PrecedenceGroup.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

import SymbolKit

public struct PrecedenceGroup: Comparable, SymbolLike {

  // MARK: - Initialization

  /// Creates a precedence group.
  ///
  /// - Parameters:
  ///   - names: The names.
  ///   - declaration: The declaration.
  public init(
    names: SymbolGraph.Symbol.Names,
    declaration: SymbolGraph.Symbol.DeclarationFragments
  ) {
    self.names = names
    self.declaration = declaration
    #warning("Needs to collect documentation comment.")
  }

  // MARK: - Comparable

  public static func < (preceding: PrecedenceGroup, following: PrecedenceGroup) -> Bool {
    return compare(preceding, following, by: { ComparableNames(names: $0.names) })
  }

  // MARK: - Equatable

  public static func == (preceding: PrecedenceGroup, following: PrecedenceGroup) -> Bool {
    return ComparableNames(names: preceding.names) == ComparableNames(names: following.names)
  }

  // MARK: - SymbolLike

  public var names: SymbolGraph.Symbol.Names
  public var declaration: SymbolGraph.Symbol.DeclarationFragments?
  public var docComment: SymbolGraph.LineList?
}
