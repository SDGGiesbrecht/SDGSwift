/*
 AccessControlled.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.2.1, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(WASI) || os(Android))
  import SDGLogic

  import SwiftSyntax

  import SDGSwiftSource

  internal protocol AccessControlled: SyntaxProtocol {
    var modifiers: ModifierListSyntax? { get }
    func withModifiers(_ modifiers: ModifierListSyntax?) -> Self
  }

  extension AccessControlled {
    func madePublic(_ inProtocol: Bool = false) -> Self {
      if inProtocol {
        return self
      }

      var modifiers = self.modifiers?.map({ $0 }) ?? []
      if ¬modifiers.contains(where: { $0.name.text == "open" }) {
        modifiers.prepend(
          SyntaxFactory.makeDeclModifier(
            name: SyntaxFactory.makeToken(.publicKeyword, trailingTrivia: .spaces(1)),
            detailLeftParen: nil,
            detail: nil,
            detailRightParen: nil
          )
        )
      }
      return withModifiers(SyntaxFactory.makeModifierList(modifiers))
    }
  }

  extension ProtocolDeclSyntax: AccessControlled {}

  extension InitializerDeclSyntax: AccessControlled {}
  extension VariableDeclSyntax: AccessControlled {}
  extension SubscriptDeclSyntax: AccessControlled {}
  extension FunctionDeclSyntax: AccessControlled {}
#endif
