/*
 PackageAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGSwiftPackageManager

import SymbolKit

/// The API of a package.
public struct PackageAPI {

  /// Creates a package API.
  ///
  /// - Parameters:
  ///   - name: The name of the package.
  ///   - libraries: The library names.
  ///   - symbolGraphs: The symbol graphs.
  public init(
    name: String,
    libraries: [String],
    symbolGraphs: [SymbolGraph]
  ) {
    self.init(
      name: name,
      libraries: libraries.map({ LibraryAPI(name: $0) }),
      symbolGraphs: symbolGraphs
    )
  }

  /// Creates a package API.
  ///
  /// - Parameters:
  ///   - name: The name of the package.
  ///   - libraries: The libraries.
  ///   - symbolGraphs: The symbol graphs.
  public init(
    name: String,
    libraries: [LibraryAPI],
    symbolGraphs: [SymbolGraph]
  ) {
    self.name = name
    self.libraries = libraries
    self.symbolGraphs = symbolGraphs
  }

  // MARK: - Properties

  /// The name of the package.
  public var name: String

  /// The library products vended by the package.
  public var libraries: [LibraryAPI]

  /// The modules vended in one or more library products.
  public func modules() -> [SymbolGraph.Module] {
    var existing: Set<String> = []
    return
      symbolGraphs
      .compactMap({ $0.module })
      .filter({ existing.insert($0.name).inserted })
  }

  /// The package’s symbol graphs.
  public var symbolGraphs: [SymbolGraph]

  /// The package’s declaration.
  public var declaration: [SymbolGraph.Symbol.DeclarationFragments.Fragment] {
    return [
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
  }
}
