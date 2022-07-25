/*
 ModuleAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow

import SwiftSyntax
#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
  import SwiftSyntaxParser
#endif

import SymbolKit

/// The API of a module.
public struct ModuleAPI: Declared {

  /// Creates a module API.
  ///
  /// - Parameters:
  ///   - name: The name of the module.
  ///   - symbolGraphs: The module’s symbol graphs.
  ///   - sources: The URL’s of the module’s sources.
  public init(name: String, symbolGraphs: [SymbolGraph], sources: [URL]) {
    self.name = name
    self.symbolGraphs = symbolGraphs

    var operators: [Operator] = []
    for sourceFile in sources.filter({ $0.pathExtension == "swift" }).sorted() {
      purgingAutoreleased {
        if let source = try? SyntaxParser.parse(sourceFile) {
          operators.append(contentsOf: Syntax(source).operators())
        }
      }
    }
    self.operators = operators.sorted()
  }

  /// The name of the module.
  public var name: String

  /// The module’s symbol graphs.
  public var symbolGraphs: [SymbolGraph]

  public var operators: [Operator]

  // MARK: - Declared

  /// The module’s declaration.
  public var declaration: [SymbolGraph.Symbol.DeclarationFragments.Fragment] {
    return [
      SymbolGraph.Symbol.DeclarationFragments.Fragment(
        kind: .text,
        spelling: ".",
        preciseIdentifier: nil
      ),
      SymbolGraph.Symbol.DeclarationFragments.Fragment(
        kind: .identifier,
        spelling: "target",
        preciseIdentifier: nil
      ),
      SymbolGraph.Symbol.DeclarationFragments.Fragment(
        kind: .text,
        spelling: "(",
        preciseIdentifier: nil
      ),
      SymbolGraph.Symbol.DeclarationFragments.Fragment(
        kind: .externalParameter,
        spelling: "name",
        preciseIdentifier: nil
      ),
      SymbolGraph.Symbol.DeclarationFragments.Fragment(
        kind: .text,
        spelling: ":",
        preciseIdentifier: nil
      ),
      SymbolGraph.Symbol.DeclarationFragments.Fragment(
        kind: .text,
        spelling: " ",
        preciseIdentifier: nil
      ),
      SymbolGraph.Symbol.DeclarationFragments.Fragment(
        kind: .stringLiteral,
        spelling: "\u{22}\(name)\u{22}",
        preciseIdentifier: nil
      ),
      SymbolGraph.Symbol.DeclarationFragments.Fragment(
        kind: .text,
        spelling: ")",
        preciseIdentifier: nil
      ),
    ]
  }
}
