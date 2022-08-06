/*
 Operator.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGMathematics

import SymbolKit

public struct Operator: Comparable, SymbolLike {

  /// Creates an operator.
  ///
  /// - Parameters:
  ///   - names: The names.
  public init(
    names: SymbolGraph.Symbol.Names
  ) {
    self.names = names
  }

  // MARK: - Comparable

  public static func < (preceding: Operator, following: Operator) -> Bool {
    return compare(preceding, following, by: { ComparableNames(names: $0.names) })
  }

  // MARK: - SymbolLike

  public let names: SymbolGraph.Symbol.Names
}
