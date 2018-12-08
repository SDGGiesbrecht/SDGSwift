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

public class ProtocolAPI : APIScope, UniquelyDeclaredAPIElement {

    // MARK: - Initialization

    internal init(documentation: DocumentationSyntax?, declaration: ProtocolDeclSyntax, conformances: [ConformanceAPI], children: [APIElementKind]) {
        self.documentation = documentation
        let normalized = declaration.normalizedAPIDeclaration()
        _declaration = normalized.declaration
        super.init(conformances: conformances, children: children)
        constraints = constraints.merged(with: normalized.constraints)

        for method in methods {
            method.isProtocolRequirement = true
        }
    }

    // MARK: - Properties

    private let _declaration: ProtocolDeclSyntax

    // MARK: - APIElement

    public var name: Syntax {
        return _declaration.name()
    }

    public override var identifierList: Set<String> {
        return Set([_declaration.identifier.text]) ∪ scopeIdentifierList
    }

    public override var summary: [String] {
        var result = name.source() + " • " + declaration.source()
        appendCompilationConditions(to: &result)
        return [result] + scopeSummary
    }

    // MARK: - APIElementProtocol

    public let documentation: DocumentationSyntax?

    // MARK: - DeclaredAPIElement

    public var declaration: ProtocolDeclSyntax {
        return _declaration.withGenericWhereClause(constraints)
    }
}
