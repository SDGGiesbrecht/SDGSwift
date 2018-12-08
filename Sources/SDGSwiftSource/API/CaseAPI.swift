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

public class CaseAPI : APIElement, DeclaredAPIElement {

    // MARK: - Initialization

    internal init(documentation: DocumentationSyntax?, declaration: EnumCaseDeclSyntax) {
        self.documentation = documentation
        _declaration = declaration.normalizedAPIDeclaration()
        super.init()
    }

    // MARK: - Properties

    private let _declaration: EnumCaseDeclSyntax

    // MARK: - APIElement

    public var name: Syntax {
        return _declaration.name()
    }

    public var declaration: Syntax {
        return _declaration
    }

    public override var identifierList: Set<String> {
        return [_declaration.elements.first!.identifier.text]
    }

    public override var summary: [String] {
        var result = name.source() + " • " + declaration.source()
        appendCompilationConditions(to: &result)
        return [result]
    }

    // MARK: - APIElementProtocol

    public let documentation: DocumentationSyntax?
}
