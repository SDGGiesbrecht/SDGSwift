/*
 UnknownHighlighter.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections

  import SwiftSyntax

import SDGSwiftSource

struct UnknownHighlighter: Highlighter {

  // MARK: - Exceptions

  static let expectedParserRejections: Set<String> = [
    /*This cannot compile*/"."
  ]

  static let expectedSource: Set<String> = [
    "func doSomething()",
    "This is unidentified.",
  ]

  // MARK: - Highlighter

  func shouldHighlight(_ token: Token, context: ScanContext) -> Bool {
    switch token.kind {
      case .swiftSyntax(let swiftSyntax):
        switch swiftSyntax {
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
          .wildcardKeyword, .leftParen, .rightParen, .leftBrace, .rightBrace, .leftSquareBracket,
          .rightSquareBracket, .leftAngle, .rightAngle, .period, .prefixPeriod, .comma, .ellipsis,
          .colon, .semicolon, .equal, .atSign, .pound, .prefixAmpersand, .arrow, .backtick,
          .backslash, .exclamationMark, .postfixQuestionMark, .infixQuestionMark, .stringQuote,
          .singleQuote, .multilineStringQuote, .poundKeyPathKeyword, .poundLineKeyword,
          .poundSelectorKeyword, .poundFileKeyword, .poundFileIDKeyword, .poundFilePathKeyword,
          .poundColumnKeyword, .poundFunctionKeyword, .poundDsohandleKeyword, .poundAssertKeyword,
          .poundSourceLocationKeyword, .poundWarningKeyword, .poundErrorKeyword, .poundIfKeyword,
          .poundElseKeyword, .poundElseifKeyword, .poundEndifKeyword, .poundAvailableKeyword,
          .poundUnavailableKeyword, .poundFileLiteralKeyword, .poundImageLiteralKeyword,
          .poundColorLiteralKeyword, .poundHasSymbolKeyword, .integerLiteral, .floatingLiteral,
          .stringLiteral, .regexLiteral, .identifier, .unspacedBinaryOperator,
          .spacedBinaryOperator,
          .postfixOperator, .prefixOperator, .dollarIdentifier, .contextualKeyword,
          .rawStringDelimiter, .stringSegment, .stringInterpolationAnchor, .yield:
          return false
        case .unknown:
          return token.text() ∉ UnknownHighlighter.expectedParserRejections
        }
    case .whitespace, .lineBreaks, .lineCommentDelimiter, .openingBlockCommentDelimiter,
      .closingBlockCommentDelimiter, .commentText, .commentURL, .mark, .sourceHeadingText,
      .lineDocumentationDelimiter, .openingBlockDocumentationDelimiter,
      .closingBlockDocumentationDelimiter, .documentationText, .bullet, .codeDelimiter, .language,
      .headingDelimiter, .asterism, .strengthDelimiter, .emphasisDelimiter,
      .openingLinkContentDelimiter, .closingLinkContentDelimiter, .openingLinkTargetDelimiter,
      .closingLinkTargetDelimiter, .linkURL, .imageDelimiter, .quotationDelimiter, .callout,
      .calloutParameter, .calloutColon,
      .markdownLineBreak, .shebang:
      return false
    case .source:
      return token.text() ∉ UnknownHighlighter.expectedSource
    case .fragment:
      return true
    }
  }

  var highlighted: String = ""

  // MARK: - SyntaxScanner

  var cache = ParserCache()
}
