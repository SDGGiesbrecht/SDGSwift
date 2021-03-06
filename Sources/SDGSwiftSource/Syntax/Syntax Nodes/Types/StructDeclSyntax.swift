/*
 StructDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SDGLogic

  import SwiftSyntax

  extension StructDeclSyntax: AccessControlled, Attributed, Constrained, Generic, Hidable,
    TypeDeclaration
  {

    // MARK: - Hidable

    internal var hidabilityIdentifier: TokenSyntax? {
      return identifier
    }

    // MARK: - TypeDeclaration

    internal func normalizedAPIDeclaration() -> (
      declaration: StructDeclSyntax, constraints: GenericWhereClauseSyntax?
    ) {
      let (newGenericParemeterClause, newGenericWhereClause) = normalizedGenerics()
      return (
        SyntaxFactory.makeStructDecl(
          attributes: attributes?.normalizedForAPIDeclaration(),
          modifiers: modifiers?.normalizedForAPIDeclaration(operatorFunction: false),
          structKeyword: structKeyword.generallyNormalizedAndMissingInsteadOfNil(
            trailingTrivia: .spaces(1)
          ),
          identifier: identifier.generallyNormalizedAndMissingInsteadOfNil(),
          genericParameterClause: newGenericParemeterClause,
          inheritanceClause: nil,
          genericWhereClause: nil,
          members: SyntaxFactory.makeBlankMemberDeclBlock()
        ),
        newGenericWhereClause
      )
    }

    internal func name() -> StructDeclSyntax {
      return SyntaxFactory.makeStructDecl(
        attributes: nil,
        modifiers: nil,
        structKeyword: SyntaxFactory.makeToken(.structKeyword, presence: .missing),
        identifier: identifier,
        genericParameterClause: genericParameterClause,
        inheritanceClause: nil,
        genericWhereClause: nil,
        members: SyntaxFactory.makeBlankMemberDeclBlock()
      )
    }
  }
#endif
