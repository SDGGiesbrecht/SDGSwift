/*
 PackageAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SymbolKit

/// The API of a package.
public struct PackageAPI: SymbolLike {

  // MARK: - Initialization

  /// Creates a package API.
  ///
  /// - Parameters:
  ///   - name: The name of the package.
  ///   - libraries: The libraries.
  ///   - symbolGraphs: The symbol graphs.
  public init(
    name: String,
    libraries: [LibraryAPI],
    symbolGraphs: [SymbolGraph],
    moduleSources: [String: [URL]]
  ) {
    let declaration = [
      SymbolGraph.Symbol.DeclarationFragments.Fragment(
        kind: .typeIdentifier,
        spelling: "Package",
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
    self.names = SymbolGraph.Symbol.Names(
      title: name,
      navigator: nil,
      subHeading: declaration,
      prose: nil
    )
    self.declaration = SymbolGraph.Symbol.DeclarationFragments(declarationFragments: declaration)
    self.libraries = libraries
    var existing: Set<String> = []
    self.modules =
      libraries
      .flatMap({ $0.modules })
      .filter({ existing.insert($0).inserted })
      .map({ name in
        return ModuleAPI(
          name: name,
          symbolGraphs: symbolGraphs.filter({ $0.module.name == name }),
          sources: moduleSources[name] ?? []
        )
      })
  }

  // MARK: - Properties

  /// The library products vended by the package.
  public var libraries: [LibraryAPI]

  /// The modules vended in one or more library products.
  public var modules: [ModuleAPI]

  /// The package’s symbol graphs.
  public func symbolGraphs() -> [SymbolGraph] {
    return modules.flatMap { $0.symbolGraphs }
  }

  // MARK: - SymbolLike

  public var names: SymbolGraph.Symbol.Names
  public var declaration: SymbolGraph.Symbol.DeclarationFragments?
}