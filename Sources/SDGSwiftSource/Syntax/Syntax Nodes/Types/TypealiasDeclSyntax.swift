/*
 TypealiasDeclSyntax.swift

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

  extension TypealiasDeclSyntax: Constrained, Generic, Hidable, TypeDeclaration {

    // MARK: - Hidable

    var hidabilityIdentifier: TokenSyntax? {
      return identifier
    }

    // MARK: - TypeDeclaration

    var inheritanceClause: TypeInheritanceClauseSyntax? {
      return nil
    }

    internal func normalizedAPIDeclaration() -> (
      declaration: TypealiasDeclSyntax, constraints: GenericWhereClauseSyntax?
    ) {
      let (newGenericParemeterClause, newGenericWhereClause) = normalizedGenerics()
      return (
        SyntaxFactory.makeTypealiasDecl(
          attributes: attributes?.normalizedForAPIDeclaration(),
          modifiers: modifiers?.normalizedForAPIDeclaration(operatorFunction: false),
          typealiasKeyword: typealiasKeyword.generallyNormalizedAndMissingInsteadOfNil(
            trailingTrivia: .spaces(1)
          ),
          identifier: identifier.generallyNormalizedAndMissingInsteadOfNil(),
          genericParameterClause: newGenericParemeterClause,
          initializer: nil,
          genericWhereClause: nil
        ),
        newGenericWhereClause
      )
    }

    internal func name() -> TypealiasDeclSyntax {
      return SyntaxFactory.makeTypealiasDecl(
        attributes: nil,
        modifiers: nil,
        typealiasKeyword: SyntaxFactory.makeToken(.typealiasKeyword, presence: .missing),
        identifier: identifier,
        genericParameterClause: genericParameterClause,
        initializer: nil,
        genericWhereClause: nil
      )
    }
  }
#endif
