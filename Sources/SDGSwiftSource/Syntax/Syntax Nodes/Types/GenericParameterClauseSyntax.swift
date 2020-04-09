/*
 GenericParameterClauseSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(workspace version 0.32.0, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(WASI) || os(Android))
  import SDGLogic

  import SwiftSyntax

  extension GenericParameterClauseSyntax {

    internal func normalizedForAPIDeclaration() -> (
      GenericParameterClauseSyntax?, GenericWhereClauseSyntax?
    ) {
      let (newParameters, newConstraints) = genericParameterList.normalizedForAPIDeclaration()
      let parameters = SyntaxFactory.makeGenericParameterClause(
        leftAngleBracket: leftAngleBracket.generallyNormalizedAndMissingInsteadOfNil(),
        genericParameterList: newParameters,
        rightAngleBracket: rightAngleBracket.generallyNormalizedAndMissingInsteadOfNil()
      )
      var constraints: GenericWhereClauseSyntax?
      if let new = newConstraints {
        constraints = SyntaxFactory.makeGenericWhereClause(
          whereKeyword: SyntaxFactory.makeToken(
            .whereKeyword,
            leadingTrivia: .spaces(1),
            trailingTrivia: .spaces(1)
          ),
          requirementList: new
        )
      }
      return (parameters, constraints)
    }

    internal func identifierList() -> Set<String> {
      return Set(genericParameterList.map({ $0.name.text }))
    }
  }
#endif
