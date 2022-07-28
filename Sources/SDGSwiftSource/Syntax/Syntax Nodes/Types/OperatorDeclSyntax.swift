/*
 OperatorDeclSyntax.swift

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

  extension OperatorDeclSyntax: APIDeclaration, APISyntax, Attributed {

    // MARK: - APIDeclaration

    internal func normalizedAPIDeclaration() -> OperatorDeclSyntax {
      return SyntaxFactory.makeOperatorDecl(
        attributes: attributes?.normalizedForAPIDeclaration(),
        modifiers: modifiers?.normalizedForAPIDeclaration(operatorFunction: false),
        operatorKeyword: operatorKeyword.generallyNormalizedAndMissingInsteadOfNil(
          trailingTrivia: .spaces(1)
        ),
        identifier: identifier.generallyNormalizedAndMissingInsteadOfNil(),
        operatorPrecedenceAndTypes: nil
      )
    }

    internal func name() -> OperatorDeclSyntax {
      return SyntaxFactory.makeOperatorDecl(
        attributes: nil,
        modifiers: nil,
        operatorKeyword: SyntaxFactory.makeToken(.operatorKeyword, presence: .missing),
        identifier: identifier,
        operatorPrecedenceAndTypes: nil
      )
    }

    internal func identifierList() -> Set<String> {
      return [identifier.text]
    }

    // MARK: - APISyntax

    internal func isPublic() -> Bool {
      return true
    }

    internal var isHidden: Bool {
      return false
    }

    internal var shouldLookForChildren: Bool {
      return false
    }

    internal func createAPI(children: [APIElement]) -> [APIElement] {
      return [.operator(OperatorAPI(documentation: documentation, declaration: self))]
    }
  }
#endif
