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

  /// The symbol’s names.
  var names: SymbolGraph.Symbol.Names { get }

  /// The symbol’s declaration.
  var declaration: SymbolGraph.Symbol.DeclarationFragments? { get }

  /// The symbol’s documentation comment.
  var docComment: SymbolGraph.LineList? { get }

  /// The location of the symbol in the source code.
  var location: SymbolGraph.Symbol.Location? { get }

  /// The symbol’s documentation.
  func documentation() -> [SymbolDocumentation]
}

extension SymbolLike {

  public func documentation() -> [SymbolDocumentation] {
    guard let first = docComment?.lines.first?.range?.start else {
      #warning("Custom scanned lines do not contain range information.")
      return []
    }
    #warning("Not implemented yet.")
    return []
  }
}
