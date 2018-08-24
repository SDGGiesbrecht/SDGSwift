/*
 ProtocolAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public class ProtocolAPI : APIScope {

    // MARK: - Initialization

    internal init(name: String, conformances: [ConformanceAPI], constraints: [ConstraintAPI], children: [APIElement]) {
        _name = name.decomposedStringWithCanonicalMapping
        super.init(conformances: conformances, children: children)
        self.constraints = constraints

        for method in methods {
            method.isProtocolRequirement = true // @exempt(from: tests) False coverage result in Xcode 9.4.1.
        }
    }

    // MARK: - Properties

    private let _name: String

    // MARK: - APIElement

    public override var name: String {
        return _name.description
    }

    public override var declaration: String {
        // #workaround(Swift 4.1.2, SwiftSyntax has no factory for this yet.
        return SyntaxFactory.makeStructDecl(
            attributes: nil,
            accessLevelModifier: nil,
            structKeyword: SyntaxFactory.makeToken(.protocolKeyword, trailingTrivia: .spaces(1)),
            identifier: SyntaxFactory.makeToken(.identifier(name)),
            genericParameterClause: nil,
            inheritanceClause: nil,
            genericWhereClause: constraintSyntax(),
            members: SyntaxFactory.makeBlankMemberDeclBlock()).source()
    }

    public override var summary: [String] {
        var result = name + " • " + declaration
        appendCompilationConditions(to: &result)
        return [result] + scopeSummary
    }
}
