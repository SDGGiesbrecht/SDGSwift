/*
 TokenSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SDGLogic
  import SDGMathematics
  import SDGCollections

  import SwiftSyntax

  extension TokenSyntax {

    // MARK: - Properties

    /// The extended syntax of the token.
    public var extended: ExtendedSyntax? {
      if case .stringLiteral(let source) = tokenKind {
        let result = StringLiteralSyntax(source: source)
        result.determinePositions()
        return result
      } else {
        return nil
      }
    }

    // @documentation(SDGSwiftSource.TokenSyntax.textFreedom)
    /// The amount of freedom avialable to the token’s text.
    public var textFreedom: TextFreedom {
      switch tokenKind {
      case .identifier, .unspacedBinaryOperator, .spacedBinaryOperator, .prefixOperator,
        .postfixOperator:
        if let parent = self.parent {
          if let enumerationCaseElement = parent.as(EnumCaseElementSyntax.self),
            enumerationCaseElement.identifier == self
          {
            // Enumeration case declaration.
            return .arbitrary
          }
          if let identifierPattern = parent.as(IdentifierPatternSyntax.self),
            identifierPattern.identifier == self
          {
            // Variable declaration.
            return .arbitrary
          }
          if let functionParameter = parent.as(FunctionParameterSyntax.self),
            functionParameter.firstName == self ∨ functionParameter.secondName == self
          {
            // Function parameter declaration.
            return .arbitrary
          }
          if let genericParameter = parent.as(GenericParameterSyntax.self),
            genericParameter.name == self
          {
            // Generic member type declaration.
            return .arbitrary
          }

          if let attribute = parent.as(AttributeSyntax.self),
            attribute.attributeName == self
          {
            return .invariable
          }
          if let declarationModifier = parent.as(DeclModifierSyntax.self),
            declarationModifier.name == self
          {
            // “open”, “mutating”, etc.
            return .invariable
          }
          if let accessPath = parent.as(AccessPathComponentSyntax.self),
            accessPath.name == self
          {
            // Import statement.
            return .invariable
          }
          if isInIfConfigurationCondition() {
            return .invariable
          }

          if parent.isProtocol(DeclSyntaxProtocol.self) == true {
            /// Declaration.
            return .arbitrary
          }
          if let argument = parent.as(TupleExprElementSyntax.self),
            let argumentList = argument.parent?.as(TupleExprElementListSyntax.self),
            argumentList.parent?.is(FunctionCallExprSyntax.self) == true,
            argument.label == self
          {
            return .aliasable
          }
        }

        if text == "init" {
          return .invariable
        }
        return .aliasable
      case .stringSegment, .integerLiteral, .floatingLiteral, .stringLiteral, .regexLiteral:
        return .arbitrary
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
        .backslash, .stringInterpolationAnchor, .stringQuote, .multilineStringQuote,
        .dollarIdentifier, .contextualKeyword, .unknown, .pound, .backtick, .poundAssertKeyword,
        .poundWarningKeyword, .poundErrorKeyword, .yield, .ellipsis, .singleQuote,
        .rawStringDelimiter, .poundFileIDKeyword, .poundUnavailableKeyword:
        return .invariable
      }
    }

    private func isInIfConfigurationCondition() -> Bool {
      var previousAncestor: Syntax = Syntax(self)
      for ancestor in ancestors() {
        defer { previousAncestor = ancestor }
        if let ifConfigurationClause = ancestor.as(IfConfigClauseSyntax.self),
          let condition = Syntax(ifConfigurationClause.condition),
          condition == previousAncestor
        {
          return true
        }
      }
      return false
    }

    // MARK: - Syntax Tree

    /// Returns the first trivia piece preceding the token.
    ///
    /// This searches through the token’s own leading trivia and into the previous token’s trailing trivia.
    public func firstPrecedingTrivia() -> TriviaPiece? {
      return leadingTrivia.last() ?? previousToken()?.trailingTrivia.last()
    }

    /// Returns the first trivia piece following the token.
    ///
    /// This searches through the token’s own trailing trivia and into the following token’s leading trivia.
    public func firstFollowingTrivia() -> TriviaPiece? {
      return trailingTrivia.first ?? nextToken()?.leadingTrivia.first
    }

    // @documentation(SDGSwiftSource.TokenSyntax.previousToken())
    /// Returns the previous token.
    public func previousToken() -> TokenSyntax? {
      func previousSibling(of relationship: (parent: Syntax, index: Int)) -> Syntax? {
        var result: Syntax?
        for sibling in relationship.parent.children
        where sibling.indexInParent < relationship.index ∧ sibling.firstToken() ≠ nil {
          result = sibling
        }
        return result
      }

      let sharedAncestor = ancestorRelationships().first(where: { relationship in
        if previousSibling(of: relationship) ≠ nil {
          return true
        }
        return false
      })

      return sharedAncestor.flatMap({ previousSibling(of: $0) })?.lastToken()
    }

    // @documentation(SDGSwiftSource.TokenSyntax.nextToken())
    /// Returns the next token.
    public func nextToken() -> TokenSyntax? {
      func nextSibling(of relationship: (parent: Syntax, index: Int)) -> Syntax? {
        for sibling in relationship.parent.children
        where sibling.indexInParent > relationship.index ∧ sibling.firstToken() ≠ nil {
          return sibling
        }
        return nil
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

      case .associatedtypeKeyword, .classKeyword, .deinitKeyword, .enumKeyword, .extensionKeyword,
        .funcKeyword, .importKeyword, .initKeyword, .inoutKeyword, .letKeyword, .operatorKeyword,
        .precedencegroupKeyword, .protocolKeyword, .structKeyword, .subscriptKeyword,
        .typealiasKeyword, .varKeyword, .fileprivateKeyword, .internalKeyword, .privateKeyword,
        .publicKeyword, .staticKeyword, .deferKeyword, .ifKeyword, .guardKeyword, .doKeyword,
        .repeatKeyword, .elseKeyword, .forKeyword, .inKeyword, .whileKeyword, .returnKeyword,
        .breakKeyword, .continueKeyword, .fallthroughKeyword, .switchKeyword, .caseKeyword,
        .defaultKeyword, .whereKeyword, .catchKeyword, .asKeyword, .anyKeyword, .falseKeyword,
        .isKeyword, .nilKeyword, .rethrowsKeyword, .superKeyword, .selfKeyword, .capitalSelfKeyword,
        .throwKeyword, .trueKeyword, .tryKeyword, .throwsKeyword, .__file__Keyword,
        .__line__Keyword, .__column__Keyword, .__function__Keyword, .__dso_handle__Keyword,
        .wildcardKeyword, .poundAvailableKeyword, .poundSourceLocationKeyword, .poundFileKeyword,
        .poundFilePathKeyword, .poundLineKeyword, .poundColumnKeyword, .poundDsohandleKeyword,
        .poundFunctionKeyword, .poundSelectorKeyword, .poundKeyPathKeyword,
        .poundColorLiteralKeyword, .poundFileLiteralKeyword, .poundImageLiteralKeyword, .atSign,
        .contextualKeyword, .poundAssertKeyword, .yield, .poundFileIDKeyword,
        .poundUnavailableKeyword:
        return "keyword"

      case .poundEndifKeyword, .poundElseKeyword, .poundElseifKeyword, .poundIfKeyword, .pound,
        .poundWarningKeyword, .poundErrorKeyword:
        return "compilation‐condition"

      case .arrow, .colon, .semicolon, .comma, .period, .equal, .prefixPeriod, .leftParen,
        .rightParen, .leftBrace, .rightBrace, .leftSquareBracket, .rightSquareBracket, .leftAngle,
        .rightAngle, .prefixAmpersand, .postfixQuestionMark, .infixQuestionMark, .exclamationMark,
        .backslash, .stringInterpolationAnchor, .dollarIdentifier, .backtick, .ellipsis:
        return "punctuation"

      case .identifier(let name), .unspacedBinaryOperator(let name),
        .spacedBinaryOperator(let name),
        .prefixOperator(let name), .postfixOperator(let name):

        if isInIfConfigurationCondition() {
          return "compilation‐condition"
        }

        if name == "get" ∨ name == "set" {
          return "keyword"
        }
        if let attribute = parent?.as(AttributeSyntax.self),
          attribute.attributeName == self
        {
          // @available, @objc, etc.
          return "keyword"
        }
        if let declarationModifier = parent?.as(DeclModifierSyntax.self),
          declarationModifier.name == self
        {
          // “open”, “mutating”, etc.
          return "keyword"
        }

        if let parameter = parent?.as(FunctionParameterSyntax.self),
          parameter.firstName == self
        {
          return "internal identifier"
        }

        if name ∈ internalIdentifiers {
          return "internal identifier"
        } else {
          return "external identifier"
        }

      case .integerLiteral, .floatingLiteral:
        return "number"

      case .stringQuote, .multilineStringQuote, .singleQuote, .rawStringDelimiter:
        return "string‐punctuation"

      case .stringSegment:
        return "text"

      case .stringLiteral, .regexLiteral:  // @exempt(from: tests) Disected elsewhere.
        return nil
      }
    }

    // MARK: - Short Cuts

    internal var isOperator: Bool {
      switch tokenKind {
      case .prefixOperator, .postfixOperator, .spacedBinaryOperator, .unspacedBinaryOperator:
        return true
      default:
        return false
      }
    }

    // MARK: - API

    internal func generallyNormalizedAndMissingInsteadOfNil(
      leadingTrivia: Trivia = [],
      trailingTrivia: Trivia = []
    ) -> TokenSyntax {
      return SyntaxFactory.makeToken(
        tokenKind.normalized(),
        leadingTrivia: leadingTrivia,
        trailingTrivia: trailingTrivia
      )
    }

    internal func generallyNormalized(
      leadingTrivia: Trivia = [],
      trailingTrivia: Trivia = []
    ) -> TokenSyntax? {
      if ¬isPresent {
        return nil
      }
      return generallyNormalizedAndMissingInsteadOfNil(
        leadingTrivia: leadingTrivia,
        trailingTrivia: trailingTrivia
      )
    }
  }
#endif
