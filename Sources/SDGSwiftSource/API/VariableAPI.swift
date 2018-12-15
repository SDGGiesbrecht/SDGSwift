/*
 VariableAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public class VariableAPI : APIElement, UniquelyDeclaredAPIElement {

    // MARK: - Initialization

    internal init(documentation: DocumentationSyntax?, declaration: VariableDeclSyntax) {
        self.documentation = documentation
        let declaration = declaration.normalizedAPIDeclaration()
        self.declaration = declaration
        self.name = declaration.name()
        super.init()
    }

    // MARK: - APIElement

    public override var summary: [String] {
        var result = name.source() + " • " + declaration.source()
        appendCompilationConditions(to: &result)
        return [result]
    }

    // MARK: - APIElementProtocol

    public let documentation: DocumentationSyntax?

    public func identifierList() -> Set<String> {
        return [name.source()]
    }

    // MARK: - DeclaredAPIElement

    public let declaration: VariableDeclSyntax
    public internal(set) var constraints: GenericWhereClauseSyntax?
    public internal(set) var compilationConditions: Syntax?

    public let name: VariableDeclSyntax
}
