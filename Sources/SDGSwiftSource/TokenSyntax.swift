/*
 TokenSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

extension TokenSyntax {

    // MARK: - Properties

    public var textFreedom: SyntaxElement.TextFreedom {
        switch tokenKind {
        case .identifier:
            if text == "element" {
                print(parent?.isDecl)
                print(parent)
            }
            if parent?.isDecl == true {
                return .arbitrary
            } else if indexInParent > 0,
                (parent!.child(at: indexInParent − 1) as? TokenSyntax)?.tokenKind == .forKeyword {
                // Declaration of loop variable.
                return .arbitrary
            } else {
                return .aliasable
            }
        case .unspacedBinaryOperator, .spacedBinaryOperator, .prefixOperator, .postfixOperator, .integerLiteral, .floatingLiteral, .stringLiteral:
            return .arbitrary
        case .unknown, .eof, .associatedtypeKeyword, .classKeyword, .deinitKeyword, .enumKeyword, .extensionKeyword, .funcKeyword, .importKeyword, .initKeyword, .inoutKeyword, .letKeyword, .operatorKeyword, .precedencegroupKeyword, .protocolKeyword, .structKeyword, .subscriptKeyword, .typealiasKeyword, .varKeyword, .fileprivateKeyword, .internalKeyword, .privateKeyword, .publicKeyword, .staticKeyword, .deferKeyword, .ifKeyword, .guardKeyword, .doKeyword, .repeatKeyword, .elseKeyword, .forKeyword, .inKeyword, .whileKeyword, .returnKeyword, .breakKeyword, .continueKeyword, .fallthroughKeyword, .switchKeyword, .caseKeyword, .defaultKeyword, .whereKeyword, .catchKeyword, .asKeyword, .anyKeyword, .falseKeyword, .isKeyword, .nilKeyword, .rethrowsKeyword, .superKeyword, .selfKeyword, .capitalSelfKeyword, .throwKeyword, .trueKeyword, .tryKeyword, .throwsKeyword, .__file__Keyword, .__line__Keyword, .__column__Keyword, .__function__Keyword, .__dso_handle__Keyword, .wildcardKeyword, .poundAvailableKeyword, .poundEndifKeyword, .poundElseKeyword, .poundElseifKeyword, .poundIfKeyword, .poundSourceLocationKeyword, .poundFileKeyword, .poundLineKeyword, .poundColumnKeyword, .poundFunctionKeyword, .arrow, .atSign, .colon, .semicolon, .comma, .period, .equal, .prefixPeriod, .leftParen, .rightParen, .leftBrace, .rightBrace, .leftSquareBracket, .rightSquareBracket, .leftAngle, .rightAngle, .ampersand, .postfixQuestionMark, .infixQuestionMark, .exclamationMark, .dollarIdentifier:
            return .invariable
        }
    }
}
