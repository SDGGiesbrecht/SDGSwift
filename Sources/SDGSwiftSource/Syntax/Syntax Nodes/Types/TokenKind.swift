/*
 TokenKind.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SwiftSyntax

  extension TokenKind {

    internal func normalized() -> TokenKind {
      switch self {
      case .eof, .associatedtypeKeyword, .classKeyword, .deinitKeyword, .enumKeyword,
        .extensionKeyword, .funcKeyword, .importKeyword, .initKeyword, .inoutKeyword, .letKeyword,
        .operatorKeyword, .precedencegroupKeyword, .protocolKeyword, .structKeyword,
        .subscriptKeyword, .typealiasKeyword, .varKeyword, .fileprivateKeyword, .internalKeyword,
        .privateKeyword, .publicKeyword, .staticKeyword, .deferKeyword, .ifKeyword, .guardKeyword,
        .doKeyword, .repeatKeyword, .elseKeyword, .forKeyword, .inKeyword, .whileKeyword,
        .returnKeyword, .breakKeyword, .continueKeyword, .fallthroughKeyword, .switchKeyword,
        .caseKeyword, .defaultKeyword, .whereKeyword, .catchKeyword, .asKeyword, .anyKeyword,
        .falseKeyword, .isKeyword, .nilKeyword, .rethrowsKeyword, .superKeyword, .selfKeyword,
        .capitalSelfKeyword, .throwKeyword, .trueKeyword, .tryKeyword, .throwsKeyword,
        .__file__Keyword, .__line__Keyword, .__column__Keyword, .__function__Keyword,
        .__dso_handle__Keyword, .wildcardKeyword, .poundAvailableKeyword, .poundEndifKeyword,
        .poundElseKeyword, .poundElseifKeyword, .poundIfKeyword, .poundSourceLocationKeyword,
        .poundFileKeyword, .poundFilePathKeyword, .poundLineKeyword, .poundColumnKeyword,
        .poundDsohandleKeyword, .poundFunctionKeyword, .poundSelectorKeyword, .poundKeyPathKeyword,
        .poundColorLiteralKeyword, .poundFileLiteralKeyword, .poundImageLiteralKeyword, .arrow,
        .atSign, .colon, .semicolon, .comma, .period, .equal, .prefixPeriod, .leftParen,
        .rightParen, .leftBrace, .rightBrace, .leftSquareBracket, .rightSquareBracket, .leftAngle,
        .rightAngle, .prefixAmpersand, .postfixQuestionMark, .infixQuestionMark, .exclamationMark,
        .backslash, .stringInterpolationAnchor, .stringQuote, .multilineStringQuote, .pound,
        .backtick, .poundAssertKeyword, .poundWarningKeyword, .poundErrorKeyword, .yield, .ellipsis,
        .singleQuote, .rawStringDelimiter, .poundFileIDKeyword:
        return self
      case .stringSegment(let text):
        return .stringSegment(text.decomposedStringWithCanonicalMapping)
      case .identifier(let text):
        return .identifier(text.decomposedStringWithCanonicalMapping)
      case .dollarIdentifier(let text):
        return .dollarIdentifier(text.decomposedStringWithCanonicalMapping)
      case .unspacedBinaryOperator(let text):
        return .unspacedBinaryOperator(text.decomposedStringWithCanonicalMapping)
      case .spacedBinaryOperator(let text):
        return .spacedBinaryOperator(text.decomposedStringWithCanonicalMapping)
      case .prefixOperator(let text):
        return .prefixOperator(text.decomposedStringWithCanonicalMapping)
      case .postfixOperator(let text):
        return .postfixOperator(text.decomposedStringWithCanonicalMapping)
      case .integerLiteral(let text):
        return .integerLiteral(text.decomposedStringWithCanonicalMapping)
      case .floatingLiteral(let text):
        return .floatingLiteral(text.decomposedStringWithCanonicalMapping)
      case .stringLiteral(let text):
        return .stringLiteral(text.decomposedStringWithCanonicalMapping)
      case .contextualKeyword(let text):
        return .contextualKeyword(text.decomposedStringWithCanonicalMapping)
      case .unknown(let text):
        return .unknown(text.decomposedStringWithCanonicalMapping)
      }
    }

    internal var shouldBeCrossLinked: Bool {
      switch self {
      case .eof, .associatedtypeKeyword, .classKeyword, .deinitKeyword, .enumKeyword,
        .extensionKeyword, .funcKeyword, .importKeyword, .initKeyword, .inoutKeyword, .letKeyword,
        .operatorKeyword, .precedencegroupKeyword, .protocolKeyword, .structKeyword,
        .subscriptKeyword, .typealiasKeyword, .varKeyword, .fileprivateKeyword, .internalKeyword,
        .privateKeyword, .publicKeyword, .staticKeyword, .deferKeyword, .ifKeyword, .guardKeyword,
        .doKeyword, .repeatKeyword, .elseKeyword, .forKeyword, .inKeyword, .whileKeyword,
        .returnKeyword, .breakKeyword, .continueKeyword, .fallthroughKeyword, .switchKeyword,
        .caseKeyword, .defaultKeyword, .whereKeyword, .catchKeyword, .throwKeyword, .asKeyword,
        .anyKeyword, .falseKeyword, .isKeyword, .nilKeyword, .rethrowsKeyword, .superKeyword,
        .selfKeyword, .capitalSelfKeyword, .trueKeyword, .tryKeyword, .throwsKeyword,
        .__file__Keyword, .__line__Keyword, .__column__Keyword, .__function__Keyword,
        .__dso_handle__Keyword, .wildcardKeyword, .leftParen, .rightParen, .leftBrace, .rightBrace,
        .leftSquareBracket, .rightSquareBracket, .leftAngle, .rightAngle, .period, .prefixPeriod,
        .comma, .ellipsis, .colon, .semicolon, .equal, .atSign, .pound, .prefixAmpersand, .arrow,
        .backtick, .backslash, .exclamationMark, .postfixQuestionMark, .infixQuestionMark,
        .stringQuote, .singleQuote, .multilineStringQuote, .poundKeyPathKeyword, .poundLineKeyword,
        .poundSelectorKeyword, .poundFileKeyword, .poundFilePathKeyword, .poundColumnKeyword,
        .poundFunctionKeyword, .poundDsohandleKeyword, .poundAssertKeyword,
        .poundSourceLocationKeyword, .poundWarningKeyword, .poundErrorKeyword, .poundIfKeyword,
        .poundElseKeyword, .poundElseifKeyword, .poundEndifKeyword, .poundAvailableKeyword,
        .poundFileLiteralKeyword, .poundImageLiteralKeyword, .poundColorLiteralKeyword,
        .integerLiteral, .floatingLiteral, .stringLiteral, .unknown, .dollarIdentifier,
        .contextualKeyword, .rawStringDelimiter, .stringSegment, .stringInterpolationAnchor, .yield,
        .poundFileIDKeyword:
        return false
      case .identifier, .unspacedBinaryOperator, .spacedBinaryOperator, .postfixOperator,
        .prefixOperator:
        return true
      }
    }

    internal var cssName: String {
      return "\(self)".truncated(before: "(")
    }
  }
#endif
