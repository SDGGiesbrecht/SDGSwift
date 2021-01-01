/*
 PrecedenceGroupDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.3.1, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(WASI) || os(tvOS) || os(iOS) || os(Android) || os(watchOS))
  import SDGLogic

  import SwiftSyntax

  extension PrecedenceGroupDeclSyntax: APIDeclaration, APISyntax, Attributed, Hidable {

    // MARK: - APIDeclaration

    internal func normalizedAPIDeclaration() -> PrecedenceGroupDeclSyntax {

      let normalizedAttributes = groupAttributes.normalizedForAPIDeclaration()

      let rightBraceTrivia: Trivia
      if normalizedAttributes.isEmpty {
        rightBraceTrivia = []
      } else {
        rightBraceTrivia = .spaces(1)
      }

      return SyntaxFactory.makePrecedenceGroupDecl(
        attributes: attributes?.normalizedForAPIDeclaration(),
        modifiers: modifiers?.normalizedForAPIDeclaration(operatorFunction: false),
        precedencegroupKeyword: precedencegroupKeyword.generallyNormalizedAndMissingInsteadOfNil(
          trailingTrivia: .spaces(1)
        ),
        identifier: identifier.generallyNormalizedAndMissingInsteadOfNil(),
        leftBrace: leftBrace.generallyNormalizedAndMissingInsteadOfNil(leadingTrivia: .spaces(1)),
        groupAttributes: normalizedAttributes,
        rightBrace: rightBrace.generallyNormalizedAndMissingInsteadOfNil(
          leadingTrivia: rightBraceTrivia
        )
      )
    }

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

    // MARK: - APISyntax

    internal func isPublic() -> Bool {
      return true
    }

    internal var shouldLookForChildren: Bool {
      return false
    }

    internal func createAPI(children: [APIElement]) -> [APIElement] {
      return [.precedence(PrecedenceAPI(documentation: documentation, declaration: self))]
    }

    // MARK: - Hidable

    internal var hidabilityIdentifier: TokenSyntax? {
      return identifier
    }
  }
#endif
