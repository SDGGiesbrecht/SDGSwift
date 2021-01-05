/*
 SimpleTypeIdentifierSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.3.2, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(WASI) || os(tvOS) || os(iOS) || os(Android) || os(watchOS))
  import SDGLogic

  import SwiftSyntax

  extension SimpleTypeIdentifierSyntax {

    internal func normalized() -> TypeSyntax {
      let newGenericArgumentClause = genericArgumentClause?.normalized()

      let result = SyntaxFactory.makeSimpleTypeIdentifier(
        name: name.generallyNormalizedAndMissingInsteadOfNil(),
        genericArgumentClause: newGenericArgumentClause
      )

      if result.name.text == "Array",
        let elements = newGenericArgumentClause?.arguments,
        elements.count == 1,
        let element = elements.first?.argumentType
      {
        return TypeSyntax(
          SyntaxFactory.makeArrayType(
            leftSquareBracket: SyntaxFactory.makeToken(.leftSquareBracket),
            elementType: element,
            rightSquareBracket: SyntaxFactory.makeToken(.rightSquareBracket)
          )
        )
      } else if result.name.text == "Dictionary",
        let elements = newGenericArgumentClause?.arguments,
        elements.count == 2,
        let key = elements.first?.argumentType,
        let value = elements.dropFirst().first?.argumentType
      {
        return TypeSyntax(
          SyntaxFactory.makeDictionaryType(
            leftSquareBracket: SyntaxFactory.makeToken(.leftSquareBracket),
            keyType: key,
            colon: SyntaxFactory.makeToken(.colon, trailingTrivia: .spaces(1)),
            valueType: value,
            rightSquareBracket: SyntaxFactory.makeToken(.rightSquareBracket)
          )
        )
      }
      return TypeSyntax(result)
    }
  }
#endif
