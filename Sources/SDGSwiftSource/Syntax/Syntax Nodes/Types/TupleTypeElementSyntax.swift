/*
 TupleTypeElementSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.3.1, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(WASI) || os(tvOS) || os(iOS) || os(Android) || os(watchOS))
  import SDGLogic

  import SwiftSyntax

  extension TupleTypeElementSyntax {

    internal func normalized() -> TupleTypeElementSyntax {
      return SyntaxFactory.makeTupleTypeElement(
        inOut: inOut?.generallyNormalized(trailingTrivia: .spaces(1)),
        name: name?.generallyNormalized(),
        secondName: secondName?.generallyNormalized(leadingTrivia: .spaces(1)),
        colon: colon?.generallyNormalized(trailingTrivia: .spaces(1)),
        type: type.normalized(),
        ellipsis: ellipsis?.generallyNormalized(),
        initializer: initializer?.normalizeForDefaultArgument(),
        trailingComma: trailingComma?.generallyNormalized(trailingTrivia: .spaces(1))
      )
    }
  }
#endif
