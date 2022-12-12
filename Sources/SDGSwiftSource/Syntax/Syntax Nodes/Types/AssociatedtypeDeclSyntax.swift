/*
 AssociatedtypeDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SwiftSyntax

  extension AssociatedtypeDeclSyntax: Hidable,
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
