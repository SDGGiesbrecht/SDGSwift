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

    internal init<T>(documentation: DocumentationSyntax?, declaration: T, conformances: [ConformanceAPI], children: [APIElement]) where T : TypeDeclaration {
        let (normalizedDeclaration, normalizedConstraints) = declaration.normalizedAPIDeclaration()
        _declaration = normalizedDeclaration
        super.init(documentation: documentation, conformances: conformances, children: children)
        constraints = constraints.merged(with: normalizedConstraints)
    }

    // MARK: - Properties

    private let _declaration: TypeDeclaration

    // MARK: - APIElement

    public override var name: String {
        return _declaration.name().source()
    }

    public override var declaration: Syntax {
        return _declaration.withGenericWhereClause(constraints)
    }

    public override var identifierList: Set<String> {
        return _declaration.identifierList() ∪ scopeIdentifierList
    }

    public override var summary: [String] {
        var result = name + " • " + declaration.source()
        appendCompilationConditions(to: &result)
        return [result] + scopeSummary
    }
}
