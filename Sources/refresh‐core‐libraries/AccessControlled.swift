/*
 AccessControlled.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGSwiftSource

internal protocol AccessControlled : Syntax {
    var modifiers: ModifierListSyntax? { get }
    func withModifiers(_ modifiers: ModifierListSyntax?) -> Self
}

extension AccessControlled {
    func madePublic() -> Self {
        var modifiers = self.modifiers?.map({ $0 }) ?? []
        if ¬modifiers.contains(where: { $0.name.text == "open" }) {
            modifiers.prepend(SyntaxFactory.makeDeclModifier(
                name: SyntaxFactory.makeToken(.publicKeyword, trailingTrivia: .spaces(1)),
                detail: nil))
        }
        return withModifiers(SyntaxFactory.makeModifierList(modifiers))
    }
}

extension ProtocolDeclSyntax : AccessControlled {}

extension InitializerDeclSyntax : AccessControlled {}
extension VariableDeclSyntax : AccessControlled {}
extension SubscriptDeclSyntax : AccessControlled {}
extension FunctionDeclSyntax : AccessControlled {}
