/*
 GenericArgumentSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftSyntax won’t compile.)
  import SwiftSyntax

  extension GenericArgumentSyntax {

    internal func normalized() -> GenericArgumentSyntax {
      return SyntaxFactory.makeGenericArgument(
        argumentType: argumentType.normalized(),
        trailingComma: trailingComma?.generallyNormalized(trailingTrivia: .spaces(1))
      )
    }
  }
#endif
