/*
 SubscriptDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(workspace version 0.32.0, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(Android))
  import SDGLogic

  import SwiftSyntax

  extension SubscriptDeclSyntax: AccessControlled, Accessor, APIDeclaration, APISyntax, Attributed,
    Constrained, Generic, Hidable, Member, OverloadableAPIDeclaration, OverridableDeclaration
  {

    // MARK: - Accessor

    var keyword: TokenSyntax {
      return subscriptKeyword
    }

    var accessors: Syntax? {
      return accessor
    }

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
        accessor: Syntax(accessorListForAPIDeclaration())
      )
    }

    internal func name() -> SubscriptDeclSyntax {
      return SyntaxFactory.makeSubscriptDecl(
        attributes: nil,
        modifiers: nil,
        subscriptKeyword: SyntaxFactory.makeToken(.subscriptKeyword, presence: .missing),
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

    // MARK: - APISyntax

    internal var shouldLookForChildren: Bool {
      return false
    }

    internal func createAPI(children: [APIElement]) -> [APIElement] {
      return [
        .subscript(
          SubscriptAPI(
            documentation: documentation,
            declaration: self
          )
        )
      ]
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
