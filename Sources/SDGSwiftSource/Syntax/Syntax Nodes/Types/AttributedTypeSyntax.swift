/*
 AttributedTypeSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.3, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(WASI) || os(Android))
  import SwiftSyntax

  extension AttributedTypeSyntax {

    internal func normalized() -> AttributedTypeSyntax {
      return SyntaxFactory.makeAttributedType(
        specifier: specifier?.generallyNormalized(trailingTrivia: .spaces(1)),
        attributes: attributes?.normalizedForAPIDeclaration(),
        baseType: baseType.normalized()
      )
    }
  }
#endif
