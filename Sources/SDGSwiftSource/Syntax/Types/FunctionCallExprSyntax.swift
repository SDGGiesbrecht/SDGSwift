/*
 FunctionCallExprSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLocalization

extension FunctionCallExprSyntax {

    internal static func normalizedPackageDeclaration(name: String) -> FunctionCallExprSyntax {
        return normalizedManifest(
            calledExpression:  SyntaxFactory.makeIdentifierExpr(
                identifier: SyntaxFactory.makeToken(.identifier("Package")),
                declNameArguments: nil),
            name: name)
    }

    internal static func normalizedLibraryDeclaration(name: String) -> FunctionCallExprSyntax {
        return normalizedManifest(memberEntry: "library", name: name)
    }

    internal static func normalizedModuleDeclaration(name: String) -> FunctionCallExprSyntax {
        return normalizedManifest(memberEntry: "target", name: name)
    }

    private static func normalizedManifest(memberEntry entry: String, name: String) -> FunctionCallExprSyntax {
        return normalizedManifest(
            calledExpression: SyntaxFactory.makeMemberAccessExpr(
                base: SyntaxFactory.makeBlankUnknownExpr(),
                dot: SyntaxFactory.makeToken(.period),
                name: SyntaxFactory.makeToken(.identifier(entry)),
                declNameArguments: nil),
            name: name)
    }

    private static func normalizedManifest(calledExpression: ExprSyntax, name: String) -> FunctionCallExprSyntax {
        return SyntaxFactory.makeFunctionCallExpr(
            calledExpression: calledExpression,
            leftParen: SyntaxFactory.makeToken(.leftParen),
            argumentList: SyntaxFactory.makeFunctionCallArgumentList([
                SyntaxFactory.makeFunctionCallArgument(
                    label: SyntaxFactory.makeToken(.identifier("name")),
                    colon: SyntaxFactory.makeToken(.colon, trailingTrivia: .spaces(1)),
                    expression: SyntaxFactory.makeStringLiteralExpr(name.decomposedStringWithCanonicalMapping),
                    trailingComma: nil)
                ]),
            rightParen: SyntaxFactory.makeToken(.rightParen),
            trailingClosure: nil)
    }

    internal func manifestEntryName() -> TokenSyntax {
        guard let literal = argumentList.first?.expression as? StringLiteralExprSyntax else {
            unreachable()
        }
        return SyntaxFactory.makeStringSegment(String(literal.stringLiteral.text.dropFirst().dropLast()))
    }
}
