/*
 TypeAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic

public class TypeAPI : APIScope {

    // MARK: - Initialization

    internal init(keyword: TokenKind, name: TypeReferenceAPI, conformances: [ConformanceAPI], constraints: [ConstraintAPI], children: [APIElement]) {
        typeName = name
        self.keyword = keyword
        super.init(conformances: conformances, children: children)
        self.constraints = constraints
    }

    // MARK: - Properties

    private let keyword: TokenKind
    internal let typeName: TypeReferenceAPI

    // MARK: - APIElement

    public override var name: String {
        return typeName.declaration.source()
    }

    public override var declaration: DeclSyntax {
        // #workaround(Swift 4.1.2, SwiftSyntax has no factory classes or enumerations yet.
        return SyntaxFactory.makeStructDecl(
            attributes: nil,
            accessLevelModifier: nil,
            structKeyword: SyntaxFactory.makeToken(keyword, trailingTrivia: .spaces(1)),
            identifier: SyntaxFactory.makeToken(.identifier(name)),
            genericParameterClause: nil,
            inheritanceClause: nil,
            genericWhereClause: constraintSyntax(),
            members: SyntaxFactory.makeBlankMemberDeclBlock())
    }

    public override var summary: [String] {
        var result = name + " • " + declaration.source()
        appendCompilationConditions(to: &result)
        return [result] + scopeSummary
    }
}
