/*
 EnumDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SDGLogic

  import SwiftSyntax

  extension EnumDeclSyntax: Generic, Hidable,
    TypeDeclaration
  {

    // MARK: - Hidable

    internal var hidabilityIdentifier: TokenSyntax? {
      return identifier
    }

    // MARK: - TypeDeclaration

    internal var genericParameterClause: GenericParameterClauseSyntax? {
      return genericParameters
    }

    internal func name() -> EnumDeclSyntax {
      return SyntaxFactory.makeEnumDecl(
        attributes: nil,
        modifiers: nil,
        enumKeyword: SyntaxFactory.makeToken(.enumKeyword, presence: .missing),
        identifier: identifier,
        genericParameters: genericParameterClause,
        inheritanceClause: nil,
        genericWhereClause: nil,
        members: SyntaxFactory.makeBlankMemberDeclBlock()
      )
    }
  }
#endif
