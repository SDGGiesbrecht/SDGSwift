/*
 SymbolGraph.Symbol.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SymbolKit

extension SymbolGraph.Symbol: SymbolLike {

  // MARK: - SymbolLike

  public var declaration: DeclarationFragments? {
    return mixins[DeclarationFragments.mixinKey] as? DeclarationFragments
  }

  public var location: Location? {
    return mixins[Location.mixinKey] as? Location
  }
}
