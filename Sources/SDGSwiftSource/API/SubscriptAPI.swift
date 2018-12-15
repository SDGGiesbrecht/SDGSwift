/*
 SubscriptAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGCollections

public class SubscriptAPI : APIElement, UniquelyDeclaredAPIElement {

    // MARK: - Initialization

    internal init(documentation: DocumentationSyntax?, declaration: SubscriptDeclSyntax) {
        self.documentation = documentation
        let (normalizedDeclaration, normalizedConstraints) = declaration.normalizedAPIDeclaration()
        _declaration = normalizedDeclaration
        name = normalizedDeclaration.name()
        super.init()
        constraints = constraints.merged(with: normalizedConstraints)
    }

    // MARK: - Properties

    private let _declaration: SubscriptDeclSyntax

    // MARK: - APIElement

    public override var summary: [String] {
        var result = name.source() + " • " + declaration.source()
        appendCompilationConditions(to: &result)
        return [result]
    }

    // MARK: - APIElementProtocol

    public let documentation: DocumentationSyntax?
    public internal(set) var constraints: GenericWhereClauseSyntax?
    public internal(set) var compilationConditions: Syntax?

    public func identifierList() -> Set<String> {
        return _declaration.identifierList()
    }

    // MARK: - DeclaredAPIElement

    public var declaration: SubscriptDeclSyntax {
        return _declaration.withGenericWhereClause(constraints)
    }

    public let name: SubscriptDeclSyntax
}
