/*
 FunctionParameterSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

extension FunctionParameterSyntax {

    // MARK: - Function Parameters

    internal func normalizedForFunctionDeclaration() -> FunctionParameterSyntax {

        // #workaround(SwiftSyntax 0.40200.0, SwiftSyntax puts the trailing comma here.)
        let ellipsisToken: TokenSyntax?
        if ellipsis?.tokenKind == .comma {
            ellipsisToken = ellipsis?.generallyNormalized(trailingTrivia: .spaces(1))
        } else {
            ellipsisToken = ellipsis?.generallyNormalized()
        }

        return SyntaxFactory.makeFunctionParameter(
            attributes: attributes?.normalizedForAPIDeclaration(),
            firstName: firstName?.generallyNormalized(),
            secondName: secondName?.generallyNormalized(leadingTrivia: .spaces(1)),
            colon: colon?.generallyNormalized(trailingTrivia: .spaces(1)),
            type: type?.normalized(),
            ellipsis: ellipsisToken,
            defaultArgument: defaultArgument?.normalizeForDefaultArgument(),
            trailingComma: trailingComma?.generallyNormalized(trailingTrivia: .spaces(1)))
    }

    internal func forOverloadPattern(operator: Bool) -> FunctionParameterSyntax {
        return SyntaxFactory.makeFunctionParameter(
            attributes: nil,
            firstName: `operator` ? SyntaxFactory.makeToken(.identifier("_")) : firstName?.generallyNormalized(),
            secondName: nil,
            colon: colon,
            type: nil,
            ellipsis: ellipsis,
            defaultArgument: nil,
            trailingComma: trailingComma)
    }

    internal func forFunctionName(operator: Bool) -> FunctionParameterSyntax {
        return SyntaxFactory.makeFunctionParameter(
            attributes: nil,
            firstName: `operator` ? SyntaxFactory.makeToken(.identifier("_")) : firstName?.generallyNormalized(),
            secondName: nil,
            colon: colon?.generallyNormalized(),
            type: nil,
            ellipsis: nil,
            defaultArgument: nil,
            trailingComma: nil)
    }

    internal func identifierListForFunction() -> Set<String> {
        var result: Set<String> = []
        if let externalName = firstName {
            result.insert(externalName.text)
        }
        return result
    }

    internal func forSubscriptName() -> FunctionParameterSyntax {
        return SyntaxFactory.makeFunctionParameter(
            attributes: nil,
            firstName: secondName?.isPresent == true ? firstName : SyntaxFactory.makeToken(.wildcardKeyword),
            secondName: nil,
            colon: colon?.generallyNormalized(),
            type: nil,
            ellipsis: nil,
            defaultArgument: nil,
            trailingComma: nil)
    }

    // MARK: - Associated Values

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
