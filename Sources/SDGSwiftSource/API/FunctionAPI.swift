/*
 FunctionAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

public class FunctionAPI : APIElement {

    // MARK: - Initialization

    internal init(typeMethodKeyword: TokenKind?, isMutating: Bool, name: String, arguments: [ParameterAPI], throws: Bool, returnType: TypeReferenceAPI?, isOperator: Bool) {
        self.typeMethodKeyword = isOperator ? nil : typeMethodKeyword // @exempt(from: tests) False coverage in Xcode 9.4.1.
        self.isMutating = isMutating
        _name = name.decomposedStringWithCanonicalMapping
        self.arguments = arguments
        self.throws = `throws`
        self.returnType = returnType
        self.isOperator = isOperator
    }

    // MARK: - Properties

    internal let typeMethodKeyword: TokenKind?
    private let isMutating: Bool
    private let _name: String
    private let arguments: [ParameterAPI]
    private let `throws`: Bool
    private let returnType: TypeReferenceAPI?

    private let isOperator: Bool

    internal var isProtocolRequirement: Bool = false
    internal var hasDefaultImplementation: Bool = false
    private var _overloads: [FunctionAPI] = []
    internal var overloads: [FunctionAPI] {
        get {
            return _overloads
        }
        set {
            var new = newValue.sorted()
            if isProtocolRequirement {
                for index in new.indices {
                    let overload = new[index]
                    if overload.declaration == declaration {
                        hasDefaultImplementation = true
                        new.remove(at: index)
                        break
                    }
                }
            }
            _overloads = new
        }
    }

    // MARK: - Combining

    internal static func groupIntoOverloads(_ functions: [FunctionAPI]) -> [FunctionAPI] {
        var sorted: [String: [FunctionAPI]] = [:]

        for function in functions {
            sorted[(function.typeMethodKeyword ≠ nil ? "static " : "") + function.name, default: []].append(function)
        }

        var result: [FunctionAPI] = []
        for (_, group) in sorted {
            var merged: FunctionAPI?
            for function in group.sorted() {
                if let existing = merged {
                    existing.overloads.append(function)
                } else {
                    merged = function
                }
            }
            result.append(merged!)
        }

        return result
    }

    // MARK: - APIElement

    public override var name: String {
        return _name + "(" + arguments.map({ isOperator ? $0.operatorNameForm : $0.functionNameForm }).joined() + ")"
    }

    public override var declaration: FunctionDeclSyntax {

        var modifiers: [DeclModifierSyntax] = []
        if let typeKeyword = typeMethodKeyword {
            modifiers.append(SyntaxFactory.makeDeclModifier(
                name: SyntaxFactory.makeToken(typeKeyword, trailingTrivia: .spaces(1)),
                detail: SyntaxFactory.makeTokenList([])))
        }

        if isMutating {
            modifiers.append(SyntaxFactory.makeDeclModifier(
                name: SyntaxFactory.makeToken(.identifier("mutating"), trailingTrivia: .spaces(1)),
                detail: SyntaxFactory.makeTokenList([])))
        }

        var modifierList: ModifierListSyntax?
        if ¬modifiers.isEmpty {
            modifierList = SyntaxFactory.makeModifierList(modifiers)
        }

        var parameters: [FunctionParameterSyntax] = []
        if ¬arguments.isEmpty {
            for index in arguments.indices {
                let argument = arguments[index]
                if isOperator {
                    parameters.append(argument.operatorDeclarationForm(trailingComma: index ≠ arguments.index(before: arguments.endIndex)))
                } else {
                    parameters.append(argument.functionDeclarationForm(trailingComma: index ≠ arguments.index(before: arguments.endIndex)))
                }
            }
        }

        var throwsKeyword: TokenSyntax?
        if `throws` {
            throwsKeyword = SyntaxFactory.makeToken(.throwsKeyword, leadingTrivia: .spaces(1))
        }

        var arrow: TokenSyntax?
        var returnTypeSyntax: TypeSyntax?
        if let returnType = self.returnType?.declaration, returnType.source() ≠ "Void", returnType.source() ≠ "()" {
            arrow = SyntaxFactory.makeToken(.arrow, leadingTrivia: .spaces(1), trailingTrivia: .spaces(1))
            returnTypeSyntax = returnType
        }

        return SyntaxFactory.makeFunctionDecl(
            attributes: nil,
            modifiers: modifierList,
            funcKeyword: SyntaxFactory.makeToken(.funcKeyword, trailingTrivia: .spaces(1)),
            identifier: SyntaxFactory.makeToken(.identifier(_name)),
            genericParameterClause: nil,
            signature: SyntaxFactory.makeFunctionSignature(
                leftParen: SyntaxFactory.makeToken(.leftParen),
                parameterList: SyntaxFactory.makeFunctionParameterList(parameters),
                rightParen: SyntaxFactory.makeToken(.rightParen),
                throwsOrRethrowsKeyword: throwsKeyword,
                arrow: arrow,
                returnTypeAttributes: nil,
                returnType: returnTypeSyntax),
            genericWhereClause: constraintSyntax(),
            body: SyntaxFactory.makeBlankCodeBlock())
    }

    public override var summary: [String] {
        var result = ""
        if isProtocolRequirement {
            if hasDefaultImplementation {
                result += "(customizable) "
            } else {
                result += "(required) "
            }
        }
        result += name + " • " + declaration.source()
        appendCompilationConditions(to: &result)
        var resultSummary = [result]
        for overload in overloads {
            var declaration = overload.declaration.source()
            overload.appendCompilationConditions(to: &declaration)
            resultSummary.append(declaration.prepending(" "))
        }
        return resultSummary
    }
}
