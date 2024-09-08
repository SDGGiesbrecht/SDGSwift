/*
 SymbolGraph.Symbol.Names.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

import SymbolKit

internal struct ComparableNames: Comparable {

  // MARK: - Properties

  internal var names: SymbolGraph.Symbol.Names

  // MARK: - Comparable

  internal static func < (lhs: ComparableNames, rhs: ComparableNames) -> Bool {
    return compare(
      lhs,
      rhs,
      by: { $0.names.title },
      { $0.names.navigator?.map({ $0.spelling }).joined() ?? $0.names.title },
      { $0.names.subHeading?.map({ $0.spelling }).joined() ?? $0.names.title },
      { $0.names.prose ?? $0.names.title }
    )
  }
}
