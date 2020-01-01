/*
 ArrayTypeSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SwiftSyntax

extension ArrayTypeSyntax {

  internal func normalized() -> ArrayTypeSyntax {
    return SyntaxFactory.makeArrayType(
      leftSquareBracket: leftSquareBracket.generallyNormalizedAndMissingInsteadOfNil(),
      elementType: elementType.normalized(),
      rightSquareBracket: rightSquareBracket.generallyNormalizedAndMissingInsteadOfNil()
    )
  }
}
