/*
 SymbolLike.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SymbolKit

/// `SymbolGraph.Symbol` or a type that provides the same information, but represents something not supported by `SymbolKit`.
public protocol SymbolLike {

  // #workaround(Once these satisfy all legacy capabilities, adapt to more closely resemble Symbol.)

  /// The symbol’s name.
  var name: String { get }

  /// The symbol’s declaration, if it has one.
  var possibleDeclaration: [SymbolGraph.Symbol.DeclarationFragments.Fragment]? { get }
}
