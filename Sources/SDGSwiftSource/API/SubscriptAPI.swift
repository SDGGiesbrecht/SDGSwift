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

public class SubscriptAPI : APIElement, DeclaredAPIElement {

    // MARK: - Initialization

    internal init(documentation: DocumentationSyntax?, declaration: SubscriptDeclSyntax) {
        self.documentation = documentation
        let (normalizedDeclaration, normalizedConstraints) = declaration.normalizedAPIDeclaration()
        _declaration = normalizedDeclaration
        super.init()
        constraints = constraints.merged(with: normalizedConstraints)
    }

    // MARK: - Properties

    private let _declaration: SubscriptDeclSyntax

    // MARK: - APIElement

    public var name: Syntax {
        return _declaration.name()
    }

    public var declaration: Syntax {
        return _declaration
    }

    public override var identifierList: Set<String> {
        return _declaration.identifierList()
    }

    public override var summary: [String] {
        var result = name.source() + " • " + declaration.source()
        appendCompilationConditions(to: &result)
        return [result]
    }

    // MARK: - APIElementProtocol

    public let documentation: DocumentationSyntax?
}
