/*
 OperatorDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension OperatorDeclSyntax : APIDeclaration, Attributed {

    internal func operatorAPI() -> OperatorAPI? {
        if isUnavailable() {
            return nil
        }
        return OperatorAPI(documentation: documentation, declaration: self)
    }

    // MARK: - APIDeclaration

    internal func normalizedAPIDeclaration() -> OperatorDeclSyntax {
        return SyntaxFactory.makeOperatorDecl(
            attributes: attributes?.normalizedForAPIDeclaration(),
            modifiers: modifiers?.normalizedForAPIDeclaration(operatorFunction: false),
            operatorKeyword: operatorKeyword.generallyNormalizedAndMissingInsteadOfNil(leadingTrivia: .spaces(1)),
            identifier: identifier.generallyNormalizedAndMissingInsteadOfNil(),
            infixOperatorGroup: infixOperatorGroup?.normalizedForAPIDeclaration())
    }

    internal func name() -> OperatorDeclSyntax {
        return SyntaxFactory.makeOperatorDecl(
            attributes: nil,
            modifiers: nil,
            operatorKeyword: SyntaxFactory.makeToken(.operatorKeyword, presence: .missing),
            identifier: identifier,
            infixOperatorGroup: nil)
    }

    internal func identifierList() -> Set<String> {
        return [identifier.text]
    }
}
