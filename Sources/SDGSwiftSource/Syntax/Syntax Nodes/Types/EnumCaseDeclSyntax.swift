/*
 EnumCaseDeclSyntax.swift

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

  extension EnumCaseDeclSyntax {

    // MARK: - APIDeclaration

    internal func name() -> EnumCaseDeclSyntax {
      return SyntaxFactory.makeEnumCaseDecl(
        attributes: nil,
        modifiers: nil,
        caseKeyword: SyntaxFactory.makeToken(.caseKeyword, presence: .missing),
        elements: elements.forName()
      )
    }

    internal func identifierList() -> Set<String> {
      return Set(elements.lazy.map({ $0.identifier.text }))
    }
  }
#endif
