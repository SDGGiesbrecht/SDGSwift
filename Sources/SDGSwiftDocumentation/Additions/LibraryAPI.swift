/*
 LibraryAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SymbolKit
  import SwiftSyntax

/// The API of a library.
public struct LibraryAPI: StoredDocumentation, SymbolLike {

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
        spelling: "library",
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

    /// Creates a library API.
    ///
    /// - Parameters:
    ///   - name: The name of the library.
    ///   - modules: The names of the modules included in the library.
    ///   - manifestURL: The URL of the manifest.
    ///   - manifest: The source of the package manifest.
    public init(name: String, modules: [String], manifestURL: String, manifest: SourceFileSyntax) {
      let declaration = PackageAPI.find(
        LibraryAPI.declaration(for: name),
        in: manifest,
        as: FunctionCallExprSyntax.self
      )
      self.init(
        name: name,
        documentation: declaration?.documentation(url: manifestURL, source: manifest, module: nil)
          ?? [],
        location: declaration?.location(url: manifestURL, source: manifest),
        modules: modules
      )
    }

  /// Creates a library API.
  ///
  /// - Parameters:
  ///   - name: The name of the library.
  ///   - documentation: The documentation.
  ///   - location: The location of the declaration.
  ///   - modules: The names of the modules included in the library.
  public init(
    name: String,
    documentation: [SymbolDocumentation],
    location: SymbolGraph.Symbol.Location?,
    modules: [String]
  ) {
    let declaration = LibraryAPI.declaration(for: name)
    self.names = SymbolGraph.Symbol.Names(
      title: name,
      navigator: nil,
      subHeading: declaration,
      prose: nil
    )
    self.declaration = SymbolGraph.Symbol.DeclarationFragments(declarationFragments: declaration)
    self.documentation = documentation
    self.modules = modules
    self.location = location
  }

  // MARK: - Properties

  /// The names of the modules included in the library.
  public var modules: [String]

  // MARK: - SymbolLike

  public var names: SymbolGraph.Symbol.Names
  public var declaration: SymbolGraph.Symbol.DeclarationFragments?
  public var location: SymbolGraph.Symbol.Location?
  /// The documentation.
  public var documentation: [SymbolDocumentation]
}
