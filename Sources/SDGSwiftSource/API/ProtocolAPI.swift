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

public class ProtocolAPI : MutableAPIScope, UniquelyDeclaredAPIElement {

    // MARK: - Initialization

    internal init(documentation: DocumentationSyntax?, declaration: ProtocolDeclSyntax, children: [APIElement]) {
        self.documentation = documentation
        let normalized = declaration.normalizedAPIDeclaration()
        _declaration = normalized.declaration
        name = normalized.declaration.name()
        _children = ProtocolAPI.normalize(children: children)
        constraints = constraints.merged(with: normalized.constraints)

        for method in methods {
            method.isProtocolRequirement = true
        }
    }

    // MARK: - Properties

    private let _declaration: ProtocolDeclSyntax

    // MARK: - APIElementProtocol

    public let documentation: DocumentationSyntax?
    public internal(set) var constraints: GenericWhereClauseSyntax?
    public internal(set) var compilationConditions: Syntax?

    public func identifierList() -> Set<String> {
        return Set([_declaration.identifier.text]) ∪ scopeIdentifierList()
    }

    public func summary() -> [String] {
        var result = name.source() + " • " + declaration.source()
        appendCompilationConditions(to: &result)
        return [result] + scopeSummary
    }

    // MARK: - MutableAPIScope

    internal var _children: [APIElement] = []

    // MARK: - DeclaredAPIElement

    public var declaration: ProtocolDeclSyntax {
        return _declaration.withGenericWhereClause(constraints)
    }

    public let name: ProtocolDeclSyntax
}
