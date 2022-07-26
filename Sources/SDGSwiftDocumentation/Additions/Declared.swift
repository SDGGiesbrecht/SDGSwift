/*
 Declared.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SymbolKit

/// An API element that has a declaration.
public protocol Declared: SymbolLike {

  /// The symbol’s declaration.
  var declaration: [SymbolGraph.Symbol.DeclarationFragments.Fragment] { get }
}

extension Declared {

  // MARK: - SymbolLike

  public var possibleDeclaration: [SymbolGraph.Symbol.DeclarationFragments.Fragment]? {
    return declaration
  }
}
