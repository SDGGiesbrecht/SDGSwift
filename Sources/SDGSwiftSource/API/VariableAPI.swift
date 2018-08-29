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

        var tokens: [TokenSyntax] = []
        if let typePropertyKeyword = self.typePropertyKeyword {
            tokens.append(SyntaxFactory.makeToken(typePropertyKeyword, trailingTrivia: .spaces(1)))
        }
        tokens.append(contentsOf: [
            SyntaxFactory.makeVarKeyword(trailingTrivia: .spaces(1)),
            SyntaxFactory.makeToken(.identifier(_name))
        ])
        if let type = self.type {
            tokens.append(SyntaxFactory.makeToken(.colon, trailingTrivia: .spaces(1)))
            tokens.append(contentsOf: type.declaration.tokens())
        }

        tokens.append(contentsOf: [
            SyntaxFactory.makeToken(.leftBrace, leadingTrivia: .spaces(1), trailingTrivia: .spaces(1)),
            SyntaxFactory.makeToken(.identifier("get"))
            ])
        if isSettable {
            tokens.append(SyntaxFactory.makeToken(.identifier("set"), leadingTrivia: .spaces(1)))
        }
        tokens.append(SyntaxFactory.makeToken(.rightBrace, leadingTrivia: .spaces(1)))

        // #workaround(Swift 4.1.2, SwiftSyntax has no factory for this.)
        return SyntaxFactory.makeUnknownSyntax(tokens: tokens)
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
