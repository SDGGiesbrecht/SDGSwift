/*
 ProtocolDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

extension ProtocolDeclSyntax : AccessControlled, Attributed {

    internal var protocolAPI: ProtocolAPI? {
        if ¬isPublic ∨ isUnavailable() {
            return nil
        }
        if identifier.text.hasPrefix("_") {
            return nil
        }
        return ProtocolAPI(
            documentation: documentation,
            declaration: self,
            conformances: inheritanceClause?.conformances ?? [],
            children: apiChildren())
    }

    internal func normalizedAPIDeclaration() -> (declaration: ProtocolDeclSyntax, constraints: GenericWhereClauseSyntax?) {
        return (SyntaxFactory.makeProtocolDecl(
            attributes: attributes?.normalizedForAPIDeclaration(),
            modifiers: modifiers?.normalizedForAPIDeclaration(operatorFunction: false),
            protocolKeyword: protocolKeyword.generallyNormalizedAndMissingInsteadOfNil(trailingTrivia: .spaces(1)),
            identifier: identifier.generallyNormalizedAndMissingInsteadOfNil(),
            inheritanceClause: nil,
            genericWhereClause: nil,
            members: SyntaxFactory.makeBlankMemberDeclBlock()),
                genericWhereClause?.normalized())
    }
}
