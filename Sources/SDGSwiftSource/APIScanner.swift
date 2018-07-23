/*
 APIScanner.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

import SDGSwiftSyntaxShims

/// A scanner which reduces a syntax tree down to its API elements.
public class APIScanner : SyntaxRewriter {

    // MARK: - Scanning

    public override func visit(_ node: UnknownDeclSyntax) -> DeclSyntax {
        if node.children.contains(where: { ($0 as? TokenSyntax)?.tokenKind == .classKeyword }) {
            // Class declaration.

            if node.children.contains(where: { ($0 as? TokenSyntax)?.tokenKind == .publicKeyword }) {
                // API.

                return node
            }
        }
        return SyntaxFactory.makeBlankDecl()
    }

    public override func visit(_ node: UnknownStmtSyntax) -> StmtSyntax {
        return SyntaxFactory.makeBlankStmt()
    }
}
