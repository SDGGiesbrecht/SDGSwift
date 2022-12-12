/*
 ProtocolDeclSyntax.swift

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

  extension ProtocolDeclSyntax: Attributed,
    Constrained,
    Hidable, Inheritor
  {

    // MARK: - Hidable

    internal var hidabilityIdentifier: TokenSyntax? {
      return identifier
    }

    // MARK: - APIDeclaration

    internal func name() -> ProtocolDeclSyntax {
      return SyntaxFactory.makeProtocolDecl(
        attributes: nil,
        modifiers: nil,
        protocolKeyword: SyntaxFactory.makeToken(.protocolKeyword, presence: .missing),
        identifier: identifier,
        primaryAssociatedTypeClause: nil,  // #workaround(Not supported yet.)
        inheritanceClause: nil,
        genericWhereClause: nil,
        members: SyntaxFactory.makeBlankMemberDeclBlock()
      )
    }

    internal func identifierList() -> Set<String> {
      return [identifier.text]
    }
  }
#endif
