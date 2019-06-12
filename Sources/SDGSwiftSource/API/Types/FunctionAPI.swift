/*
 FunctionAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGCollections

import SwiftSyntax

/// A function or method.
public final class FunctionAPI : _APIElementBase, SortableAPIElement, UniquelyDeclaredOverloadableAPIElement, _UniquelyDeclaredSyntaxAPIElement {

    // MARK: - Initialization

    internal init(
        documentation: [SymbolDocumentation],
        alreadyNormalizedDeclaration declaration: FunctionDeclSyntax,
        constraints: GenericWhereClauseSyntax?,
        name: FunctionDeclSyntax,
        children: [APIElement]) {

        self.declaration = declaration
        self.name = name
        super.init(documentation: documentation)
        self.constraints = constraints
    }

    // MARK: - DeclaredAPIElement

    internal typealias Declaration = FunctionDeclSyntax

    // #documentation(SDGSwiftSource.UniquelyDeclaredAPIElement.declaration)
    /// The element’s declaration.
    public internal(set) var declaration: FunctionDeclSyntax
    // #documentation(SDGSwiftSource.UniquelyDeclaredAPIElement.name)
    /// The element’s name.
    public let name: FunctionDeclSyntax
}
