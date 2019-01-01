/*
 UnknownDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

extension UnknownDeclSyntax {

    internal func unknownAPI() -> [APIElement] {
        var replacement: Syntax?
        if children.contains(where: { ($0 as? TokenSyntax)?.tokenKind == .funcKeyword }) {
            replacement = SyntaxFactory.makeFunctionDecl(
                attributes: children.first(AttributeListSyntax.self),
                modifiers: children.first(ModifierListSyntax.self),
                funcKeyword: children.first(.funcKeyword)!,
                identifier: children.firstIdentifier() ?? SyntaxFactory.makeToken(.identifier(""), presence: .missing), // @exempt(from: tests) Should not occur anyway.
                genericParameterClause: children.first(GenericParameterClauseSyntax.self),
                signature: children.first(FunctionSignatureSyntax.self) ?? SyntaxFactory.makeBlankFunctionSignature(), // @exempt(from: tests) Should not occur anyway.
                genericWhereClause: children.first(GenericWhereClauseSyntax.self),
                body: children.first(SwiftSyntax.CodeBlockSyntax.self))
        }
        if replacement ≠ nil,
            replacement?.documentation == nil,
            let documentation = self.documentation,
            let reparsed = try? SyntaxTreeParser.parse("/*\u{2A}\n" + documentation.text + "\n*/\n" + replacement!.source()) {
            replacement = reparsed
        }
        return replacement?.api() ?? [] // @exempt(from: tests) Should not occur anyway.
    }
}
