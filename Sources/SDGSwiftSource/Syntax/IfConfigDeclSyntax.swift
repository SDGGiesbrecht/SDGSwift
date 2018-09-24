/*
 IfConfigDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

extension IfConfigDeclSyntax {

    internal var conditionalAPI: [APIElement] {
        var combined: [APIElement: Syntax?] = [:]
        var previousGroups: [(condition: Syntax, elements: Set<APIElement>)] = []

        for syntaxGroup in clauses {
            let currentCondition = SyntaxFactory.makeUnknownSyntax(tokens: syntaxGroup.condition?.withTriviaReducedToSpaces().tokens() ?? [])

            var apiGroup: (condition: Syntax, elements: Set<APIElement>) = (currentCondition, [])
            defer { previousGroups.append(apiGroup) }

            for apiElement in syntaxGroup.elements.apiChildren() {
                apiGroup.elements.insert(apiElement)

                var composedConditionTokens: [TokenSyntax] = [SyntaxFactory.makeToken(.poundIfKeyword, trailingTrivia: .spaces(1))]
                var needsParentheses: Bool = false
                for previousGroup in previousGroups {
                    if previousGroup.elements.contains(apiElement) {
                        needsParentheses = true
                        composedConditionTokens.append(contentsOf: [
                            SyntaxFactory.makeToken(.leftParen),
                            ] + previousGroup.condition.tokens() + [
                            SyntaxFactory.makeToken(.rightParen),
                            SyntaxFactory.makeToken(.spacedBinaryOperator("||"), leadingTrivia: .spaces(1), trailingTrivia: .spaces(1)),
                            SyntaxFactory.makeToken(.leftParen)
                            ])
                    }
                }

                if needsParentheses {
                    composedConditionTokens.append(contentsOf: [
                        SyntaxFactory.makeToken(.leftParen),
                        ] + currentCondition.tokens() + [
                            SyntaxFactory.makeToken(.rightParen)
                        ])
                } else {
                    composedConditionTokens.append(contentsOf: currentCondition.tokens())
                }

                var composedConditions: Syntax?
                if ¬composedConditionTokens.isEmpty {
                    composedConditions = SyntaxFactory.makeUnknownSyntax(tokens: composedConditionTokens)
                }
                combined[apiElement] = composedConditions
            }
        }

        var result: [APIElement] = []
        for element in combined.keys.sorted() {
            let condition: Syntax? = combined[element]!
            element.prependCompilationCondition(condition)
            result.append(element)
        }
        return result
    }
}
