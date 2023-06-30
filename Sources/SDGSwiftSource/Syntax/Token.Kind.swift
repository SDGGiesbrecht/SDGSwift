/*
 Token.Kind.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

  import SwiftSyntax

extension Token {

  /// Enumerates the kinds of tokens.
  public enum Kind: Equatable {

    // MARK: - Cases

      /// A token kind from SwiftSyntax.
      case swiftSyntax(TokenKind)

    /// Whitespace; a sequence of spaces (U+0020) or similar ASCII controls.
    case whitespace(String)
    /// Vertical whitespace; line breaks (U+000A) or similar ASCII controls.
    case lineBreaks(String)

    /// A pair of slashes delimiting a line comment.
    case lineCommentDelimiter
    /// A slash and an asterisk delimiting the start of a block comment.
    case openingBlockCommentDelimiter
    /// An asterisk and a slash delimiting the end of a block comment.
    case closingBlockCommentDelimiter
    /// Raw text in a comment.
    case commentText(String)
    /// A URL in a comment.
    case commentURL(String)
    /// A source heading delimiter.
    case mark(String)
    /// The text of a source heading.
    case sourceHeadingText(String)

    /// A trio of slashes delimiting a line documentation comment.
    case lineDocumentationDelimiter

    /// A slash and two asterisks delimiting the start of a block comment.
    case openingBlockDocumentationDelimiter

    /// An asterisk and a slash delimiting the end of a block comment.
    case closingBlockDocumentationDelimiter

    /// Documentation text.
    case documentationText(String)

    /// A Markdown delimiter for a bullet.
    case bullet(String)

    /// A Markdown code delimiter.
    case codeDelimiter(String)

    /// A language identifier for a Markdown code block.
    case language(String)

    /// Source code.
    case source(String)

    /// A Markdown delimiter for a heading.
    case headingDelimiter(String)

    /// A Markdown delimiter for an asterism.
    case asterism(String)

    /// A Markdown delimiter for applying an emphatic font.
    case emphasisDelimiter(String)

    /// A Markdown delimiter for applying a strong font.
    case strengthDelimiter(String)

    /// An opening Markdown link delimiter.
    case openingLinkContentDelimiter

    /// A closing Markdown link delimiter.
    case closingLinkContentDelimiter

    /// An opening Markdown link delimiter.
    case openingLinkTargetDelimiter

    /// A closing Markdown link delimiter.
    case closingLinkTargetDelimiter

    /// The URL of a Markdown link.
    case linkURL(String)

    /// A Markdown image delimiter.
    case imageDelimiter

    /// A Markdown delimiter for a quotation.
    case quotationDelimiter

    /// A documentation callout.
    case callout(String)

    /// A parameter name used with the `Parameter` callout.
    case calloutParameter(String)

    /// A colon used in a documenation callout.
    case calloutColon

    /// A Markdown line break (two trailing spaces).
    case markdownLineBreak

    /// An incomplete fragment of a token.
    case fragment(String)

    /// A script shebang.
    case shebang(String)

    /// The textual representation of this token kind.
    public var text: String {
      switch self {
        case .swiftSyntax(let swiftSyntax):
          return TokenSyntax(swiftSyntax, presence: .present).text
      case .lineCommentDelimiter:
        return "//"
      case .openingBlockCommentDelimiter:
        return "/*"
      case .closingBlockCommentDelimiter:
        return "*/"
      case .lineDocumentationDelimiter:
        return "///"
      case .openingBlockDocumentationDelimiter:
        return "/*\u{2A}"
      case .closingBlockDocumentationDelimiter:
        return "*/"
      case .openingLinkContentDelimiter:
        return "["
      case .closingLinkContentDelimiter:
        return "]"
      case .openingLinkTargetDelimiter:
        return "("
      case .closingLinkTargetDelimiter:
        return ")"
      case .imageDelimiter:
        return "!"
      case .quotationDelimiter:
        return ">"
      case .calloutColon:
        return ":"
      case .markdownLineBreak:
        return "  "
      case .whitespace(let text),
        .lineBreaks(let text),
        .commentText(let text),
        .commentURL(let text),
        .mark(let text),
        .sourceHeadingText(let text),
        .documentationText(let text),
        .bullet(let text),
        .codeDelimiter(let text),
        .language(let text),
        .source(let text),
        .headingDelimiter(let text),
        .asterism(let text),
        .emphasisDelimiter(let text),
        .strengthDelimiter(let text),
        .linkURL(let text),
        .callout(let text),
        .calloutParameter(let text),
        .fragment(let text),
        .shebang(let text):
        return text
      }
    }

    // @documentation(SDGSwiftSource.TokenSyntax.textFreedom)
    /// The amount of freedom avialable to the token’s text.
    ///
    /// - Parameters:
    ///   - localAncestors: The token’s local ancestors. See `ScanContext.localAncestors` for more details.
    public func textFreedom(localAncestors: [ParentRelationship]) -> TextFreedom {
      switch self {
        case .swiftSyntax(let kind):
          switch kind {
          case .eof, .associatedtypeKeyword, .classKeyword, .deinitKeyword, .enumKeyword,
            .extensionKeyword, .funcKeyword, .importKeyword, .initKeyword, .inoutKeyword,
            .letKeyword,
            .operatorKeyword, .precedencegroupKeyword, .protocolKeyword, .structKeyword,
            .subscriptKeyword, .typealiasKeyword, .varKeyword, .fileprivateKeyword,
            .internalKeyword,
            .privateKeyword, .publicKeyword, .staticKeyword, .deferKeyword, .ifKeyword,
            .guardKeyword,
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
            .poundColorLiteralKeyword, .poundHasSymbolKeyword, .unknown, .dollarIdentifier,
            .contextualKeyword, .rawStringDelimiter, .stringInterpolationAnchor, .yield:
            return .invariable
          case .integerLiteral, .floatingLiteral, .stringLiteral, .regexLiteral, .stringSegment:
            return .arbitrary
          case .identifier, .unspacedBinaryOperator, .spacedBinaryOperator, .postfixOperator,
            .prefixOperator:
            if let syntaxNode = localAncestors.last?.node as? SwiftSyntaxNode,
              let token = syntaxNode.swiftSyntaxNode.as(TokenSyntax.self),
              let parent = token.parent
            {
              if let enumerationCaseElement = parent.as(EnumCaseElementSyntax.self),
                enumerationCaseElement.identifier == token
              {
                // Enumeration case declaration.
                return .arbitrary
              }
              if let identifierPattern = parent.as(IdentifierPatternSyntax.self),
                identifierPattern.identifier == token
              {
                // Variable declaration.
                return .arbitrary
              }
              if let functionParameter = parent.as(FunctionParameterSyntax.self),
                functionParameter.firstName == token ∨ functionParameter.secondName == token
              {
                // Function parameter declaration.
                return .arbitrary
              }
              if let genericParameter = parent.as(GenericParameterSyntax.self),
                genericParameter.name == token
              {
                // Generic member type declaration.
                return .arbitrary
              }

              if let attribute = parent.as(AttributeSyntax.self),
                attribute.attributeName == token
              {
                return .invariable
              }
              if let accessPath = parent.as(AccessPathComponentSyntax.self),
                accessPath.name == token
              {
                // Import statement.
                return .invariable
              }
              if token.isInIfConfigurationCondition() {
                return .invariable
              }

              if parent.isProtocol(DeclSyntaxProtocol.self) == true {
                // Declaration.
                return .arbitrary
              }
            }
            return .aliasable
          }
      case .whitespace, .commentText, .sourceHeadingText, .documentationText:
        return .arbitrary
      case .lineBreaks, .lineCommentDelimiter, .openingBlockCommentDelimiter,
        .closingBlockCommentDelimiter, .commentURL, .mark, .lineDocumentationDelimiter,
        .openingBlockDocumentationDelimiter, .closingBlockDocumentationDelimiter, .bullet,
        .codeDelimiter, .language, .source, .headingDelimiter, .asterism, .emphasisDelimiter,
        .strengthDelimiter, .openingLinkContentDelimiter, .closingLinkContentDelimiter,
        .openingLinkTargetDelimiter, .closingLinkTargetDelimiter, .linkURL, .imageDelimiter,
        .quotationDelimiter, .callout, .calloutParameter, .calloutColon, .markdownLineBreak,
        .fragment, .shebang:
        return .invariable
      }
    }
  }
}
