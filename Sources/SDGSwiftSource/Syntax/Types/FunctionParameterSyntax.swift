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

    internal enum LabelBehaviour {

        case function
        case `operator`
        case `subscript`

        internal var capableOfLabels: Bool {
            switch self {
            case .function, .subscript:
                return true
            case .operator:
                return false
            }
        }

        internal var hasLabelByDefault: Bool {
            switch self {
            case .function:
                return true
            case .operator, .subscript:
                return false
            }
        }
    }

    private func externalLabel(labelBehaviour: LabelBehaviour) -> TokenSyntax? {
        switch labelBehaviour {
        case .function:
            return firstName
        case .operator:
            return nil
        case .subscript:
            if secondName?.isPresent == true {
                return firstName
            } else {
                return nil
            }
        }
    }

    internal func normalizedForDeclaration(labelBehaviour: LabelBehaviour) -> FunctionParameterSyntax {

        // #workaround(SwiftSyntax 0.40200.0, SwiftSyntax puts the trailing comma here.)
        let ellipsisToken: TokenSyntax?
        if ellipsis?.tokenKind == .comma {
            ellipsisToken = ellipsis?.generallyNormalized(trailingTrivia: .spaces(1))
        } else {
            ellipsisToken = ellipsis?.generallyNormalized()
        }

        var firstName = self.firstName?.generallyNormalized()
        var secondName = self.secondName?.generallyNormalized(leadingTrivia: .spaces(1))
        if ¬labelBehaviour.hasLabelByDefault,
            firstName?.tokenKind == .wildcardKeyword {
            firstName = secondName
            secondName = nil
        }

        return SyntaxFactory.makeFunctionParameter(
            attributes: attributes?.normalizedForAPIDeclaration(),
            firstName: firstName,
            secondName: secondName,
            colon: colon?.generallyNormalized(trailingTrivia: .spaces(1)),
            type: type?.normalized(),
            ellipsis: ellipsisToken,
            defaultArgument: defaultArgument?.normalizeForDefaultArgument(),
            trailingComma: trailingComma?.generallyNormalized(trailingTrivia: .spaces(1)))
    }

    internal func forOverloadPattern(labelBehaviour: LabelBehaviour) -> FunctionParameterSyntax {
        return SyntaxFactory.makeFunctionParameter(
            attributes: nil,
            firstName: labelBehaviour.capableOfLabels ? firstName?.generallyNormalized() : SyntaxFactory.makeToken(.identifier("_")),
            secondName: nil,
            colon: colon,
            type: nil,
            ellipsis: ellipsis,
            defaultArgument: nil,
            trailingComma: trailingComma)
    }

    internal func forName(labelBehaviour: LabelBehaviour) -> FunctionParameterSyntax {
        return SyntaxFactory.makeFunctionParameter(
            attributes: nil,
            firstName: externalLabel(labelBehaviour: labelBehaviour) ?? SyntaxFactory.makeToken(.wildcardKeyword),
            secondName: nil,
            colon: colon?.generallyNormalized(),
            type: nil,
            ellipsis: nil,
            defaultArgument: nil,
            trailingComma: nil)
    }

    internal func identifierList(labelBehaviour: LabelBehaviour) -> Set<String> {
        var result: Set<String> = []
        if let label = externalLabel(labelBehaviour: labelBehaviour) {
            result.insert(label.text)
        }
        return result
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
