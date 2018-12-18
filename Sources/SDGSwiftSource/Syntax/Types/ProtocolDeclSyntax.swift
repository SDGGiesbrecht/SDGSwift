/*
 ProtocolDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

extension ProtocolDeclSyntax : AccessControlled, APIDeclaration, Attributed, Constrained {

    internal var protocolAPI: ProtocolAPI? {
        if ¬isPublic ∨ isUnavailable() {
            return nil
        }
        if identifier.text.hasPrefix("_") {
            return nil
        }
        var children = apiChildren()
        if let conformances = inheritanceClause?.conformances {
            children.append(contentsOf: conformances.lazy.map({ APIElement.conformance($0) }))
        }
        return ProtocolAPI(
            documentation: documentation,
            declaration: self,
            children: children)
    }

    // MARK: - APIDeclaration

    internal func normalizedAPIDeclaration() -> ProtocolDeclSyntax {
        return SyntaxFactory.makeProtocolDecl(
            attributes: attributes?.normalizedForAPIDeclaration(),
            modifiers: modifiers?.normalizedForAPIDeclaration(operatorFunction: false),
            protocolKeyword: protocolKeyword.generallyNormalizedAndMissingInsteadOfNil(trailingTrivia: .spaces(1)),
            identifier: identifier.generallyNormalizedAndMissingInsteadOfNil(),
            inheritanceClause: nil,
            genericWhereClause: genericWhereClause?.normalized(),
            members: SyntaxFactory.makeBlankMemberDeclBlock())
    }

    internal func name() -> ProtocolDeclSyntax {
        return SyntaxFactory.makeProtocolDecl(
            attributes: nil,
            modifiers: nil,
            protocolKeyword: SyntaxFactory.makeToken(.protocolKeyword, presence: .missing),
            identifier: identifier,
            inheritanceClause: nil,
            genericWhereClause: nil,
            members: SyntaxFactory.makeBlankMemberDeclBlock())
    }

    internal func identifierList() -> Set<String> {
        return [identifier.text]
    }
}
