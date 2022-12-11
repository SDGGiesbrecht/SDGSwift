/*
 InitializerDeclSyntax.swift

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

  extension InitializerDeclSyntax: AccessControlled, APIDeclaration, Attributed,
    Constrained, Generic, Hidable, OverloadableAPIDeclaration, OverridableDeclaration
  {

    // MARK: - Hidable

    internal var hidabilityIdentifier: TokenSyntax? {
      return parameters.parameterList.first?.firstName
    }

    // MARK: - APIDeclaration

    internal func name() -> InitializerDeclSyntax {
      return SyntaxFactory.makeInitializerDecl(
        attributes: nil,
        modifiers: nil,
        initKeyword: initKeyword,
        optionalMark: nil,
        genericParameterClause: nil,
        parameters: parameters.forName(labelBehaviour: .function),
        throwsOrRethrowsKeyword: nil,
        genericWhereClause: nil,
        body: nil
      )
    }

    internal func identifierList() -> Set<String> {
      return parameters.identifierList(labelBehaviour: .function)
    }

    // MARK: - OverloadableAPIDeclaration

    internal func overloadPattern() -> InitializerDeclSyntax {
      return SyntaxFactory.makeInitializerDecl(
        attributes: nil,
        modifiers: modifiers?.forOverloadPattern(),
        initKeyword: initKeyword,
        optionalMark: nil,
        genericParameterClause: nil,
        parameters: parameters.forOverloadPattern(labelBehaviour: .function),
        throwsOrRethrowsKeyword: nil,
        genericWhereClause: nil,
        body: nil
      )
    }
  }
#endif
