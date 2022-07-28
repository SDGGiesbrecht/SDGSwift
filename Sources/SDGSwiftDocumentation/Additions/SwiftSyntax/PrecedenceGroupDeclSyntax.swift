/*
 PrecedenceGroupDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SymbolKit

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SwiftSyntax

  extension PrecedenceGroupDeclSyntax {

    internal func api() -> PrecedenceGroup {
      return PrecedenceGroup(
        name: identifier.text,
        declaration: [
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
      )
    }
  }
#endif
