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

  extension SubscriptDeclSyntax: AccessControlled, APIDeclaration, Attributed,
    Constrained, Generic, Hidable, Member, OverloadableAPIDeclaration, OverridableDeclaration
  {

    // MARK: - APIDeclaration

    internal func normalizedAPIDeclaration() -> SubscriptDeclSyntax {
      let (newGenericParemeterClause, newGenericWhereClause) = normalizedGenerics()
      return SyntaxFactory.makeSubscriptDecl(
        attributes: attributes?.normalizedForAPIDeclaration(),
        modifiers: modifiers?.normalizedForAPIDeclaration(operatorFunction: false),
        subscriptKeyword: subscriptKeyword.generallyNormalizedAndMissingInsteadOfNil(),
        genericParameterClause: newGenericParemeterClause,
        indices: indices.normalizedForDeclaration(labelBehaviour: .subscript),
        result: result.normalizedForSubscriptDeclaration(),
        genericWhereClause: newGenericWhereClause,
        accessor: nil
      )
    }

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

    // MARK: - OverloadableAPIDeclaration

    internal func overloadPattern() -> SubscriptDeclSyntax {
      return SyntaxFactory.makeSubscriptDecl(
        attributes: nil,
        modifiers: modifiers?.forOverloadPattern(),
        subscriptKeyword: subscriptKeyword,
        genericParameterClause: nil,
        indices: indices.forOverloadPattern(labelBehaviour: .subscript),
        result: SyntaxFactory.makeBlankReturnClause(),
        genericWhereClause: nil,
        accessor: nil
      )
    }
  }
#endif
