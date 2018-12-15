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

public final class TypeAPI : _APIElementBase, MutableAPIScope, DeclaredAPIElement, APIElementProtocol {

    // MARK: - Initialization

    internal init<T>(documentation: DocumentationSyntax?, declaration: T, children: [APIElement]) where T : TypeDeclaration {
        let (normalizedDeclaration, normalizedConstraints) = declaration.normalizedAPIDeclaration()
        _declaration = normalizedDeclaration
        genericName = normalizedDeclaration.name()
        super.init(documentation: documentation, children: children)
        constraints.merge(with: normalizedConstraints)
    }

    // MARK: - Properties

    private let _declaration: TypeDeclaration

    // MARK: - APIElementProtocol

    public func identifierList() -> Set<String> {
        return _declaration.identifierList() ∪ scopeIdentifierList()
    }

    public func summary() -> [String] {
        var result = genericName.source() + " • " + genericDeclaration.source()
        appendCompilationConditions(to: &result)
        return [result] + scopeSummary()
    }

    // MARK: - DeclaredAPIElement

    public var genericDeclaration: Syntax {
        return _declaration.withGenericWhereClause(constraints)
    }

    public let genericName: Syntax
}
