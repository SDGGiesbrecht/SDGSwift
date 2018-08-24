/*
 SubscriptAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

public class SubscriptAPI : APIElement {

    // MARK: - Initialization

    internal init(arguments: [ParameterAPI], returnType: TypeReferenceAPI, isSettable: Bool) {
        self.arguments = arguments
        self.returnType = returnType
        self.isSettable = isSettable
    }

    // MARK: - Properties

    private let arguments: [ParameterAPI]
    private let returnType: TypeReferenceAPI
    private var isSettable: Bool

    // MARK: - APIElement

    public override var name: String {
        return "[" + arguments.map({ $0.subscriptNameForm }).joined() + "]"
    }

    public override var declaration: String {
        var result = "subscript(" + arguments.map({ $0.subscriptDeclarationForm(trailingComma: false).source() }).joined(separator: ", ") + ")"
        result += " \u{2D}> " + returnType.declaration.source()
        if let constraints = constraintSyntax() {
            result += constraints.source()
        }
        result += " { get " + (isSettable ? "set " : "") + "}"

        var parameters: [FunctionParameterSyntax] = []
        if ¬arguments.isEmpty {
            for index in arguments.indices {
                let argument = arguments[index]
                parameters.append(argument.subscriptDeclarationForm(trailingComma: index ≠ arguments.index(before: arguments.endIndex)))
            }
        }

        var modifiers: [Syntax] = [
            SyntaxFactory.makeToken(.leftBrace, leadingTrivia: .spaces(1), trailingTrivia: .spaces(1)),
            SyntaxFactory.makeToken(.identifier("get"))
        ]
        if isSettable {
            modifiers.append(SyntaxFactory.makeToken(.identifier("set"), leadingTrivia: .spaces(1)))
        }
        modifiers.append(SyntaxFactory.makeToken(.rightBrace, leadingTrivia: .spaces(1)))

        // #workaround(Swift 4.1.2, SwiftSyntax has not builder for this.)
        return SyntaxFactory.makeDeclList([

            SyntaxFactory.makeFunctionDecl(
            attributes: nil,
            modifiers: nil,
            funcKeyword: SyntaxFactory.makeToken(.funcKeyword, presence: .missing),
            identifier: SyntaxFactory.makeToken(.subscriptKeyword),
            genericParameterClause: nil,
            signature: SyntaxFactory.makeFunctionSignature(
                leftParen: SyntaxFactory.makeToken(.leftParen),
                parameterList: SyntaxFactory.makeFunctionParameterList(parameters),
                rightParen: SyntaxFactory.makeToken(.rightParen),
                throwsOrRethrowsKeyword: nil,
                arrow: SyntaxFactory.makeToken(.arrow, leadingTrivia: .spaces(1), trailingTrivia: .spaces(1)),
                returnTypeAttributes: nil,
                returnType: returnType.declaration),
            genericWhereClause: nil,
            body: SyntaxFactory.makeBlankCodeBlock()),

            SyntaxFactory.makeFunctionDecl(
                attributes: nil,
                modifiers: SyntaxFactory.makeModifierList(modifiers),
                funcKeyword: SyntaxFactory.makeToken(.funcKeyword, presence: .missing),
                identifier: SyntaxFactory.makeToken(.identifier(""), presence: .missing),
                genericParameterClause: nil,
                signature: SyntaxFactory.makeBlankFunctionSignature(),
                genericWhereClause: constraintSyntax(),
                body: SyntaxFactory.makeBlankCodeBlock())
            ]).source()
    }

    public override var summary: [String] {
        var result = name + " • " + declaration
        appendCompilationConditions(to: &result)
        return [result]
    }
}
