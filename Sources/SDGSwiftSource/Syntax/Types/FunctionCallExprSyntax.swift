/*
 FunctionCallExprSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLocalization

extension FunctionCallExprSyntax {

    internal static func normalizedLibraryDeclaration(name: String) -> (declaration: FunctionCallExprSyntax, name: String) {
        return normalizedManifest(entry: "library", name: name)
    }

    internal static func normalizedModuleDeclaration(name: String) -> (declaration: FunctionCallExprSyntax, name: String) {
        return normalizedManifest(entry: "target", name: name)
    }

    private static func normalizedManifest(entry: String, name: String) -> (declaration: FunctionCallExprSyntax, name: String) {
        let normalizedName = name.decomposedStringWithCanonicalMapping

        let declaration = SyntaxFactory.makeFunctionCallExpr(
            calledExpression: SyntaxFactory.makeMemberAccessExpr(
                base: SyntaxFactory.makeBlankUnknownExpr(),
                dot: SyntaxFactory.makeToken(.period),
                name: SyntaxFactory.makeToken(.identifier(entry)),
                declNameArguments: nil),
            leftParen: SyntaxFactory.makeToken(.leftParen),
            argumentList: SyntaxFactory.makeFunctionCallArgumentList([
                SyntaxFactory.makeFunctionCallArgument(
                    label: SyntaxFactory.makeToken(.identifier("name")),
                    colon: SyntaxFactory.makeToken(.colon, trailingTrivia: .spaces(1)),
                    expression: SyntaxFactory.makeStringLiteralExpr(normalizedName),
                    trailingComma: nil)
                ]),
            rightParen: SyntaxFactory.makeToken(.rightParen),
            trailingClosure: nil)

        return (declaration, normalizedName)
    }
}
