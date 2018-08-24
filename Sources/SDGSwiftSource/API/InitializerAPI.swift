/*
 InitializerAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGCollections

public class InitializerAPI : APIElement {

    // MARK: - Initialization

    internal init(isFailable: Bool, arguments: [ParameterAPI], throws: Bool) {
        self.isFailable = isFailable
        self.arguments = arguments
        self.throws = `throws`
    }

    // MARK: - Properties

    private let isFailable: Bool
    private let arguments: [ParameterAPI]
    private let `throws`: Bool

    // MARK: - APIElement

    public override var name: String {
        return "init(" + arguments.map({ $0.functionNameForm }).joined() + ")"
    }

    public override var declaration: DeclSyntax {

        let failable: TokenSyntax
        if isFailable {
            failable = SyntaxFactory.makeToken(.infixQuestionMark)
        } else {
            failable = SyntaxFactory.makeToken(.infixQuestionMark, presence: .missing)
        }

        var parameters: [FunctionParameterSyntax] = []
        if ¬arguments.isEmpty {
            for index in arguments.indices {
                let argument = arguments[index]
                parameters.append(argument.functionDeclarationForm(trailingComma: index ≠ arguments.index(before: arguments.endIndex)))
            }
        }

        var throwsKeyword: TokenSyntax?
        if `throws` {
            throwsKeyword = SyntaxFactory.makeToken(.throwsKeyword, leadingTrivia: .spaces(1))
        }

        // #workaround(Swift 4.1.2, SwiftSyntax has no factory for this.)
        return SyntaxFactory.makeFunctionDecl(
            attributes: nil,
            modifiers: nil,
            funcKeyword: SyntaxFactory.makeToken(.initKeyword),
            identifier: failable,
            genericParameterClause: nil,
            signature: SyntaxFactory.makeFunctionSignature(
                leftParen: SyntaxFactory.makeToken(.leftParen),
                parameterList: SyntaxFactory.makeFunctionParameterList(parameters),
                rightParen: SyntaxFactory.makeToken(.rightParen),
                throwsOrRethrowsKeyword: throwsKeyword,
                arrow: nil,
                returnTypeAttributes: nil,
                returnType: nil),
            genericWhereClause: constraintSyntax(),
            body: SyntaxFactory.makeBlankCodeBlock())
    }

    public override var identifierList: Set<String> {
        return arguments.map({ $0.identifierList }).reduce(into: Set<String>(), { $0 ∪= $1 })
    }

    public override var summary: [String] {
        var result = name + " • " + declaration.source()
        appendCompilationConditions(to: &result)
        return [result]
    }
}
