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

public class TypeAPI : APIScope, DeclaredAPIElement {

    // MARK: - Initialization

    internal init<T>(documentation: DocumentationSyntax?, declaration: T, conformances: [ConformanceAPI], children: [APIElementKind]) where T : TypeDeclaration {
        self.documentation = documentation
        let (normalizedDeclaration, normalizedConstraints) = declaration.normalizedAPIDeclaration()
        _declaration = normalizedDeclaration
        super.init(conformances: conformances, children: children)
        constraints = constraints.merged(with: normalizedConstraints)
    }

    // MARK: - Properties

    private let _declaration: TypeDeclaration

    // MARK: - APIElement

    public var name: Syntax {
        return _declaration.name()
    }

    public var declaration: Syntax {
        return _declaration.withGenericWhereClause(constraints)
    }

    public override var identifierList: Set<String> {
        return _declaration.identifierList() ∪ scopeIdentifierList
    }

    public override var summary: [String] {
        var result = name.source() + " • " + declaration.source()
        appendCompilationConditions(to: &result)
        return [result] + scopeSummary
    }

    // MARK: - APIElementProtocol

    public let documentation: DocumentationSyntax?
}
