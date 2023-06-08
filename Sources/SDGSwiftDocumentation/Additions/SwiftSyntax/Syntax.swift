/*
 Syntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SymbolKit
  import SwiftSyntax

  extension SwiftSyntax.Syntax {

    internal func operators(url: String, source: SourceFileSyntax, module: String) -> [Operator] {
      if let declaration = self.as(OperatorDeclSyntax.self) {
        return [declaration.api(url: url, source: source, module: module)]
      } else {
        return children(viewMode: .sourceAccurate).flatMap({
          $0.operators(url: url, source: source, module: module)
        })
      }
    }

    internal func precedenceGroups(
      url: String,
      source: SourceFileSyntax,
      module: String
    ) -> [PrecedenceGroup] {
      if let declaration = self.as(PrecedenceGroupDeclSyntax.self) {
        return [declaration.api(url: url, source: source, module: module)]
      } else {
        return children(viewMode: .sourceAccurate).flatMap({
          $0.precedenceGroups(url: url, source: source, module: module)
        })
      }
    }
  }
