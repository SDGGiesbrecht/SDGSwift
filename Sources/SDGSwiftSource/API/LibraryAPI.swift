/*
 LibraryAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections

public class LibraryAPI : APIElement {

    // MARK: - Initialization

    internal init(name: String, manifest: Syntax) throws {
        _name = name.decomposedStringWithCanonicalMapping
        super.init()

        let declaration = manifest.smallestSubnode(containing: ".library(name: \u{22}\(name)\u{22}")?.parent
        documentation = declaration?.documentation
    }

    // MARK: - Properties

    private let _name: String

    // MARK: - APIElement

    public override var name: String {
        return _name
    }

    public override var declaration: FunctionCallExprSyntax {
        return SyntaxFactory.makeFunctionCallExpr(
            calledExpression: SyntaxFactory.makeMemberAccessExpr(
                base: SyntaxFactory.makeBlankExpr(),
                dot: SyntaxFactory.makeToken(.period),
                name: SyntaxFactory.makeToken(.identifier("library"))),
            leftParen: SyntaxFactory.makeToken(.leftParen),
            argumentList: SyntaxFactory.makeFunctionCallArgumentList([
                SyntaxFactory.makeFunctionCallArgument(
                    label: SyntaxFactory.makeToken(.identifier("name")),
                    colon: SyntaxFactory.makeToken(.colon, trailingTrivia: .spaces(1)),
                    expression: SyntaxFactory.makeStringLiteralExpr(name),
                    trailingComma: nil)
                ]),
            rightParen: SyntaxFactory.makeToken(.rightParen))
    }

    public override var identifierList: Set<String> {
        return children.map({ $0.identifierList }).reduce(into: Set<String>(), { $0 ∪= $1 })
    }

    public override var summary: [String] {
        return [name + " • " + declaration.source()]
    }
}
