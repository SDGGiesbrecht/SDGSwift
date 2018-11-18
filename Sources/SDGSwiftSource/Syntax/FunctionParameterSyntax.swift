/*
 FunctionParameterSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

extension FunctionParameterSyntax {

    internal func parameterAPI(forSubscript: Bool) -> ParameterAPI {
        var label: String?
        if let possibleLabel = firstName,
            possibleLabel.tokenKind ≠ .wildcardKeyword {
            label = possibleLabel.text
        }
        var name: String
        if let different = secondName?.text {
            name = different
        } else {
            name = firstName?.text ?? "" // @exempt(from: tests) Guaranteed in valid source.
            if forSubscript {
                label = nil
            }
        }

        var isInOut = false
        if let attributed = type as? AttributedTypeSyntax,
            attributed.specifier?.tokenKind == .inoutKeyword {
            isInOut = true
        }

        return ParameterAPI(
            label: label,
            name: name,
            isInOut: isInOut,
            type: self.type?.reference ?? TypeReferenceAPI(name: "", genericArguments: []), // @exempt(from: tests) Guaranteed in valid source.
            hasDefault: defaultArgument ≠ nil)
    }

    internal func normalizedForAssociatedValue() -> FunctionParameterSyntax {

        // #workaround(SwiftSyntax 0.40200.0, SwiftSyntax puts the trailing comma here.)
        let ellipsisToken: TokenSyntax?
        if ellipsis?.tokenKind == .comma {
            ellipsisToken = ellipsis?.generallyNormalized(trailingTrivia: .spaces(1))
        } else {
            ellipsisToken = ellipsis?.generallyNormalized()
        }

        return SyntaxFactory.makeFunctionParameter(
            attributes: attributes?.normalizedForAPIDeclaration(),
            firstName: firstName?.generallyNormalized(trailingTrivia: .spaces(1)),
            secondName: secondName?.generallyNormalized(),
            colon: colon?.generallyNormalized(trailingTrivia: .spaces(1)),
            type: type?.normalized(),
            ellipsis: ellipsisToken,
            defaultArgument: defaultArgument?.normalizeForDefaultArgument(),
            trailingComma: trailingComma?.generallyNormalized(trailingTrivia: .spaces(1)))
    }

    internal func forAssociatedValueName() -> FunctionParameterSyntax {

        // #workaround(SwiftSyntax 0.40200.0, SwiftSyntax puts the trailing comma here.)
        let ellipsisToken: TokenSyntax?
        if ellipsis?.tokenKind == .comma {
            ellipsisToken = ellipsis
        } else {
            ellipsisToken = nil
        }

        return SyntaxFactory.makeFunctionParameter(
            attributes: nil,
            firstName: SyntaxFactory.makeToken(.wildcardKeyword),
            secondName: nil,
            colon: nil,
            type: nil,
            ellipsis: ellipsisToken,
            defaultArgument: nil,
            trailingComma: trailingComma)
    }
}
