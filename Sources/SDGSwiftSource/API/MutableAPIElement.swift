/*
 MutableAPIElement.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

internal protocol MutableAPIElement : APIElementProtocol {
    var constraints: GenericWhereClauseSyntax? { get set }
    var compilationConditions: Syntax? { get set }
}

extension MutableAPIElement {

    internal mutating func prependCompilationCondition(_ addition: Syntax?) {
        if let new = addition {
            if let existing = compilationConditions {
                let existingCondition = Array(existing.tokens().dropFirst())
                let newCondition = Array(new.tokens().dropFirst())
                compilationConditions = SyntaxFactory.makeUnknownSyntax(tokens: [
                    SyntaxFactory.makeToken(.poundIfKeyword, trailingTrivia: .spaces(1)),
                    SyntaxFactory.makeToken(.leftParen)
                    ] + newCondition + [
                        SyntaxFactory.makeToken(.rightParen),
                        SyntaxFactory.makeToken(.spacedBinaryOperator("\u{26}&"), leadingTrivia: .spaces(1), trailingTrivia: .spaces(1)),
                        SyntaxFactory.makeToken(.leftParen)
                    ] + existingCondition + [
                        SyntaxFactory.makeToken(.rightParen)
                    ])
            } else {
                compilationConditions = new
            }
        }
    }
}
