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

    internal var operatorNameForm: String {
        return "_:"
    }

    internal var subscriptNameForm: String {
        return functionNameForm
    }

    internal func functionDeclarationForm(trailingComma: Bool) -> FunctionParameterSyntax {
        var externalName: TokenSyntax?
        if label ≠ name {
            if let external = label {
                externalName = SyntaxFactory.makeToken(.identifier(external), trailingTrivia: .spaces(1))
            } else {
                externalName = SyntaxFactory.makeToken(.wildcardKeyword, trailingTrivia: .spaces(1))
            }
        }
        return declaration(externalName: externalName, trailingComma: trailingComma)
    }

    internal func operatorDeclarationForm(trailingComma: Bool) -> FunctionParameterSyntax {
        return declaration(externalName: nil, trailingComma: trailingComma)
    }

    internal func subscriptDeclarationForm(trailingComma: Bool) -> FunctionParameterSyntax {
        var externalName: TokenSyntax?
        if let external = label {
            externalName = SyntaxFactory.makeToken(.identifier(external), trailingTrivia: .spaces(1))
        }
        return declaration(externalName: externalName, trailingComma: trailingComma)
    }

    private func declaration(externalName: TokenSyntax?, trailingComma: Bool) -> FunctionParameterSyntax {

        var inOutKeyword: TokenSyntax?
        if isInOut {
            inOutKeyword = SyntaxFactory.makeToken(.inoutKeyword, trailingTrivia: .spaces(1))
        }

        var defaultEquals: TokenSyntax?
        var defaultValue: ExprSyntax?
        if hasDefault {
            defaultEquals = SyntaxFactory.makeToken(.equal, leadingTrivia: .spaces(1), trailingTrivia: .spaces(1))
            defaultValue = SyntaxFactory.makeIdentifierExpr(
                identifier: SyntaxFactory.makeToken(.defaultKeyword),
                declNameArguments: nil)
        }

        var comma: TokenSyntax?
        if trailingComma {
            comma = SyntaxFactory.makeToken(.comma, trailingTrivia: .spaces(1))
        }

        return SyntaxFactory.makeFunctionParameter(
            externalName: externalName,
            localName: SyntaxFactory.makeToken(.identifier(name)),
            colon: SyntaxFactory.makeToken(.colon, trailingTrivia: .spaces(1)),
            typeAnnotation: SyntaxFactory.makeTypeAnnotation(
                attributes: SyntaxFactory.makeAttributeList([]),
                inOutKeyword: inOutKeyword,
                type: type.declaration),
            ellipsis: nil,
            defaultEquals: defaultEquals,
            defaultValue: defaultValue,
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
