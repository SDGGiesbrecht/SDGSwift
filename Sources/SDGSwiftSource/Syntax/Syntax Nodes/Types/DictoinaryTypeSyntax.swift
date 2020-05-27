/*
 DictoinaryTypeSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.2.4, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(WASI) || os(Android))
  import SwiftSyntax

  extension DictionaryTypeSyntax {

    internal func normalized() -> DictionaryTypeSyntax {
      return SyntaxFactory.makeDictionaryType(
        leftSquareBracket: leftSquareBracket.generallyNormalizedAndMissingInsteadOfNil(),
        keyType: keyType.normalized(),
        colon: colon.generallyNormalizedAndMissingInsteadOfNil(trailingTrivia: .spaces(1)),
        valueType: valueType.normalized(),
        rightSquareBracket: rightSquareBracket.generallyNormalizedAndMissingInsteadOfNil()
      )
    }
  }
#endif
