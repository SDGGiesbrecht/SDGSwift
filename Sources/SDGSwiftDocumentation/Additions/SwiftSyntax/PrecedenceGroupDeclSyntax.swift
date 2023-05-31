/*
 PrecedenceGroupDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SymbolKit
  import SwiftSyntax

  extension PrecedenceGroupDeclSyntax {

    internal func api(url: String, source: SourceFileSyntax, module: String) -> PrecedenceGroup {
      let declaration = [
        SymbolGraph.Symbol.DeclarationFragments.Fragment(
          kind: .keyword,
          spelling: precedencegroupKeyword.text,
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
      ]
      return PrecedenceGroup(
        names: SymbolGraph.Symbol.Names(
          title: identifier.text,
          navigator: nil,
          subHeading: declaration,
          prose: nil
        ),
        declaration: SymbolGraph.Symbol.DeclarationFragments(declarationFragments: declaration),
        documentation: documentation(url: url, source: source, module: module),
        location: location(url: url, source: source)
      )
    }
  }
