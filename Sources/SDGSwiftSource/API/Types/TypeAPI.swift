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

public final class TypeAPI : _APIElementBase, APIElementProtocol, DeclaredAPIElement, OverloadableAPIElement, SortableAPIElement {

    // MARK: - Initialization

    internal init<T>(documentation: DocumentationSyntax?, declaration: T, children: [APIElement]) where T : TypeDeclaration {
        let (normalizedDeclaration, normalizedConstraints) = declaration.normalizedAPIDeclaration()
        self.declaration = normalizedDeclaration
        genericName = normalizedDeclaration.name()
        super.init(documentation: documentation, children: children)
        constraints.merge(with: normalizedConstraints)
    }

    // MARK: - Properties

    private let declaration: TypeDeclaration

    // MARK: - APIElementProtocol

    public func shallowIdentifierList() -> Set<String> {
        return declaration.identifierList()
    }

    public func summary() -> [String] {
        var result = genericName.source() + " • " + genericDeclaration.source()
        appendCompilationConditions(to: &result)
        return [result] + scopeSummary()
    }

    // MARK: - DeclaredAPIElement

    public var genericDeclaration: Syntax {
        return declaration.withGenericWhereClause(constraints)
    }

    public let genericName: Syntax

    // MARK: - OverloadableAPIElement

    internal func genericOverloadPattern() -> Syntax {
        return declaration
    }
}
