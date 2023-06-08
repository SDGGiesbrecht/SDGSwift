/*
 OperatorDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SymbolKit
  import SwiftSyntax

  extension OperatorDeclSyntax {

    internal func api(url: String, source: SourceFileSyntax, module: String) -> Operator {
      var declarationComponents: [SymbolGraph.Symbol.DeclarationFragments.Fragment] = []
      if let fixity = modifiers?.first {
        declarationComponents.append(contentsOf: [
          SymbolGraph.Symbol.DeclarationFragments.Fragment(
            kind: .keyword,
            spelling: fixity.name.text,
            preciseIdentifier: nil
          ),
          SymbolGraph.Symbol.DeclarationFragments.Fragment(
            kind: .text,
            spelling: " ",
            preciseIdentifier: nil
          ),
        ])
      }
      declarationComponents.append(contentsOf: [
        SymbolGraph.Symbol.DeclarationFragments.Fragment(
          kind: .keyword,
          spelling: operatorKeyword.text,
          preciseIdentifier: nil
        ),
        SymbolGraph.Symbol.DeclarationFragments.Fragment(
          kind: .text,
          spelling: " ",
          preciseIdentifier: nil
        ),
        SymbolGraph.Symbol.DeclarationFragments.Fragment(
          kind: .identifier,
          spelling: identifier.text,
          preciseIdentifier: nil
        ),
      ])
      return Operator(
        names: SymbolGraph.Symbol.Names(
          title: identifier.text,
          navigator: nil,
          subHeading: declarationComponents,
          prose: nil
        ),
        declaration: SymbolGraph.Symbol.DeclarationFragments(
          declarationFragments: declarationComponents
        ),
        documentation: documentation(url: url, source: source, module: module),
        location: location(url: url, source: source)
      )
    }
  }
