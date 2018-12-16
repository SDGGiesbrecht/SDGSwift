/*
 VariableAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public final class VariableAPI : _APIElementBase, SortableAPIElement, UniquelyDeclaredOverloadableAPIElement, UniquelyDeclaredSyntaxAPIElement {

    // MARK: - Initialization

    internal init(documentation: DocumentationSyntax?, alreadyNormalizedDeclaration declaration: VariableDeclSyntax, name: VariableDeclSyntax, children: [APIElement]) {
        self.declaration = declaration
        self.name = name
        super.init(documentation: documentation)
    }

    // MARK: - DeclaredAPIElement

    public let declaration: VariableDeclSyntax
    public let name: VariableDeclSyntax
}
