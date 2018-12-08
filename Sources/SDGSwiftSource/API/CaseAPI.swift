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

public class CaseAPI : APIElement, UniquelyDeclaredAPIElement {

    // MARK: - Initialization

    internal init(documentation: DocumentationSyntax?, declaration: EnumCaseDeclSyntax) {
        self.documentation = documentation
        self.declaration = declaration.normalizedAPIDeclaration()
        super.init()
    }

    // MARK: - APIElement

    public var name: Syntax {
        return declaration.name()
    }

    public override var identifierList: Set<String> {
        return [declaration.elements.first!.identifier.text]
    }

    public override var summary: [String] {
        var result = name.source() + " • " + declaration.source()
        appendCompilationConditions(to: &result)
        return [result]
    }

    // MARK: - APIElementProtocol

    public let documentation: DocumentationSyntax?

    // MARK: - DeclaredAPIElement

    public let declaration: EnumCaseDeclSyntax
}
