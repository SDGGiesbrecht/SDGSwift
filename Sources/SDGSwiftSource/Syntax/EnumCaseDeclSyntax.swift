/*
 EnumCaseDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

extension EnumCaseDeclSyntax : AccessControlled, Attributed {

    internal func caseAPI() -> [CaseAPI] {
        var list: [CaseAPI] = []
        for element in elements where ¬element.identifier.text.hasPrefix("_") {
            list.append(CaseAPI(
                documentation: list.isEmpty ? documentation : nil, // The documentation only applies to the first.
                declaration: SyntaxFactory.makeEnumCaseDecl(
                    attributes: attributes,
                    modifiers: modifiers,
                    caseKeyword: caseKeyword,
                    elements: SyntaxFactory.makeEnumCaseElementList([element]))))
        }
        return list
    }

    internal func normalizedAPIDeclaration() -> EnumCaseDeclSyntax {
        return SyntaxFactory.makeEnumCaseDecl(
            attributes: attributes?.normalizedForAPIDeclaration(),
            modifiers: modifiers?.normalizedForAPIDeclaration(operatorFunction: false),
            caseKeyword: caseKeyword.generallyNormalized(trailingTrivia: .spaces(1)),
            elements: elements.normalizedForAPIDeclaration())
    }

    internal func name() -> EnumCaseDeclSyntax {
        return SyntaxFactory.makeEnumCaseDecl(
            attributes: nil,
            modifiers: nil,
            caseKeyword: SyntaxFactory.makeToken(.caseKeyword, presence: .missing),
            elements: elements.forName())
    }
}
