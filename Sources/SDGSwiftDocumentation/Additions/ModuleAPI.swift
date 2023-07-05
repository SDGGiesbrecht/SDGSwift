/*
 ModuleAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

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
public struct ModuleAPI: StoredDocumentation, SymbolLike {

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

    internal static func lookUpDeclaration(
      for name: String,
      in manifestSource: SourceFileSyntax
    ) -> FunctionCallExprSyntax? {
      return PackageAPI.find(
        ModuleAPI.declaration(for: name),
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
    ///   - manifestURL: The URL of the manifest.
    ///   - manifestSource: The source of the package manifest.
    public init(
      name: String,
      symbolGraphs: [LoadedSymbolGraph],
      sources: [URL],
      manifestURL: String,
      manifestSource: SourceFileSyntax
    ) {
      let declaration = ModuleAPI.lookUpDeclaration(for: name, in: manifestSource)
      self.init(
        name: name,
        documentation: declaration?.documentation(
          url: manifestURL,
          source: manifestSource,
          module: nil
        ) ?? [],
        location: declaration?.location(url: manifestURL, source: manifestSource),
        symbolGraphs: symbolGraphs,
        sources: sources
      )
    }

  /// Creates a module API.
  ///
  /// - Parameters:
  ///   - name: The name of the module.
  ///   - documentation: The documentation.
  ///   - location: The location of the declaration in the source code.
  ///   - symbolGraphs: The module’s symbol graphs.
  ///   - sources: The URL’s of the module’s sources.
  public init(
    name: String,
    documentation: [SymbolDocumentation],
    location: SymbolGraph.Symbol.Location?,
    symbolGraphs: [LoadedSymbolGraph],
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
    self.documentation = documentation
    self.location = location
    self.symbolGraphs = symbolGraphs

    var operators: [Operator] = []
    var precedenceGroups: [PrecedenceGroup] = []
    for sourceFile in sources.filter({ $0.pathExtension == "swift" }).sorted() {
      purgingAutoreleased {
        #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
          let url = sourceFile.absoluteString
          if let source = try? SyntaxParser.parse(sourceFile) {
            let syntax = Syntax(source)
            operators.append(contentsOf: syntax.operators(url: url, source: source, module: name))
            precedenceGroups.append(
              contentsOf: syntax.precedenceGroups(url: url, source: source, module: name)
            )
          }
        #endif
      }
    }
    self.operators = operators.sorted()
    self.precedenceGroups = precedenceGroups.sorted()
  }

  // MARK: - Properties

  /// The module’s symbol graphs.
  public var symbolGraphs: [LoadedSymbolGraph]

  /// The module’s operators.
  public var operators: [Operator]

  /// The module’s precedence groups.
  public var precedenceGroups: [PrecedenceGroup]

  // MARK: - SymbolLike

  public var names: SymbolGraph.Symbol.Names
  public var declaration: SymbolGraph.Symbol.DeclarationFragments?
  public var location: SymbolGraph.Symbol.Location?
  /// The documentation.
  public var documentation: [SymbolDocumentation]
}
