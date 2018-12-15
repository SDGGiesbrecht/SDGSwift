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

public struct ProtocolAPI : MutableAPIScope, UniquelyDeclaredSyntaxAPIElement {

    // MARK: - Initialization

    internal init(documentation: DocumentationSyntax?, alreadyNormalizedDeclaration declaration: ProtocolDeclSyntax, name: ProtocolDeclSyntax, children: [APIElement]) {
        self.documentation = documentation
        self.declaration = declaration
        self.name = name
        _children = ProtocolAPI.normalize(children: children).map { child in
            if case .function(var function) = child {
                function.isProtocolRequirement = true
                return .function(function)
            } else {
                return child
            }
        }
    }

    // MARK: - APIElementProtocol

    public let documentation: DocumentationSyntax?
    public internal(set) var constraints: GenericWhereClauseSyntax?
    public internal(set) var compilationConditions: Syntax?

    public func identifierList() -> Set<String> {
        return Set([declaration.identifier.text]) ∪ scopeIdentifierList()
    }

    public func summary() -> [String] {
        var result = name.source() + " • " + declaration.source()
        appendCompilationConditions(to: &result)
        return [result] + scopeSummary()
    }

    // MARK: - MutableAPIScope

    internal var _children: [APIElement] = []

    // MARK: - DeclaredAPIElement

    public internal(set) var declaration: ProtocolDeclSyntax
    public let name: ProtocolDeclSyntax
}
