/*
 UnknownStmtSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

extension UnknownStmtSyntax {

    // MARK: - Compilation Conditions

    private var compilerIfKeyword: TokenSyntax? {
        for child in children {
            if let token = child as? TokenSyntax,
                token.tokenKind == .poundIfKeyword {
                return token
            }
        }
        return nil
    }

    internal var isConditionalCompilation: Bool {
        return compilerIfKeyword ≠ nil
    }

    internal var conditionallyCompiledChildren: [APIElement] {
        var previousConditions: [String] = []
        var currentCondition: String? = nil
        var api: [APIElement] = []
        for child in children {
            switch child {
            case let token as TokenSyntax : // “#if”, “#elseif” or “#else”
                switch token.tokenKind {
                case .poundElseifKeyword, .poundElseKeyword:
                    if let current = currentCondition {
                        previousConditions.append(current)
                        currentCondition = nil
                    }
                default:
                    break
                }
                break
            case let condition as UnknownExprSyntax :
                currentCondition = condition.source() // #warning(Needs to filter trivia.)
            case let contents as SyntaxCollection<StmtSyntax> :
                var composedConditions = "#if "
                composedConditions.append(contentsOf: previousConditions.map({ "!(" + $0 + ")" }).joined(separator: " && "))
                if previousConditions.isEmpty {
                    composedConditions.append(contentsOf: (currentCondition ?? ""))
                } else {
                    if let current = currentCondition {
                        composedConditions.append(contentsOf: " && (" + current + ")")
                    }
                }
                for element in contents.api() {
                    if var existing = element.compilationConditions {
                        existing.removeFirst(4)
                        existing.prepend("(")
                        existing.append(")")
                        existing.append(contentsOf: " && (" + composedConditions + ")")
                        existing.prepend(contentsOf: "#if ")
                        element.compilationConditions = existing
                    } else {
                        element.compilationConditions = composedConditions
                    }
                    api.append(element)
                }
            default:
                break
            }
        }
        return api
    }
}
