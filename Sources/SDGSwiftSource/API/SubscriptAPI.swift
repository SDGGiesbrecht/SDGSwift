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
import SDGCollections

public class SubscriptAPI : APIElement {

    // MARK: - Initialization

    internal init(documentation: DocumentationSyntax?, arguments: [ParameterAPI], returnType: TypeReferenceAPI, isSettable: Bool) {
        self.arguments = arguments
        self.returnType = returnType
        self.isSettable = isSettable
        super.init(documentation: documentation)
    }

    // MARK: - Properties

    private let arguments: [ParameterAPI]
    private let returnType: TypeReferenceAPI
    private var isSettable: Bool

    // MARK: - APIElement

    public override var name: String {
        return "[" + arguments.map({ $0.subscriptNameForm }).joined() + "]"
    }

    public override var declaration: Syntax {

        var parameters: [FunctionParameterSyntax] = []
        if ¬arguments.isEmpty {
            for index in arguments.indices {
                let argument = arguments[index]
                parameters.append(argument.subscriptDeclarationForm(trailingComma: index ≠ arguments.index(before: arguments.endIndex)))
            }
        }

        var accessorList: [AccessorDeclSyntax] = [
            SyntaxFactory.makeAccessorDecl(
                attributes: nil,
                modifier: nil,
                accessorKind: SyntaxFactory.makeContextualKeyword("get"),
                parameter: nil,
                body: nil)
        ]
        if isSettable {
            accessorList.append(SyntaxFactory.makeAccessorDecl(
                attributes: nil,
                modifier: nil,
                accessorKind: SyntaxFactory.makeToken(.contextualKeyword("set"), leadingTrivia: .spaces(1)),
                parameter: nil,
                body: nil))
        }

        return SyntaxFactory.makeSubscriptDecl(
            attributes: nil,
            modifiers: nil,
            subscriptKeyword: SyntaxFactory.makeToken(.subscriptKeyword),
            genericParameterClause: nil,
            indices: SyntaxFactory.makeParameterClause(
                leftParen: SyntaxFactory.makeToken(.leftParen),
                parameterList: SyntaxFactory.makeFunctionParameterList(parameters),
                rightParen: SyntaxFactory.makeToken(.rightParen)),
            result: SyntaxFactory.makeReturnClause(
                arrow: SyntaxFactory.makeToken(.arrow, leadingTrivia: .spaces(1), trailingTrivia: .spaces(1)),
                returnType: returnType.declaration),
            genericWhereClause: constraintSyntax(),
            accessor: SyntaxFactory.makeAccessorBlock(
                leftBrace: SyntaxFactory.makeToken(.leftBrace, leadingTrivia: .spaces(1), trailingTrivia: .spaces(1)),
                accessorListOrStmtList: SyntaxFactory.makeAccessorList(accessorList),
                rightBrace: SyntaxFactory.makeToken(.rightBrace, leadingTrivia: .spaces(1))))
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
