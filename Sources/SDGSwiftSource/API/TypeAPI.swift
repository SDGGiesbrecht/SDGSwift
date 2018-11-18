/*
 TypeAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic
import SDGCollections

public class TypeAPI : APIScope {

    // MARK: - Initialization

    internal init(documentation: DocumentationSyntax?, isOpen: Bool, keyword: TokenKind, name: TypeReferenceAPI, conformances: [ConformanceAPI], constraints: GenericWhereClauseSyntax?, children: [APIElement]) {
        typeName = name
        self.isOpen = isOpen
        self.keyword = keyword
        super.init(documentation: documentation, conformances: conformances, children: children)
        self.constraints = constraints?.normalized()
    }

    // MARK: - Properties

    private let isOpen: Bool
    public let keyword: TokenKind
    internal let typeName: TypeReferenceAPI

    // MARK: - APIElement

    public override var name: String {
        return typeName.declaration.source()
    }

    public override var declaration: Syntax {
        var modifierList: [DeclModifierSyntax] = []
        if isOpen {
            modifierList.append(SyntaxFactory.makeDeclModifier(
                name: SyntaxFactory.makeToken(.contextualKeyword("open"), trailingTrivia: .spaces(1)),
                detail: nil))
        }

        return SyntaxFactory.makeStructDecl(
            attributes: nil,
            modifiers: SyntaxFactory.makeModifierList(modifierList),
            structKeyword: SyntaxFactory.makeToken(keyword, trailingTrivia: .spaces(1)),
            identifier: typeName.nameDeclaration,
            genericParameterClause: typeName.genericParameterClauseDeclaration,
            inheritanceClause: nil,
            genericWhereClause: constraints,
            members: SyntaxFactory.makeBlankMemberDeclBlock())
    }

    public override var identifierList: Set<String> {
        return typeName.identifierList ∪ scopeIdentifierList
    }

    public override var summary: [String] {
        var result = name + " • " + declaration.source()
        appendCompilationConditions(to: &result)
        return [result] + scopeSummary
    }
}
