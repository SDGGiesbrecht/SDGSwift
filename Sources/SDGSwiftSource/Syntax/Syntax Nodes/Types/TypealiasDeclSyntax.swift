/*
 TypealiasDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SwiftSyntax

  extension TypealiasDeclSyntax: TypeDeclaration {

    // MARK: - Hidable

    internal var hidabilityIdentifier: TokenSyntax? {
      return identifier
    }

    // MARK: - TypeDeclaration

    internal var inheritanceClause: TypeInheritanceClauseSyntax? {
      return nil
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
