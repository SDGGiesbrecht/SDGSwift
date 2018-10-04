/*
 VariableAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public class VariableAPI : APIElement {

    // MARK: - Initialization

    internal init(documentation: DocumentationSyntax?, typePropertyKeyword: TokenKind?, name: String, type: TypeReferenceAPI?, isSettable: Bool) {
        self.typePropertyKeyword = typePropertyKeyword
        _name = name.decomposedStringWithCanonicalMapping
        self.type = type
        self.isSettable = isSettable
        super.init(documentation: documentation)
    }

    // MARK: - Properties

    public let typePropertyKeyword: TokenKind?
    private let _name: String
    public let type: TypeReferenceAPI?
    private let isSettable: Bool

    // MARK: - APIElement

    public override var name: String {
        return _name
    }

    public override var declaration: Syntax {

        var modifiers: ModifierListSyntax?
        if let typePropertyKeyword = self.typePropertyKeyword {
            modifiers = SyntaxFactory.makeModifierList([SyntaxFactory.makeDeclModifier(
                name: SyntaxFactory.makeToken(typePropertyKeyword, trailingTrivia: .spaces(1)),
                detail: nil)])
        }

        var typeAnnotation: TypeAnnotationSyntax?
        if let type = self.type {
            typeAnnotation = SyntaxFactory.makeTypeAnnotation(
                colon: SyntaxFactory.makeToken(.colon, trailingTrivia: .spaces(1)),
                type: type.declaration)
        }

        return SyntaxFactory.makeVariableDecl(
            attributes: nil,
            modifiers: modifiers,
            letOrVarKeyword: SyntaxFactory.makeVarKeyword(trailingTrivia: .spaces(1)),
            bindings: SyntaxFactory.makePatternBindingList([
                SyntaxFactory.makePatternBinding(
                    pattern: SyntaxFactory.makeIdentifierPattern(identifier: SyntaxFactory.makeToken(.identifier(_name))),
                    typeAnnotation: typeAnnotation,
                    initializer: nil,
                    accessor: SyntaxFactory.makeProtocolStyleAccessorBlock(settable: isSettable),
                    trailingComma: nil)
                ]))
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
