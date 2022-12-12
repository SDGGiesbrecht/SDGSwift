/*
 PrecedenceGroupDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SDGLogic

  import SwiftSyntax

  extension PrecedenceGroupDeclSyntax: Hidable {

    // MARK: - APIDeclaration

    internal func name() -> PrecedenceGroupDeclSyntax {
      return SyntaxFactory.makePrecedenceGroupDecl(
        attributes: nil,
        modifiers: nil,
        precedencegroupKeyword: SyntaxFactory.makeToken(
          .precedencegroupKeyword,
          presence: .missing
        ),
        identifier: identifier,
        leftBrace: SyntaxFactory.makeToken(.leftBrace, presence: .missing),
        groupAttributes: SyntaxFactory.makeBlankPrecedenceGroupAttributeList(),
        rightBrace: SyntaxFactory.makeToken(.rightBrace, presence: .missing)
      )
    }

    internal func identifierList() -> Set<String> {
      return [identifier.text]
    }

    // MARK: - Hidable

    internal var hidabilityIdentifier: TokenSyntax? {
      return identifier
    }
  }
#endif
