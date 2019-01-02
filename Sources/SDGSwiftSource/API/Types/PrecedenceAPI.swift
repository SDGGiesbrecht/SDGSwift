/*
 PrecedenceAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public final class PrecedenceAPI : _APIElementBase, APIElementProtocol, DeclaredAPIElement, NonOverloadableAPIElement, SortableAPIElement, UniquelyDeclaredAPIElement, UniquelyDeclaredSyntaxAPIElement {

    // MARK: - DeclaredAPIElement

    public internal(set) var declaration: PrecedenceGroupDeclSyntax
    public let name: PrecedenceGroupDeclSyntax

    // MARK: - UniquelyDeclaredAPIElement

    internal init(documentation: DocumentationSyntax?, alreadyNormalizedDeclaration declaration: PrecedenceGroupDeclSyntax, constraints: GenericWhereClauseSyntax?, name: PrecedenceGroupDeclSyntax, children: [APIElement]) {
        self.declaration = declaration
        self.name = name
        super.init(documentation: documentation)
        self.constraints = constraints
    }
}
