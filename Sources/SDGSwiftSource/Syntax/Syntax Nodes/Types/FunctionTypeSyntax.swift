/*
 FunctionTypeSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.3.1, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(WASI) || os(tvOS) || os(iOS) || os(Android) || os(watchOS))
  import SwiftSyntax

  extension FunctionTypeSyntax {

    internal func normalized() -> FunctionTypeSyntax {
      return SyntaxFactory.makeFunctionType(
        leftParen: leftParen.generallyNormalizedAndMissingInsteadOfNil(),
        arguments: arguments.normalized(),
        rightParen: rightParen.generallyNormalizedAndMissingInsteadOfNil(),
        throwsOrRethrowsKeyword: throwsOrRethrowsKeyword?.generallyNormalized(
          leadingTrivia: .spaces(1)
        ),
        arrow: arrow.generallyNormalizedAndMissingInsteadOfNil(
          leadingTrivia: .spaces(1),
          trailingTrivia: .spaces(1)
        ),
        returnType: returnType.normalized()
      )
    }
  }
#endif
