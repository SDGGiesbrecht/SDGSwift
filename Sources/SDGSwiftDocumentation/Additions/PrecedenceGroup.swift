/*
 PrecedenceGroup.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

import SymbolKit

/// A precedence group.
public struct PrecedenceGroup: Comparable, StoredDocumentation, SymbolLike {

  // MARK: - Initialization

  /// Creates a precedence group.
  ///
  /// - Parameters:
  ///   - names: The names.
  ///   - declaration: The declaration.
  ///   - documentation: The documentation.
  ///   - location: The location.
  public init(
    names: SymbolGraph.Symbol.Names,
    declaration: SymbolGraph.Symbol.DeclarationFragments,
    documentation: [SymbolDocumentation],
    location: SymbolGraph.Symbol.Location?
  ) {
    self.names = names
    self.declaration = declaration
    self.documentation = documentation
    self.location = location
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
  public var location: SymbolGraph.Symbol.Location?
  /// The documentation.
  public var documentation: [SymbolDocumentation]
}
