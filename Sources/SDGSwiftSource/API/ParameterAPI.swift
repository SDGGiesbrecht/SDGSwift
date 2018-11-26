/*
 ParameterAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

public struct ParameterAPI {

    // MARK: - Initialization

    internal init(label: String?, name: String, isInOut: Bool, type: TypeReferenceAPI, hasDefault: Bool) {
        self.label = label?.decomposedStringWithCanonicalMapping
        self.name = name.decomposedStringWithCanonicalMapping
        self.isInOut = isInOut
        self.type = type
        self.hasDefault = hasDefault
    }

    // MARK: - Properties

    internal let label: String?
    private let name: String
    private let isInOut: Bool
    private let type: TypeReferenceAPI
    private let hasDefault: Bool

    // MARK: - Forms

    internal var functionNameForm: String {
        return (label ?? "_") + ":"
    }

    internal var subscriptNameForm: String {
        return functionNameForm
    }

    internal func subscriptDeclarationForm(trailingComma: Bool) -> FunctionParameterSyntax {
        var externalName: TokenSyntax?
        if let external = label {
            externalName = SyntaxFactory.makeToken(.identifier(external), trailingTrivia: .spaces(1))
        }
        return declaration(externalName: externalName, trailingComma: trailingComma)
    }

    private func declaration(externalName: TokenSyntax?, trailingComma: Bool) -> FunctionParameterSyntax {

        var typeSyntax: TypeSyntax = type.declaration
        if isInOut {
            typeSyntax = SyntaxFactory.makeAttributedType(
                specifier: SyntaxFactory.makeToken(.inoutKeyword, trailingTrivia: .spaces(1)),
                attributes: nil,
                baseType: typeSyntax)
        }

        var defaultArgument: InitializerClauseSyntax?
        if hasDefault {
            defaultArgument = SyntaxFactory.makeInitializerClause(
                equal: SyntaxFactory.makeToken(.equal, leadingTrivia: .spaces(1), trailingTrivia: .spaces(1)),
                value: SyntaxFactory.makeIdentifierExpr(
                    identifier: SyntaxFactory.makeToken(.defaultKeyword),
                    declNameArguments: nil))
        }

        var comma: TokenSyntax?
        if trailingComma {
            comma = SyntaxFactory.makeToken(.comma, trailingTrivia: .spaces(1))
        }

        return SyntaxFactory.makeFunctionParameter(
            attributes: nil,
            firstName: externalName,
            secondName: SyntaxFactory.makeToken(.identifier(name)),
            colon: SyntaxFactory.makeToken(.colon, trailingTrivia: .spaces(1)),
            type: typeSyntax,
            ellipsis: nil,
            defaultArgument: defaultArgument,
            trailingComma: comma)
    }

    internal var identifierList: Set<String> {
        if let label = self.label {
            return [label]
        } else {
            return []
        }
    }
}
