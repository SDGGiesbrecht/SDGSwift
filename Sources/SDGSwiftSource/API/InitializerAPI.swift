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

    internal init(documentation: DocumentationSyntax?, isFailable: Bool, arguments: [ParameterAPI], throws: Bool) {
        self.isFailable = isFailable
        self.arguments = arguments
        self.throws = `throws`
        super.init(documentation: documentation)
    }

    // MARK: - Properties

    private let isFailable: Bool
    private let arguments: [ParameterAPI]
    private let `throws`: Bool

    // MARK: - APIElement

    public override var name: String {
        return "init(" + arguments.map({ $0.functionNameForm }).joined() + ")"
    }

    public override var declaration: Syntax {

        var failable: TokenSyntax?
        if isFailable {
            failable = SyntaxFactory.makeToken(.infixQuestionMark)
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

        return SyntaxFactory.makeInitializerDecl(
            attributes: nil,
            modifiers: nil,
            initKeyword: SyntaxFactory.makeToken(.initKeyword),
            optionalMark: failable,
            genericParameterClause: nil,
            parameters: SyntaxFactory.makeParameterClause(
                leftParen: SyntaxFactory.makeToken(.leftParen),
                parameterList: SyntaxFactory.makeFunctionParameterList(parameters),
                rightParen: SyntaxFactory.makeToken(.rightParen)),
            throwsOrRethrowsKeyword: throwsKeyword,
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
