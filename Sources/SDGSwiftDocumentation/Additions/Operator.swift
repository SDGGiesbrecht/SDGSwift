/*
 Operator.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

import SymbolKit

public struct Operator: Comparable, Declared {

  /// Creates an operator.
  ///
  /// - Parameters:
  ///   - declaration: The declaration.
  public init(
    declaration: [SymbolGraph.Symbol.DeclarationFragments.Fragment]
  ) {
    self.declaration = declaration
    self.comparisonValue = declaration.map({ $0.spelling }).joined()
  }

  // MARK: - Comparable

  private let comparisonValue: String
  public static func < (preceding: Operator, following: Operator) -> Bool {
    return compare(preceding, following, by: { $0.comparisonValue })
  }

  // MARK: - Declared

  public let declaration: [SymbolGraph.Symbol.DeclarationFragments.Fragment]
}
