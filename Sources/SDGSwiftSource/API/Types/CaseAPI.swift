/*
 CaseAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

/// An enumeration case.
public final class CaseAPI : _APIElementBase, _NonOverloadableAPIElement, SortableAPIElement, _UniquelyDeclaredSyntaxAPIElement {

    // MARK: - DeclaredAPIElement

    // #documentation(SDGSwiftSource.UniquelyDeclaredAPIElement.declaration)
    /// The element’s declaration.
    public internal(set) var declaration: EnumCaseDeclSyntax
    // #documentation(SDGSwiftSource.UniquelyDeclaredAPIElement.name)
    /// The element’s name.
    public let name: EnumCaseDeclSyntax

    // MARK: - UniquelyDeclaredAPIElement

    internal init(documentation: DocumentationSyntax?, alreadyNormalizedDeclaration declaration: EnumCaseDeclSyntax, constraints: GenericWhereClauseSyntax?, name: EnumCaseDeclSyntax, children: [APIElement]) {
        self.declaration = declaration
        self.name = name
        super.init(documentation: documentation)
        self.constraints = constraints
    }
}
