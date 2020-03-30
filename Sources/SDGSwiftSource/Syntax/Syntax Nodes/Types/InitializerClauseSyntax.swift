/*
 InitializerClauseSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftSyntax won’t compile.)
  import SwiftSyntax

  extension InitializerClauseSyntax {

    internal func normalizeForDefaultArgument() -> InitializerClauseSyntax {
      return SyntaxFactory.makeInitializerClause(
        equal: equal.generallyNormalizedAndMissingInsteadOfNil(
          leadingTrivia: .spaces(1),
          trailingTrivia: .spaces(1)
        ),
        value: ExprSyntax(SyntaxFactory.makeIdentifierExpr(
          identifier: SyntaxFactory.makeToken(.contextualKeyword("default")),
          declNameArguments: nil
        ))
      )
    }
  }
#endif
