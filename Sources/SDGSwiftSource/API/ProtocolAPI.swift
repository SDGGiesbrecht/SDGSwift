/*
 ProtocolAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections

public class ProtocolAPI : APIScope {

    // MARK: - Initialization

    internal init(documentation: DocumentationSyntax?, name: String, conformances: [ConformanceAPI], constraints: GenericWhereClauseSyntax?, children: [APIElement]) {
        _name = name.decomposedStringWithCanonicalMapping
        super.init(documentation: documentation, conformances: conformances, children: children)
        self.constraints = constraints?.normalized()

        for method in methods {
            method.isProtocolRequirement = true // @exempt(from: tests) False coverage result in Xcode 9.4.1.
        }
    }

    // MARK: - Properties

    private let _name: String

    // MARK: - APIElement

    public override var name: String {
        return _name.description
    }

    public override var declaration: Syntax {
        return SyntaxFactory.makeProtocolDecl(
            attributes: nil,
            modifiers: nil,
            protocolKeyword: SyntaxFactory.makeToken(.protocolKeyword, trailingTrivia: .spaces(1)),
            identifier: SyntaxFactory.makeToken(.identifier(name)),
            inheritanceClause: nil,
            genericWhereClause: constraints,
            members: SyntaxFactory.makeBlankMemberDeclBlock())
    }

    public override var identifierList: Set<String> {
        return Set([_name]) ∪ scopeIdentifierList
    }

    public override var summary: [String] {
        var result = name + " • " + declaration.source()
        appendCompilationConditions(to: &result)
        return [result] + scopeSummary
    }
}
