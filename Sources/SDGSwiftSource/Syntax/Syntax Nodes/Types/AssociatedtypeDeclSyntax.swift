/*
 AssociatedtypeDeclSyntax.swift

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

  extension AssociatedtypeDeclSyntax: AccessControlled, Attributed, Constrained, Hidable,
    TypeDeclaration
  {

    // MARK: - Hidable

    internal var hidabilityIdentifier: TokenSyntax? {
      return identifier
    }

    // MARK: - TypeDeclaration

    internal var genericParameterClause: GenericParameterClauseSyntax? {
      return nil
    }

    internal func normalizedAPIDeclaration() -> (
      declaration: AssociatedtypeDeclSyntax, constraints: GenericWhereClauseSyntax?
    ) {
      return (
        SyntaxFactory.makeAssociatedtypeDecl(
          attributes: attributes?.normalizedForAPIDeclaration(),
          modifiers: modifiers?.normalizedForAPIDeclaration(operatorFunction: false),
          associatedtypeKeyword: associatedtypeKeyword.generallyNormalizedAndMissingInsteadOfNil(
            trailingTrivia: .spaces(1)
          ),
          identifier: identifier.generallyNormalizedAndMissingInsteadOfNil(),
          inheritanceClause: nil,
          initializer: nil,
          genericWhereClause: nil
        ),
        genericWhereClause?.normalized()
      )
    }

    internal func name() -> AssociatedtypeDeclSyntax {
      return SyntaxFactory.makeAssociatedtypeDecl(
        attributes: nil,
        modifiers: nil,
        associatedtypeKeyword: SyntaxFactory.makeToken(.associatedtypeKeyword, presence: .missing),
        identifier: identifier,
        inheritanceClause: nil,
        initializer: nil,
        genericWhereClause: nil
      )
    }
  }
#endif
