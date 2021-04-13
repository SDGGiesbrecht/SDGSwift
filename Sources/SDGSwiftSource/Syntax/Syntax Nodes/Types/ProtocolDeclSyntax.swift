/*
 ProtocolDeclSyntax.swift

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

  extension ProtocolDeclSyntax: AccessControlled, APIDeclaration, APISyntax, Attributed,
    Constrained,
    Hidable, Inheritor
  {

    // MARK: - Hidable

    internal var hidabilityIdentifier: TokenSyntax? {
      return identifier
    }

    // MARK: - APIDeclaration

    internal func normalizedAPIDeclaration() -> ProtocolDeclSyntax {
      return SyntaxFactory.makeProtocolDecl(
        attributes: attributes?.normalizedForAPIDeclaration(),
        modifiers: modifiers?.normalizedForAPIDeclaration(operatorFunction: false),
        protocolKeyword: protocolKeyword.generallyNormalizedAndMissingInsteadOfNil(
          trailingTrivia: .spaces(1)
        ),
        identifier: identifier.generallyNormalizedAndMissingInsteadOfNil(),
        inheritanceClause: nil,
        genericWhereClause: genericWhereClause?.normalized(),
        members: SyntaxFactory.makeBlankMemberDeclBlock()
      )
    }

    internal func name() -> ProtocolDeclSyntax {
      return SyntaxFactory.makeProtocolDecl(
        attributes: nil,
        modifiers: nil,
        protocolKeyword: SyntaxFactory.makeToken(.protocolKeyword, presence: .missing),
        identifier: identifier,
        inheritanceClause: nil,
        genericWhereClause: nil,
        members: SyntaxFactory.makeBlankMemberDeclBlock()
      )
    }

    internal func identifierList() -> Set<String> {
      return [identifier.text]
    }

    // MARK: - APISyntax

    internal var shouldLookForChildren: Bool {
      return true
    }

    internal func createAPI(children: [APIElement]) -> [APIElement] {
      return [
        .protocol(
          ProtocolAPI(
            documentation: documentation,
            declaration: self,
            children: children
          )
        )
      ]
    }
  }
#endif
