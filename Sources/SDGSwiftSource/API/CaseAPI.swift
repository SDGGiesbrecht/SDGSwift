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

public class CaseAPI : APIElement {

    // MARK: - Initialization

    internal init(documentation: DocumentationSyntax?, declaration: EnumCaseDeclSyntax) {
        _declaration = declaration.normalizedAPIDeclaration()
        super.init(documentation: documentation)
    }

    // MARK: - Properties

    private let _declaration: EnumCaseDeclSyntax

    // MARK: - APIElement

    private func declarationName() -> EnumCaseDeclSyntax {
        return SyntaxFactory.makeEnumCaseDecl(
            attributes: nil,
            modifiers: nil,
            caseKeyword: SyntaxFactory.makeToken(.caseKeyword, presence: .missing),
            elements: _declaration.elements.forName())
    }
    public override var name: String {
        return declarationName().source()
    }

    public override var declaration: Syntax {
        return _declaration
    }

    public override var identifierList: Set<String> {
        return [name]
    }

    public override var summary: [String] {
        var result = name + " • " + declaration.source()
        appendCompilationConditions(to: &result)
        return [result]
    }
}
