/*
 SubscriptDeclSyntax.swift

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

  extension SubscriptDeclSyntax: Hidable, Member, OverridableDeclaration
  {

    // MARK: - APIDeclaration

    internal func name() -> SubscriptDeclSyntax {
      return SyntaxFactory.makeSubscriptDecl(
        attributes: nil,
        modifiers: nil,
        subscriptKeyword: SyntaxFactory.makeToken(.subscriptKeyword),
        genericParameterClause: nil,
        indices: indices.forName(labelBehaviour: .subscript),
        result: SyntaxFactory.makeBlankReturnClause(),
        genericWhereClause: nil,
        accessor: nil
      )
    }

    internal func identifierList() -> Set<String> {
      return indices.identifierList(labelBehaviour: .subscript)
    }

    // MARK: - Hidable

    internal var hidabilityIdentifier: TokenSyntax? {
      return indices.parameterList.first?.firstName
    }
  }
#endif
