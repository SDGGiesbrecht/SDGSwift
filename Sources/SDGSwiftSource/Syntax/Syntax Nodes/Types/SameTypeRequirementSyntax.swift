/*
 SameTypeRequirementSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(workspace version 0.32.0, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(Android))
  import SwiftSyntax

  extension SameTypeRequirementSyntax {

    internal func normalized() -> SameTypeRequirementSyntax {
      var types = (leftTypeIdentifier.normalized(), rightTypeIdentifier.normalized())
      if types.0.source() > types.1.source() {
        swap(&types.0, &types.1)
      }
      return SyntaxFactory.makeSameTypeRequirement(
        leftTypeIdentifier: types.0,
        equalityToken: SyntaxFactory.makeToken(
          .spacedBinaryOperator("=="),
          leadingTrivia: .spaces(1),
          trailingTrivia: .spaces(1)
        ),
        rightTypeIdentifier: types.1
      )
    }
  }
#endif
