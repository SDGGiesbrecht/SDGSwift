/*
 InitializerAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGCollections

public final class InitializerAPI : APIElementBase, ConstrainedAPIElement {

    // MARK: - Initialization

    internal init(documentation: DocumentationSyntax?, alreadyNormalizedDeclaration declaration: InitializerDeclSyntax, name: InitializerDeclSyntax, children: [APIElement]) {
        self.declaration = declaration
        self.name = name
        super.init(documentation: documentation)
    }

    // MARK: - APIElement

    public func summary() -> [String] {
        var result = name.source() + " • " + declaration.source()
        appendCompilationConditions(to: &result)
        return [result]
    }

    // MARK: - APIElementProtocol

    public internal(set) var compilationConditions: Syntax?

    public func identifierList() -> Set<String> {
        return declaration.identifierList()
    }

    // MARK: - DeclaredAPIElement

    internal typealias Declaration = InitializerDeclSyntax

    public internal(set) var declaration: InitializerDeclSyntax
    public let name: InitializerDeclSyntax
}
