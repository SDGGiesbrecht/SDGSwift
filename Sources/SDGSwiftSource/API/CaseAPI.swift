/*
 CaseAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

public class CaseAPI : UniquelyDeclaredAPIElement {

    // MARK: - Initialization

    internal init(documentation: DocumentationSyntax?, declaration: EnumCaseDeclSyntax) {
        self.documentation = documentation
        let _declaration = declaration.normalizedAPIDeclaration()
        self.declaration = _declaration
        name = _declaration.name()
    }

    // MARK: - APIElement

    public func summary() -> [String] {
        var result = name.source() + " • " + declaration.source()
        appendCompilationConditions(to: &result)
        return [result]
    }

    // MARK: - APIElementProtocol

    public let documentation: DocumentationSyntax?
    public internal(set) var constraints: GenericWhereClauseSyntax?
    public internal(set) var compilationConditions: Syntax?

    public func identifierList() -> Set<String> {
        return [declaration.elements.first!.identifier.text]
    }

    // MARK: - DeclaredAPIElement

    public let declaration: EnumCaseDeclSyntax
    public let name: EnumCaseDeclSyntax
}
