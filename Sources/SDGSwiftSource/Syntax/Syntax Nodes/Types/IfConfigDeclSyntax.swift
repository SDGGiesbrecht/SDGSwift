/*
 IfConfigDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.3.1, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(WASI) || os(tvOS) || os(iOS) || os(Android) || os(watchOS))
  import SDGLogic
  import SDGCollections

  import SwiftSyntax

  extension IfConfigDeclSyntax {

    internal var conditionalAPI: [APIElement] {
      var combined: [APIElement: Syntax?] = [:]
      var previousGroups: [(condition: Syntax, elements: Set<APIElement>)] = []

      for syntaxGroup in clauses {
        let currentCondition = Syntax(
          SyntaxFactory.makeUnknownSyntax(
            tokens: syntaxGroup.condition?.withTriviaReducedToSpaces().tokens() ?? []
          )
        )

        var apiGroup: (condition: Syntax, elements: Set<APIElement>) = (currentCondition, [])
        defer { previousGroups.append(apiGroup) }

        for apiElement in syntaxGroup.elements.apiChildren() {
          apiGroup.elements.insert(apiElement)

          if syntaxGroup.poundKeyword.tokenKind == .poundElseKeyword,
            ¬previousGroups.contains(where: { apiElement ∉ $0.elements })
          {
            combined[apiElement] = Optional<Syntax>.none
          } else {
            var composedConditionTokens: [TokenSyntax] = [
              SyntaxFactory.makeToken(.poundIfKeyword, trailingTrivia: .spaces(1))
            ]
            var needsParentheses: Bool = false
            for previousGroup in previousGroups {
              needsParentheses = true
              if previousGroup.elements.contains(apiElement) {
                composedConditionTokens.append(
                  contentsOf: [
                    SyntaxFactory.makeToken(.leftParen)
                  ] + previousGroup.condition.tokens() + [
                    SyntaxFactory.makeToken(.rightParen),
                    SyntaxFactory.makeToken(
                      .spacedBinaryOperator("\u{7C}|"),
                      leadingTrivia: .spaces(1),
                      trailingTrivia: .spaces(1)
                    ),
                  ]
                )
              } else {
                composedConditionTokens.append(
                  contentsOf: [
                    SyntaxFactory.makeToken(.prefixOperator("!")),
                    SyntaxFactory.makeToken(.leftParen),
                  ] + previousGroup.condition.tokens() + [
                    SyntaxFactory.makeToken(.rightParen),
                    SyntaxFactory.makeToken(
                      .spacedBinaryOperator("\u{26}&"),
                      leadingTrivia: .spaces(1),
                      trailingTrivia: .spaces(1)
                    ),
                  ]
                )
              }
            }

            if currentCondition.tokens().isEmpty,
              ¬composedConditionTokens.isEmpty
            {
              composedConditionTokens.removeLast()
            } else {
              if needsParentheses {
                composedConditionTokens.append(
                  contentsOf: [
                    SyntaxFactory.makeToken(.leftParen)
                  ] + currentCondition.tokens() + [
                    SyntaxFactory.makeToken(.rightParen)
                  ]
                )
              } else {
                composedConditionTokens.append(contentsOf: currentCondition.tokens())
              }
            }

            var composedConditions: Syntax?
            if ¬composedConditionTokens.isEmpty {
              composedConditions = Syntax(
                SyntaxFactory.makeUnknownSyntax(tokens: composedConditionTokens)
              )
            }
            combined[apiElement] = composedConditions
          }
        }
      }

      var result: [APIElement] = []
      for element in combined.keys.sorted() {
        let condition: Syntax? = combined[element]!
        element.compilationConditions.prependCompilationConditions(condition)
        result.append(element)
      }
      return result
    }
  }
#endif
