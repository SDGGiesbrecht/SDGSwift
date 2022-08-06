/*
 LibraryAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SymbolKit

/// The API of a library.
public struct LibraryAPI: SymbolLike {

  /// Creates a library API.
  ///
  /// - Parameters:
  ///   - name: The name of the library.
  ///   - modules: The names of the modules included in the library.
  public init(name: String, modules: [String]) {
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
      ],
      prose: nil
    )
    self.modules = modules
  }

  /// The names of the library.
  public var names: SymbolGraph.Symbol.Names

  /// The names of the modules included in the library.
  public var modules: [String]
}
