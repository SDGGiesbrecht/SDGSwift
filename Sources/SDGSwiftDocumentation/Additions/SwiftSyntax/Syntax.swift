/*
 Syntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SymbolKit

import SwiftSyntax

extension SwiftSyntax.Syntax {

  internal func operators() -> [Operator] {
    if let declaration = self.as(OperatorDeclSyntax.self) {
      return [declaration.api()]
    } else {
      return children.flatMap({ $0.operators() })
    }
  }
}
