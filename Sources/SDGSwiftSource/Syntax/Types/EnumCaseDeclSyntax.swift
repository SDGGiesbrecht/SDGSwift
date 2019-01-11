/*
 EnumCaseDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

extension EnumCaseDeclSyntax : APIDeclaration, APISyntax, Attributed {

    // MARK: - APIDeclaration

    internal func normalizedAPIDeclaration() -> EnumCaseDeclSyntax {
        return SyntaxFactory.makeEnumCaseDecl(
            attributes: attributes?.normalizedForAPIDeclaration(),
            modifiers: modifiers?.normalizedForAPIDeclaration(operatorFunction: false),
            caseKeyword: caseKeyword.generallyNormalizedAndMissingInsteadOfNil(trailingTrivia: .spaces(1)),
            elements: elements.normalizedForAPIDeclaration())
    }

    internal func name() -> EnumCaseDeclSyntax {
        return SyntaxFactory.makeEnumCaseDecl(
            attributes: nil,
            modifiers: nil,
            caseKeyword: SyntaxFactory.makeToken(.caseKeyword, presence: .missing),
            elements: elements.forName())
    }

    internal func identifierList() -> Set<String> {
        return Set(elements.lazy.map({ $0.identifier.text }))
    }

    // MARK: - APISyntax

    internal var isPublic: Bool {
        return true
    }

    internal var isHidden: Bool {
        return elements.allSatisfy({ $0.isHidden })
    }

    internal func selfParsedAPI() -> [APIElement] {
        var list: [APIElement] = []
        for element in elements where ¬element.isHidden {
            list.append(.case(CaseAPI(
                documentation: list.isEmpty ? documentation : nil, // The documentation only applies to the first.
                declaration: SyntaxFactory.makeEnumCaseDecl(
                    attributes: attributes,
                    modifiers: modifiers,
                    caseKeyword: caseKeyword,
                    elements: SyntaxFactory.makeEnumCaseElementList([element])))))
        }
        return list
    }
}
