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

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SwiftSyntax
#endif
#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
  import SwiftSyntaxParser
#endif

import SymbolKit

/// The API of a module.
public struct ModuleAPI: SymbolLike {

  /// Creates a module API.
  ///
  /// - Parameters:
  ///   - name: The name of the module.
  ///   - symbolGraphs: The module’s symbol graphs.
  ///   - sources: The URL’s of the module’s sources.
  public init(name: String, symbolGraphs: [SymbolGraph], sources: [URL]) {
    self.names = SymbolGraph.Symbol.Names(
      title: name,
      navigator: nil,
      subHeading: [
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
      ],
      prose: nil
    )
    self.symbolGraphs = symbolGraphs

    var operators: [Operator] = []
    var precedenceGroups: [PrecedenceGroup] = []
    for sourceFile in sources.filter({ $0.pathExtension == "swift" }).sorted() {
      purgingAutoreleased {
        #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
          if let source = try? SyntaxParser.parse(sourceFile) {
            let syntax = Syntax(source)
            operators.append(contentsOf: syntax.operators())
            precedenceGroups.append(contentsOf: syntax.precedenceGroups())
          }
        #endif
      }
    }
    self.operators = operators.sorted()
    self.precedenceGroups = precedenceGroups.sorted()
  }

  /// The names of the module.
  public var names: SymbolGraph.Symbol.Names

  /// The module’s symbol graphs.
  public var symbolGraphs: [SymbolGraph]

  /// The module’s operators.
  public var operators: [Operator]

  /// The module’s precedence groups.
  public var precedenceGroups: [PrecedenceGroup]
}
