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

  // MARK: - Initialization

  private static func declaration(
    for name: String
  ) -> [SymbolGraph.Symbol.DeclarationFragments.Fragment] {
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

  #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
    internal static func lookUpDocumentation(
      for name: String,
      in manifestSource: SourceFileSyntax
    ) -> SymbolGraph.LineList? {
      return PackageAPI.findDocumentation(
        of: ModuleAPI.declaration(for: name),
        in: manifestSource,
        as: FunctionCallExprSyntax.self
      )
    }

    /// Creates a module API.
    ///
    /// - Parameters:
    ///   - name: The name of the module.
    ///   - symbolGraphs: The module’s symbol graphs.
    ///   - sources: The URL’s of the module’s sources.
    ///   - manifestSource: The source of the package manifest.
    public init(
      name: String,
      symbolGraphs: [SymbolGraph],
      sources: [URL],
      manifestSource: SourceFileSyntax
    ) {
      self.init(
        name: name,
        documentationComment: ModuleAPI.lookUpDocumentation(for: name, in: manifestSource),
        symbolGraphs: symbolGraphs,
        sources: sources
      )
    }
  #endif

  /// Creates a module API.
  ///
  /// - Parameters:
  ///   - name: The name of the module.
  ///   - documentationComment: The documentation comment.
  ///   - symbolGraphs: The module’s symbol graphs.
  ///   - sources: The URL’s of the module’s sources.
  public init(
    name: String,
    documentationComment: SymbolGraph.LineList?,
    symbolGraphs: [SymbolGraph],
    sources: [URL]
  ) {
    let declaration = ModuleAPI.declaration(for: name)
    self.names = SymbolGraph.Symbol.Names(
      title: name,
      navigator: nil,
      subHeading: declaration,
      prose: nil
    )
    self.declaration = SymbolGraph.Symbol.DeclarationFragments(declarationFragments: declaration)
    self.docComment = documentationComment
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

  // MARK: - Properties

  /// The module’s symbol graphs.
  public var symbolGraphs: [SymbolGraph]

  /// The module’s operators.
  public var operators: [Operator]

  /// The module’s precedence groups.
  public var precedenceGroups: [PrecedenceGroup]

  // MARK: - SymbolLike

  public var names: SymbolGraph.Symbol.Names
  public var declaration: SymbolGraph.Symbol.DeclarationFragments?
  public var docComment: SymbolGraph.LineList?
}
