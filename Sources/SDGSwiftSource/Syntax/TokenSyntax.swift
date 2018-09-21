/*
 TokenSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

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
                if let identifierPattern = parent as? IdentifierPatternSyntax,
                    identifierPattern.identifier == self {
                    // Variable declaration.
                    return .arbitrary
                }
                if parent.isDecl == true {
                    if parent.children.contains(where: { ($0 as? TokenSyntax)?.tokenKind == .importKeyword }) {
                        // Name of imported module.
                        return .invariable
                    }
                    /// Declaration.
                    return .arbitrary
                }
                if let argument = parent as? FunctionCallArgumentSyntax,
                    argument.label == self {
                    return .aliasable
                }

                if (parent.child(at: indexInParent − 1) as? TokenSyntax)?.tokenKind == .forKeyword {
                    // Loop variable declaration.
                    return .arbitrary
                }
                if (parent.child(at: indexInParent + 1) as? TokenSyntax)?.tokenKind == .colon {
                    // Closure argument declaration.
                    return .arbitrary
                }

                for ancestor in ancestors() {
                    switch ancestor {
                    case is IdentifierExprSyntax, is UnknownExprSyntax :
                        continue
                    case let statement as UnknownStmtSyntax :
                        if let token = statement.children.first(where: { _ in true }) as? TokenSyntax,
                            token.tokenKind == .poundIfKeyword ∨ token.tokenKind == .poundElseifKeyword {
                            // Part of an “#if” statement.
                            return .invariable
                        }
                    default:
                        break
                    }
                }
            }

            return .aliasable
        case .stringSegment, .integerLiteral, .floatingLiteral, .stringLiteral:
            return .arbitrary
        case .eof, .associatedtypeKeyword, .classKeyword, .deinitKeyword, .enumKeyword, .extensionKeyword, .funcKeyword, .importKeyword, .initKeyword, .inoutKeyword, .letKeyword, .operatorKeyword, .precedencegroupKeyword, .protocolKeyword, .structKeyword, .subscriptKeyword, .typealiasKeyword, .varKeyword, .fileprivateKeyword, .internalKeyword, .privateKeyword, .publicKeyword, .staticKeyword, .deferKeyword, .ifKeyword, .guardKeyword, .doKeyword, .repeatKeyword, .elseKeyword, .forKeyword, .inKeyword, .whileKeyword, .returnKeyword, .breakKeyword, .continueKeyword, .fallthroughKeyword, .switchKeyword, .caseKeyword, .defaultKeyword, .whereKeyword, .catchKeyword, .asKeyword, .anyKeyword, .falseKeyword, .isKeyword, .nilKeyword, .rethrowsKeyword, .superKeyword, .selfKeyword, .capitalSelfKeyword, .throwKeyword, .trueKeyword, .tryKeyword, .throwsKeyword, .__file__Keyword, .__line__Keyword, .__column__Keyword, .__function__Keyword, .__dso_handle__Keyword, .wildcardKeyword, .poundAvailableKeyword, .poundEndifKeyword, .poundElseKeyword, .poundElseifKeyword, .poundIfKeyword, .poundSourceLocationKeyword, .poundFileKeyword, .poundLineKeyword, .poundColumnKeyword, .poundDsohandleKeyword, .poundFunctionKeyword, .poundSelectorKeyword, .poundKeyPathKeyword, .poundColorLiteralKeyword, .poundFileLiteralKeyword, .poundImageLiteralKeyword, .arrow, .atSign, .colon, .semicolon, .comma, .period, .equal, .prefixPeriod, .leftParen, .rightParen, .leftBrace, .rightBrace, .leftSquareBracket, .rightSquareBracket, .leftAngle, .rightAngle, .prefixAmpersand, .postfixQuestionMark, .infixQuestionMark, .exclamationMark, .backslash, .stringInterpolationAnchor, .stringQuote, .multilineStringQuote, .dollarIdentifier, .contextualKeyword, .unknown:
            return .invariable
        }
    }

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

    internal var identifierText: String? {
        switch tokenKind {
        case .identifier(let text):
            return text
        default:
            return nil
        }
    }

    internal var identifierOrOperatorText: String? {
        if let identifier = identifierText {
            return identifier
        } else {
            switch tokenKind {
            case .prefixOperator(let text), .postfixOperator(let text), .spacedBinaryOperator(let text), .unspacedBinaryOperator(let text):
                return text
            default:
                return nil // @exempt(from: tests) Never nil for valid source.
            }
        }
    }
}
