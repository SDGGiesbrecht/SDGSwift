/*
 UnknownDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension UnknownDeclSyntax {

    internal func unknownAPI() -> [APIElement] {
        var replacement: Syntax?
        if children.contains(where: { ($0 as? TokenSyntax)?.tokenKind == .funcKeyword }) {
            replacement = SyntaxFactory.makeFunctionDecl(
                attributes: children.first(AttributeListSyntax.self),
                modifiers: children.first(ModifierListSyntax.self),
                funcKeyword: children.first(.funcKeyword)!,
                identifier: children.firstIdentifier() ?? SyntaxFactory.makeToken(.identifier(""), presence: .missing),
                genericParameterClause: children.first(GenericParameterClauseSyntax.self),
                signature: children.first(FunctionSignatureSyntax.self) ?? SyntaxFactory.makeBlankFunctionSignature(),
                genericWhereClause: children.first(GenericWhereClauseSyntax.self),
                body: SyntaxFactory.makeBlankCodeBlock())
        }
        return replacement?.api() ?? []
    }
}
