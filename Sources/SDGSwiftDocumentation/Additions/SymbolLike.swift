/*
 SymbolLike.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SymbolKit

/// `SymbolGraph.Symbol` or a type that provides the same information, but represents something not supported by `SymbolKit`.
public protocol SymbolLike {

  /// The symbol’s names.
  var names: SymbolGraph.Symbol.Names { get }

  /// The symbol’s declaration.
  var declaration: SymbolGraph.Symbol.DeclarationFragments? { get }

  // @documentation(SymbolLike.docComment)
  /// The symbol’s documentation comment.
  var docComment: SymbolGraph.LineList? { get }

  /// The location of the symbol in the source code.
  var location: SymbolGraph.Symbol.Location? { get }

  // @documentation(SymbolLike.parseDocumentation(cache:module:))
  /// Parses the symbol’s documentation.
  ///
  /// If the documentation cannot be located or parsed, the result will be empty.
  ///
  /// - Parameters:
  ///   - cache: Pass an empty dictionary on the first call, after which the same dictionary can be passed to later calls to reduce the amount of redundant parsing.
  ///   - module: The name of the module.
  func parseDocumentation(
    cache: inout [URL: SymbolGraph.Symbol.CachedSource],
    module: String?
  ) -> [SymbolDocumentation]
}
