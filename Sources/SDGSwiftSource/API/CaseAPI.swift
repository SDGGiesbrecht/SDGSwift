/*
 CaseAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

public class CaseAPI : APIElement {

    // MARK: - Initialization

    internal init(documentation: DocumentationSyntax?, name: String, associatedValues: [TypeReferenceAPI]) {
        _name = name.decomposedStringWithCanonicalMapping
        self.associatedValues = associatedValues
        super.init(documentation: documentation)
    }

    // MARK: - Properties

    private let _name: String
    private let associatedValues: [TypeReferenceAPI]

    // MARK: - APIElement

    public override var name: String {
        var result = _name
        if ¬associatedValues.isEmpty {
            result += "("
            result += associatedValues.map({ _ in "_" }).joined(separator: ", ")
            result += ")"
        }
        return result
    }

    public override var declaration: Syntax {

        var associatedValue: ParameterClauseSyntax?
        if ¬associatedValues.isEmpty {
            var associatedValueSyntax: [FunctionParameterSyntax] = []
            let last = associatedValues.indices.last!
            for index in associatedValues.indices {
                let associated = associatedValues[index]
                var trailingComma: TokenSyntax?
                if index ≠ last {
                    trailingComma = SyntaxFactory.makeToken(.comma, trailingTrivia: .spaces(1))
                }
                associatedValueSyntax.append(SyntaxFactory.makeFunctionParameter(
                    attributes: nil,
                    firstName: nil,
                    secondName: nil,
                    colon: nil,
                    type: associated.declaration,
                    ellipsis: nil,
                    defaultArgument: nil,
                    trailingComma: trailingComma))
            }
            associatedValue = SyntaxFactory.makeParameterClause(
                leftParen: SyntaxFactory.makeToken(.leftParen),
                parameterList: SyntaxFactory.makeFunctionParameterList(associatedValueSyntax),
                rightParen: SyntaxFactory.makeToken(.rightParen))
        }

        return SyntaxFactory.makeEnumCaseDecl(
            attributes: nil,
            modifiers: nil,
            caseKeyword: SyntaxFactory.makeCaseKeyword(trailingTrivia: .spaces(1)),
            elements: SyntaxFactory.makeEnumCaseElementList([
                SyntaxFactory.makeEnumCaseElement(
                    identifier: SyntaxFactory.makeToken(.identifier(_name)),
                    associatedValue: associatedValue,
                    rawValue: nil,
                    trailingComma: nil)
                ]))
    }

    public override var identifierList: Set<String> {
        return [_name]
    }

    public override var summary: [String] {
        var result = name + " • " + declaration.source()
        appendCompilationConditions(to: &result)
        return [result]
    }
}
