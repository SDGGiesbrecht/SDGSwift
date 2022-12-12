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

  extension OperatorDeclSyntax: Attributed {

    // MARK: - APIDeclaration

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
  }
#endif
