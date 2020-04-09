/*
 FunctionDeclSyntax.swift

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
  import SDGCollections

  import SwiftSyntax

  extension FunctionDeclSyntax: AccessControlled, APIDeclaration, APISyntax, Attributed,
    Constrained,
    Generic, Hidable, Member, OverloadableAPIDeclaration, OverridableDeclaration
  {

    // MARK: - APIDeclaration

    internal func normalizedAPIDeclaration() -> FunctionDeclSyntax {
      let (newGenericParemeterClause, newGenericWhereClause) = normalizedGenerics()
      return SyntaxFactory.makeFunctionDecl(
        attributes: attributes?.normalizedForAPIDeclaration(),
        modifiers: modifiers?.normalizedForAPIDeclaration(operatorFunction: identifier.isOperator),
        funcKeyword: funcKeyword.generallyNormalizedAndMissingInsteadOfNil(
          trailingTrivia: .spaces(1)
        ),
        identifier: identifier.generallyNormalizedAndMissingInsteadOfNil(),
        genericParameterClause: newGenericParemeterClause,
        signature: signature.normalizedForAPIDeclaration(
          labelBehaviour: identifier.isOperator ? .operator : .function
        ),
        genericWhereClause: newGenericWhereClause,
        body: nil
      )
    }

    internal func name() -> FunctionDeclSyntax {
      return SyntaxFactory.makeFunctionDecl(
        attributes: nil,
        modifiers: nil,
        funcKeyword: SyntaxFactory.makeToken(.funcKeyword, presence: .missing),
        identifier: identifier,
        genericParameterClause: nil,
        signature: signature.forName(labelBehaviour: identifier.isOperator ? .operator : .function),
        genericWhereClause: nil,
        body: nil
      )
    }

    internal func identifierList() -> Set<String> {
      return Set([identifier.text])
        ∪ signature.identifierList(labelBehaviour: identifier.isOperator ? .operator : .function)
    }

    // MARK: - APISyntax

    internal var shouldLookForChildren: Bool {
      return false
    }

    internal func createAPI(children: [APIElement]) -> [APIElement] {
      return [.function(FunctionAPI(documentation: documentation, declaration: self))]
    }

    // MARK: - Hidable

    internal var hidabilityIdentifier: TokenSyntax? {
      return identifier
    }

    // MARK: - OverloadableAPIDeclaration

    internal func overloadPattern() -> FunctionDeclSyntax {
      return SyntaxFactory.makeFunctionDecl(
        attributes: nil,
        modifiers: modifiers?.forOverloadPattern(),
        funcKeyword: funcKeyword,
        identifier: identifier,
        genericParameterClause: nil,
        signature: signature.forOverloadPattern(
          labelBehaviour: identifier.isOperator ? .operator : .function
        ),
        genericWhereClause: nil,
        body: nil
      )
    }
  }
#endif
