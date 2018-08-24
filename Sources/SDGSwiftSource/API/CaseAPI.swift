/*
 CaseAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

public class CaseAPI : APIElement {

    // MARK: - Initialization

    internal init(name: String, associatedValues: [TypeReferenceAPI]) {
        _name = name.decomposedStringWithCanonicalMapping
        self.associatedValues = associatedValues
    }

    // MARK: - Properties

    private let _name: String
    private let associatedValues: [TypeReferenceAPI]

    // MARK: - APIElement

    public override var name: String {
        var result = _name
        if ¬associatedValues.isEmpty {
            result += "("
            result += associatedValues.map({ _ in "_" }).joined(separator: ", ")
            result += ")"
        }
        return result
    }

    public override var declaration: Syntax {

        var tokens: [TokenSyntax] = [
            SyntaxFactory.makeCaseKeyword(trailingTrivia: .spaces(1)),
            SyntaxFactory.makeToken(.identifier(_name))
        ]
        if ¬associatedValues.isEmpty {
            tokens.append(SyntaxFactory.makeToken(.leftParen))
            tokens.append(contentsOf: associatedValues.map({ $0.declaration.tokens() }).joined(separator: [SyntaxFactory.makeToken(.comma, trailingTrivia: .spaces(1))]))
            tokens.append(SyntaxFactory.makeToken(.rightParen))
        }

        // #workaround(Swift 4.1.2, SwiftSyntax has no factory for this.)
        return SyntaxFactory.makeUnknownSyntax(tokens: tokens)
    }

    public override var identifierList: Set<String> {
        return [_name]
    }

    public override var summary: [String] {
        var result = name + " • " + declaration.source()
        appendCompilationConditions(to: &result)
        return [result]
    }
}
