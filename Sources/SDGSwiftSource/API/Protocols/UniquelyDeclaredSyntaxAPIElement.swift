/*
 UniquelyDeclaredSyntaxAPIElement.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

internal protocol UniquelyDeclaredSyntaxAPIElement : UniquelyDeclaredAPIElement where Declaration : APIDeclaration, Name == Declaration.Name {

}

extension UniquelyDeclaredSyntaxAPIElement {

    internal init(documentation: DocumentationSyntax?, declaration: Declaration, children: [APIElement] = []) {
        let normalized = declaration.normalizedAPIDeclaration()
        self.init(documentation: documentation, alreadyNormalizedDeclaration: normalized, name: normalized.name(), children: children)
    }

    // MARK: - UniquelyDeclaredAPIElement

    public func shallowIdentifierList() -> Set<String> {
        return declaration.identifierList()
    }
}
