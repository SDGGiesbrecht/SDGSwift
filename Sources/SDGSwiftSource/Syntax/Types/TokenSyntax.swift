/*
 TokenSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGMathematics
import SDGCollections

extension TokenSyntax {

    // MARK: - Properties

    public var extended: ExtendedSyntax? {
        if case .stringLiteral(let source) = tokenKind {
            return StringLiteralSyntax(source: source)
        } else {
            return nil
        }
    }

    public var textFreedom: TextFreedom {
        switch tokenKind {
        case .identifier, .unspacedBinaryOperator, .spacedBinaryOperator, .prefixOperator, .postfixOperator:
            if let parent = self.parent {
                if let enumerationCaseElement = parent as? EnumCaseElementSyntax,
                    enumerationCaseElement.identifier == self {
                    // Enumeration case declaration.
                    return .arbitrary
                }
                if let identifierPattern = parent as? IdentifierPatternSyntax,
                    identifierPattern.identifier == self {
                    // Variable declaration.
                    return .arbitrary
                }
                if let functionParameter = parent as? FunctionParameterSyntax,
                    functionParameter.firstName == self ∨ functionParameter.secondName == self {
                    // Function parameter declaration.
                    return .arbitrary
                }
                if let genericParameter = parent as? GenericParameterSyntax,
                    genericParameter.name == self {
                    // Generic member type declaration.
                    return .arbitrary
                }

                if let declarationModifier = parent as? DeclModifierSyntax,
                    declarationModifier.name == self {
                    // “open”, “mutating”, etc.
                    return .invariable
                }
                if let accessPath = parent as? AccessPathComponentSyntax,
                    accessPath.name == self {
                    // Import statement.
                    return .invariable
                }
                var previousAncestor: Syntax = self
                for ancestor in ancestors() {
                    defer { previousAncestor = ancestor }
                    if let ifConfigurationClause = ancestor as? IfConfigClauseSyntax,
                        let condition = ifConfigurationClause.condition,
                        condition == previousAncestor {
                        // #if condition
                        return .invariable
                    }
                }

                if parent.isDecl == true {
                    /// Declaration.
                    return .arbitrary
                }
                if let argument = parent as? FunctionCallArgumentSyntax,
                    argument.label == self {
                    return .aliasable
                }

                for ancestor in ancestors() {
                    switch ancestor {
                    case is IdentifierExprSyntax, is UnknownExprSyntax :
                        continue
                    case is UnknownStmtSyntax, is UnknownSyntax :
                        if let token = ancestor.children.first(where: { _ in true }) as? TokenSyntax,
                            token.tokenKind == .poundIfKeyword ∨ token.tokenKind == .poundElseifKeyword {
                            // Part of an “#if” statement.
                            return .invariable
                        }
                    default:
                        break
                    }
                }
            }

            if text == "init" {
                return .invariable
            }
            return .aliasable
        case .stringSegment, .integerLiteral, .floatingLiteral, .stringLiteral:
            return .arbitrary
        case .eof, .associatedtypeKeyword, .classKeyword, .deinitKeyword, .enumKeyword, .extensionKeyword, .funcKeyword, .importKeyword, .initKeyword, .inoutKeyword, .letKeyword, .operatorKeyword, .precedencegroupKeyword, .protocolKeyword, .structKeyword, .subscriptKeyword, .typealiasKeyword, .varKeyword, .fileprivateKeyword, .internalKeyword, .privateKeyword, .publicKeyword, .staticKeyword, .deferKeyword, .ifKeyword, .guardKeyword, .doKeyword, .repeatKeyword, .elseKeyword, .forKeyword, .inKeyword, .whileKeyword, .returnKeyword, .breakKeyword, .continueKeyword, .fallthroughKeyword, .switchKeyword, .caseKeyword, .defaultKeyword, .whereKeyword, .catchKeyword, .asKeyword, .anyKeyword, .falseKeyword, .isKeyword, .nilKeyword, .rethrowsKeyword, .superKeyword, .selfKeyword, .capitalSelfKeyword, .throwKeyword, .trueKeyword, .tryKeyword, .throwsKeyword, .__file__Keyword, .__line__Keyword, .__column__Keyword, .__function__Keyword, .__dso_handle__Keyword, .wildcardKeyword, .poundAvailableKeyword, .poundEndifKeyword, .poundElseKeyword, .poundElseifKeyword, .poundIfKeyword, .poundSourceLocationKeyword, .poundFileKeyword, .poundLineKeyword, .poundColumnKeyword, .poundDsohandleKeyword, .poundFunctionKeyword, .poundSelectorKeyword, .poundKeyPathKeyword, .poundColorLiteralKeyword, .poundFileLiteralKeyword, .poundImageLiteralKeyword, .arrow, .atSign, .colon, .semicolon, .comma, .period, .equal, .prefixPeriod, .leftParen, .rightParen, .leftBrace, .rightBrace, .leftSquareBracket, .rightSquareBracket, .leftAngle, .rightAngle, .prefixAmpersand, .postfixQuestionMark, .infixQuestionMark, .exclamationMark, .backslash, .stringInterpolationAnchor, .stringQuote, .multilineStringQuote, .dollarIdentifier, .contextualKeyword, .unknown:
            return .invariable
        }
    }

    // MARK: - Location

    private func index(in string: String, for position: AbsolutePosition) -> String.ScalarView.Index {
        let utf8 = string.utf8
        return utf8.index(utf8.startIndex, offsetBy: position.utf8Offset)
    }

    public func lowerTriviaBound(in string: String) -> String.ScalarView.Index {
        return index(in: string, for: position)
    }

    public func lowerTokenBound(in string: String) -> String.ScalarView.Index {
        return index(in: string, for: positionAfterSkippingLeadingTrivia)
    }

    public func upperTokenBound(in string: String) -> String.ScalarView.Index {
        return index(in: string, for: endPosition)
    }

    public func upperTriviaBound(in string: String) -> String.ScalarView.Index {
        return index(in: string, for: endPositionAfterTrailingTrivia)
    }

    public func tokenRange(in string: String) -> Range<String.ScalarView.Index> {
        return lowerTokenBound(in: string) ..< upperTokenBound(in: string)
    }

    public func triviaRange(in string: String) -> Range<String.ScalarView.Index> {
        return lowerTriviaBound(in: string) ..< upperTriviaBound(in: string)
    }

    // MARK: - Syntax Tree

    internal func firstPrecedingTrivia() -> TriviaPiece? {
        return leadingTrivia.last() ?? previousToken()?.trailingTrivia.last()
    }

    internal func firstFollowingTrivia() -> TriviaPiece? {
        return trailingTrivia.first ?? nextToken()?.leadingTrivia.first
    }

    internal func previousToken() -> TokenSyntax? {
        func previousSibling(of relationship: (parent: Syntax, index: Int)) -> Syntax? {
            var previousIndex = relationship.index
            while previousIndex > 0 {
                previousIndex −= 1
                if let exists = relationship.parent.child(at: previousIndex) {
                    return exists
                }
            }
            return nil
        }

        let sharedAncestor = ancestorRelationships().first(where: { relationship in
            if previousSibling(of: relationship) ≠ nil {
                return true
            }
            return false
        })

        return sharedAncestor.flatMap({ previousSibling(of: $0) })?.lastToken()
    }

    internal func nextToken() -> TokenSyntax? {
        func nextSibling(of relationship: (parent: Syntax, index: Int)) -> Syntax? {
            return relationship.parent.child(at: relationship.index + 1)
        }

        let sharedAncestor = ancestorRelationships().first(where: { relationship in
            if nextSibling(of: relationship) ≠ nil {
                return true
            }
            return false
        })

        return sharedAncestor.flatMap({ nextSibling(of: $0) })?.firstToken()
    }

    // MARK: - Syntax Highlighting

    internal func syntaxHighlightingClass(internalIdentifiers: Set<String>) -> String? {
        switch tokenKind {
        case .eof, .unknown:
            return nil

        case .associatedtypeKeyword, .classKeyword, .deinitKeyword, .enumKeyword, .extensionKeyword, .funcKeyword, .importKeyword, .initKeyword, .inoutKeyword, .letKeyword, .operatorKeyword, .precedencegroupKeyword, .protocolKeyword, .structKeyword, .subscriptKeyword, .typealiasKeyword, .varKeyword, .fileprivateKeyword, .internalKeyword, .privateKeyword, .publicKeyword, .staticKeyword, .deferKeyword, .ifKeyword, .guardKeyword, .doKeyword, .repeatKeyword, .elseKeyword, .forKeyword, .inKeyword, .whileKeyword, .returnKeyword, .breakKeyword, .continueKeyword, .fallthroughKeyword, .switchKeyword, .caseKeyword, .defaultKeyword, .whereKeyword, .catchKeyword, .asKeyword, .anyKeyword, .falseKeyword, .isKeyword, .nilKeyword, .rethrowsKeyword, .superKeyword, .selfKeyword, .capitalSelfKeyword, .throwKeyword, .trueKeyword, .tryKeyword, .throwsKeyword, .__file__Keyword, .__line__Keyword, .__column__Keyword, .__function__Keyword, .__dso_handle__Keyword, .wildcardKeyword, .poundAvailableKeyword, .poundSourceLocationKeyword, .poundFileKeyword, .poundLineKeyword, .poundColumnKeyword, .poundDsohandleKeyword, .poundFunctionKeyword, .poundSelectorKeyword, .poundKeyPathKeyword, .poundColorLiteralKeyword, .poundFileLiteralKeyword, .poundImageLiteralKeyword, .atSign, .contextualKeyword:
            return "keyword"

        case .poundEndifKeyword, .poundElseKeyword, .poundElseifKeyword, .poundIfKeyword:
            return "compilation‐condition"

        case .arrow, .colon, .semicolon, .comma, .period, .equal, .prefixPeriod, .leftParen, .rightParen, .leftBrace, .rightBrace, .leftSquareBracket, .rightSquareBracket, .leftAngle, .rightAngle, .prefixAmpersand, .postfixQuestionMark, .infixQuestionMark, .exclamationMark, .backslash, .stringInterpolationAnchor, .dollarIdentifier:
            return "punctuation"

        case .identifier(let name), .unspacedBinaryOperator(let name), .spacedBinaryOperator(let name), .prefixOperator(let name), .postfixOperator(let name):
            if name == "get" ∨ name == "set" ∨ name == "mutating" ∨ name == "open" {
                return "keyword"
            }

            if name ∈ internalIdentifiers {
                return "internal identifier"
            } else {
                return "external identifier"
            }

        case .integerLiteral, .floatingLiteral:
            return "number"

        case .stringQuote, .multilineStringQuote:
            return "string‐punctuation"

        case .stringSegment:
            return "text"

        case .stringLiteral:
            return nil // Disected elsewhere. @exempt(from: tests)
        }
    }

    // MARK: - Short Cuts

    internal var isOperator: Bool {
        switch  tokenKind {
        case .prefixOperator, .postfixOperator, .spacedBinaryOperator, .unspacedBinaryOperator:
            return true
        default:
            return false
        }
    }

    // MARK: - API

    internal func generallyNormalizedAndMissingInsteadOfNil(leadingTrivia: Trivia = [], trailingTrivia: Trivia = []) -> TokenSyntax {
        return SyntaxFactory.makeToken(tokenKind.normalized(), leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
    }

    internal func generallyNormalized(leadingTrivia: Trivia = [], trailingTrivia: Trivia = []) -> TokenSyntax? {
        if ¬isPresent {
            return nil
        }
        return generallyNormalizedAndMissingInsteadOfNil(leadingTrivia: leadingTrivia, trailingTrivia: trailingTrivia)
    }
}
