/*
 ReturnClauseSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.3.1, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(WASI) || os(tvOS) || os(iOS) || os(Android) || os(watchOS))
  import SwiftSyntax

  extension ReturnClauseSyntax {

    internal func normalizedForFunctionDeclaration() -> ReturnClauseSyntax? {
      let result = normalizedForSubscriptDeclaration()
      if result.returnType.source() == "Void" {
        return nil
      }
      return result
    }

    internal func normalizedForSubscriptDeclaration() -> ReturnClauseSyntax {
      return SyntaxFactory.makeReturnClause(
        arrow: arrow.generallyNormalizedAndMissingInsteadOfNil(
          leadingTrivia: .spaces(1),
          trailingTrivia: .spaces(1)
        ),
        returnType: returnType.normalized()
      )
    }
  }
#endif
