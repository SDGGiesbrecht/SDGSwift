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

public final class CaseAPI : _APIElementBase, NonOverloadableAPIElement, SortableAPIElement, UniquelyDeclaredSyntaxAPIElement {

    // MARK: - DeclaredAPIElement

    public internal(set) var declaration: EnumCaseDeclSyntax
    public let name: EnumCaseDeclSyntax

    // MARK: - UniquelyDeclaredAPIElement

    internal init(documentation: DocumentationSyntax?, alreadyNormalizedDeclaration declaration: EnumCaseDeclSyntax, name: EnumCaseDeclSyntax, children: [APIElement]) {
        self.declaration = declaration
        self.name = name
        super.init(documentation: documentation)
    }
}
