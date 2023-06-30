/*
 Syntax Highlighting.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Can docc do this? See also CSS resource.)

import SDGLogic
import SDGCollections
import SDGText

import SwiftSyntax

import SDGHTML

/// A namespace for syntax highlighting.
public enum SyntaxHighlighter {

  /// The CSS to use with syntax‐highlighted HTML.
  public static var css: StrictString {
    return StrictString(Resources.syntaxHighlighting).dropping(through: "*/\n\n")
  }

  internal static func frame(
    highlightedSyntax: String,
    inline: Bool
  ) -> String {
    var result = "<code class=\u{22}swift"
    if ¬inline {
      result += " blockquote"
    }
    result += "\u{22}>"
    result += highlightedSyntax
    result += "</code>"
    return result
  }
}

extension SyntaxNode {

  /// Returns a syntax‐highlighted HTML representation of the source.
  ///
  /// The resulting HTML depends on the CSS provided by `SyntaxHighlighter.css`.
  ///
  /// - Parameters:
  ///     - inline: Pass `true` to generate inline HTML instead of a separate block section.
  ///     - internalIdentifiers: Optional. A set of identifiers to consider as belonging to the module.
  ///     - symbolLinks: Optional. A dictionary of target links for cross‐linking symbols. The values will be inserted as‐is in `href` attributes. URLs must already be properly encoded for this context before passing them.
  public func syntaxHighlightedHTML(
    inline: Bool,
    internalIdentifiers: Set<String> = [],
    symbolLinks: [String: String] = [:]
  ) -> String {
    var cache = ParserCache()
    return SyntaxHighlighter.frame(
      highlightedSyntax: _nestedSyntaxHighlightedHTML(
        internalIdentifiers: internalIdentifiers,
        symbolLinks: symbolLinks,
        localAncestors: [],
        parserCache: &cache
      ),
      inline: inline
    )
  }

  public func _localAncestorsOfChild(
    at index: Int,
    nodeLocalAncestors: [ParentRelationship],
    cache: inout ParserCache
  ) -> [ParentRelationship] {
    return nodeLocalAncestors.appending(ParentRelationship(node: self, childIndex: index))
  }

  internal func genericNestedSyntaxHighlightedHTML(
    internalIdentifiers: Set<String>,
    symbolLinks: [String: String],
    localAncestors: [ParentRelationship],
    parserCache: inout ParserCache
  ) -> String {
    return children(cache: &parserCache).enumerated().map({ index, child in
      child._nestedSyntaxHighlightedHTML(
        internalIdentifiers: internalIdentifiers,
        symbolLinks: symbolLinks,
        localAncestors: _localAncestorsOfChild(at: index, nodeLocalAncestors: localAncestors, cache: &parserCache),
        parserCache: &parserCache
      )
    }).joined()
  }

  public func _nestedSyntaxHighlightedHTML(
    internalIdentifiers: Set<String>,
    symbolLinks: [String: String],
    localAncestors: [ParentRelationship],
    parserCache: inout ParserCache
  ) -> String {
    return genericNestedSyntaxHighlightedHTML(
      internalIdentifiers: internalIdentifiers,
      symbolLinks: symbolLinks,
      localAncestors: localAncestors,
      parserCache: &parserCache
    )
  }
}

extension Token {
  public func _nestedSyntaxHighlightedHTML(
    internalIdentifiers: Set<String>,
    symbolLinks: [String: String],
    localAncestors: [ParentRelationship],
    parserCache: inout ParserCache
  ) -> String {
    let text = self.text()
    var source = HTML.escapeTextForCharacterData(text)
    switch kind {
    case .commentURL, .linkURL:
      let target = HTML.escapeTextForAttribute(text)
      return "<a href=\u{22}\(target)\u{22} class=\u{22}url\u{22}>\(source)</a>"
    case .source:
      source.prepend(contentsOf: "<span class=\u{22}code\u{22}>")
      source.append(contentsOf: "</span>")
      return source
    default:
      var classes: [String] = []
      if case .swiftSyntax(let syntaxKind) = kind,
        syntaxKind ≠ .eof,
        (localAncestors.last?.node as? SwiftSyntaxNode)?.swiftSyntaxNode.is(TokenSyntax.self) == true {
        // ↑ The tagging for TokenSyntax is applied to the Token instead in order not to include the trivia.
        classes.append(contentsOf: ["TokenSyntax", syntaxKind.cssName])
      }
      if let `class` = syntaxHighlightingClass(
        internalIdentifiers: internalIdentifiers,
        localAncestors: localAncestors
      ) {
        classes.prepend(`class`)
      }
      if ¬classes.isEmpty {
        source.prepend(contentsOf: "<span class=\u{22}\(classes.joined(separator: " "))\u{22}>")
        source.append(contentsOf: "</span>")
      }

      if case .swiftSyntax(let syntaxKind) = kind,
        syntaxKind.shouldBeCrossLinked,
        let url = symbolLinks[text]
      {
        source.prepend(contentsOf: "<a href=\u{22}\(HTML.escapeTextForAttribute(url))\u{22}>")
        source.append(contentsOf: "</a>")
      }

      return source
    }
  }
  fileprivate func syntaxHighlightingClass(
    internalIdentifiers: Set<String>,
    localAncestors: [ParentRelationship]
  ) -> String? {
    switch kind {
    case .swiftSyntax(let syntax):
      switch syntax {
      case .eof, .unknown:
        return nil
      case .associatedtypeKeyword, .classKeyword, .deinitKeyword, .enumKeyword, .extensionKeyword, .funcKeyword, .importKeyword, .initKeyword, .inoutKeyword, .letKeyword, .operatorKeyword, .precedencegroupKeyword, .protocolKeyword, .structKeyword, .subscriptKeyword, .typealiasKeyword, .varKeyword, .fileprivateKeyword, .internalKeyword, .privateKeyword, .publicKeyword, .staticKeyword, .deferKeyword, .ifKeyword, .guardKeyword, .doKeyword, .repeatKeyword, .elseKeyword, .forKeyword, .inKeyword, .whileKeyword, .returnKeyword, .breakKeyword, .continueKeyword, .fallthroughKeyword, .switchKeyword, .caseKeyword, .defaultKeyword, .whereKeyword, .catchKeyword, .asKeyword, .anyKeyword, .falseKeyword, .isKeyword, .nilKeyword, .rethrowsKeyword, .superKeyword, .selfKeyword, .capitalSelfKeyword, .throwKeyword, .trueKeyword, .tryKeyword, .throwsKeyword, .wildcardKeyword, .poundAvailableKeyword, .poundSourceLocationKeyword, .poundFileKeyword, .poundFilePathKeyword, .poundLineKeyword, .poundColumnKeyword, .poundDsohandleKeyword, .poundFunctionKeyword, .poundSelectorKeyword, .poundKeyPathKeyword, .poundColorLiteralKeyword, .poundFileLiteralKeyword, .poundImageLiteralKeyword, .atSign, .contextualKeyword, .poundAssertKeyword, .yield, .poundFileIDKeyword, .poundUnavailableKeyword, .poundHasSymbolKeyword:
        return "keyword"
      case .poundEndifKeyword, .poundElseKeyword, .poundElseifKeyword, .poundIfKeyword, .pound, .poundWarningKeyword, .poundErrorKeyword:
        return "compilation‐condition"
      case .arrow, .colon, .semicolon, .comma, .period, .equal, .prefixPeriod, .leftParen, .rightParen, .leftBrace, .rightBrace, .leftSquareBracket, .rightSquareBracket, .leftAngle, .rightAngle, .prefixAmpersand, .postfixQuestionMark, .infixQuestionMark, .exclamationMark, .backslash, .stringInterpolationAnchor, .dollarIdentifier, .backtick, .ellipsis:
        return "punctuation"
      case .identifier(let name), .unspacedBinaryOperator(let name), .spacedBinaryOperator(let name), .prefixOperator(let name), .postfixOperator(let name):

        if let swiftSyntaxToken = localAncestors
          .lazy
          .compactMap({ ($0.node as? SwiftSyntaxNode)?.swiftSyntaxNode.as(TokenSyntax.self) })
          .last {

          if swiftSyntaxToken.isInIfConfigurationCondition() {
            return "compilation‐condition"
          }

          if let parent = swiftSyntaxToken.parent {

            if let attribute = parent.as(AttributeSyntax.self),
               attribute.attributeName == swiftSyntaxToken
            {
              // @available, @objc, etc.
              return "keyword"
            }

            if let parameter = parent.as(FunctionParameterSyntax.self),
               parameter.firstName == swiftSyntaxToken
            {
              return "internal identifier"
            }
          }
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
        return nil  // @exempt(from: tests)
      }
    case .whitespace:
      return nil  // Ignored.
    case .lineBreaks, .commentURL, .source, .linkURL, .markdownLineBreak, .fragment:
      return nil  // Handled elsewhere.
    case .lineCommentDelimiter, .openingBlockCommentDelimiter, .closingBlockCommentDelimiter, .lineDocumentationDelimiter, .openingBlockDocumentationDelimiter, .closingBlockDocumentationDelimiter, .bullet, .codeDelimiter, .headingDelimiter, .asterism, .emphasisDelimiter, .strengthDelimiter, .openingLinkContentDelimiter, .closingLinkContentDelimiter, .openingLinkTargetDelimiter, .closingLinkTargetDelimiter, .imageDelimiter, .quotationDelimiter, .calloutColon:
      return "comment‐punctuation"
    case .commentText, .documentationText:
      return "text"
    case .mark, .callout, .shebang:
      // #workaround(Skipping just for compatibility with legacy specifications.)
      if case .shebang = kind {
        return nil
      }
      return "comment‐keyword"
    case .sourceHeadingText:
      return "source‐heading"
    case .language:
      return "comment‐keyword"
    case .calloutParameter:
      return "internal identifier"
    }
  }
}

extension BlockCommentProtocol {
  public func _nestedSyntaxHighlightedHTML(
    internalIdentifiers: Set<String>,
    symbolLinks: [String: String],
    localAncestors: [ParentRelationship],
    parserCache: inout ParserCache
  ) -> String {
    var source = genericNestedSyntaxHighlightedHTML(
      internalIdentifiers: internalIdentifiers,
      symbolLinks: symbolLinks,
      localAncestors: localAncestors,
      parserCache: &parserCache
    )
    source.prepend(contentsOf: "<span class=\u{22}comment\u{22}>")
    source.append(contentsOf: "</span>")
    return source
  }
}

extension CodeContent {
  public func _nestedSyntaxHighlightedHTML(
    internalIdentifiers: Set<String>,
    symbolLinks: [String: String],
    localAncestors: [ParentRelationship],
    parserCache: inout ParserCache
  ) -> String {
    var source = genericNestedSyntaxHighlightedHTML(
      internalIdentifiers: internalIdentifiers,
      symbolLinks: symbolLinks,
      localAncestors: localAncestors,
      parserCache: &parserCache
    )
    if let selectorLink = symbolLinks[text()] {
      source.prepend(
        contentsOf: "<a href=\u{22}\(HTML.escapeTextForAttribute(selectorLink))\u{22}>"
      )
      source.append(contentsOf: "</a>")
    }
    return source
  }
}

extension EnumCaseDeclSyntax {
  fileprivate func identifierList() -> Set<String> {
    return Set(elements.lazy.map({ $0.identifier.text }))
  }
}

extension Fragment {
  public func _localAncestorsOfChild(
    at index: Int,
    nodeLocalAncestors: [ParentRelationship],
    cache: inout ParserCache) -> [ParentRelationship] {
    return localAncestorsOfChild(at: index, cache: &cache)
  }
}

extension IdentifierPatternSyntax {
  fileprivate var isHidden: Bool {
    let text = identifier.text
    return text.hasPrefix("_") == true
  }
}

extension LineCommentProtocol {
  public func _nestedSyntaxHighlightedHTML(
    internalIdentifiers: Set<String>,
    symbolLinks: [String: String],
    localAncestors: [ParentRelationship],
    parserCache: inout ParserCache
  ) -> String {
    var source = genericNestedSyntaxHighlightedHTML(
      internalIdentifiers: internalIdentifiers,
      symbolLinks: symbolLinks,
      localAncestors: localAncestors,
      parserCache: &parserCache
    )
    source.prepend(contentsOf: "<span class=\u{22}comment\u{22}>")
    source.append(contentsOf: "</span>")
    return source
  }
}

extension PatternSyntax {
  fileprivate func flattenedForAPI() -> [IdentifierPatternSyntax] {
    var list: [IdentifierPatternSyntax] = []
    if let identifier = self.as(IdentifierPatternSyntax.self) {
      list.append(identifier)
    } else if let tuple = self.as(TuplePatternSyntax.self) {
      for element in tuple.elements {
        list.append(contentsOf: element.pattern.flattenedForAPI())
      }
    }
    return list.filter({ ¬$0.isHidden })
  }
}

extension StringLiteral {
  public func _nestedSyntaxHighlightedHTML(
    internalIdentifiers: Set<String>,
    symbolLinks: [String: String],
    localAncestors: [ParentRelationship],
    parserCache: inout ParserCache
  ) -> String {
    var source = genericNestedSyntaxHighlightedHTML(
      internalIdentifiers: internalIdentifiers,
      symbolLinks: symbolLinks,
      localAncestors: localAncestors,
      parserCache: &parserCache
    )
    source.prepend(contentsOf: "<span class=\u{22}string\u{22}>")
    source.append(contentsOf: "</span>")
    // ↓ The tagging for TokenSyntax is applied to the here instead in order not to include the trivia.
    source.prepend(contentsOf: "<span class=\u{22}TokenSyntax stringLiteral\u{22}>")
    source.append(contentsOf: "</span>")
    return source
  }
}

extension SwiftSyntaxNode {
  public func _nestedSyntaxHighlightedHTML(
    internalIdentifiers: Set<String>,
    symbolLinks: [String: String],
    localAncestors: [ParentRelationship],
    parserCache: inout ParserCache
  ) -> String {

      var identifiers = internalIdentifiers

      var identifier: SwiftSyntax.TokenSyntax?
      var variableBindings: Set<String>?
      var parameterClause: ParameterClauseSyntax?
      var genericParameterClause: GenericParameterClauseSyntax?
      if let structure = swiftSyntaxNode.as(StructDeclSyntax.self) {
        identifier = structure.identifier
        genericParameterClause = structure.genericParameterClause
      } else if let `class` = swiftSyntaxNode.as(ClassDeclSyntax.self) {
        identifier = `class`.identifier
        genericParameterClause = `class`.genericParameterClause
      } else if let enumeration = swiftSyntaxNode.as(EnumDeclSyntax.self) {
        identifier = enumeration.identifier
        genericParameterClause = enumeration.genericParameters
      } else if let `protocol` = swiftSyntaxNode.as(ProtocolDeclSyntax.self) {
        identifier = `protocol`.identifier
      } else if let alias = swiftSyntaxNode.as(TypealiasDeclSyntax.self) {
        identifier = alias.identifier
        genericParameterClause = alias.genericParameterClause
      } else if let associated = swiftSyntaxNode.as(AssociatedtypeDeclSyntax.self) {
        identifier = associated.identifier
        genericParameterClause = nil
      } else if let initializer = swiftSyntaxNode.as(InitializerDeclSyntax.self) {
        parameterClause = initializer.signature.input
        genericParameterClause = initializer.genericParameterClause
      } else if let variable = swiftSyntaxNode.as(VariableDeclSyntax.self) {
        variableBindings = variable.identifierList()
      } else if let `case` = swiftSyntaxNode.as(EnumCaseDeclSyntax.self) {
        variableBindings = `case`.identifierList()
      } else if let `subscript` = swiftSyntaxNode.as(SubscriptDeclSyntax.self) {
        parameterClause = `subscript`.indices
        genericParameterClause = `subscript`.genericParameterClause
      } else if let function = swiftSyntaxNode.as(FunctionDeclSyntax.self) {
        identifier = function.identifier
        parameterClause = function.signature.input
        genericParameterClause = function.genericParameterClause
      } else if let `operator` = swiftSyntaxNode.as( OperatorDeclSyntax.self) {
        identifier = `operator`.identifier
      } else if let precedence = swiftSyntaxNode.as(PrecedenceGroupDeclSyntax.self) {
        identifier = precedence.identifier
      }
      if let identifier = identifier {
        identifiers.insert(identifier.text)
      }
      if let bindings = variableBindings {
        identifiers ∪= bindings
      }
      if let clause = parameterClause {
        let parameters = clause.parameterList.lazy.compactMap({ $0.internalName?.text })
        identifiers ∪= Set(parameters)
      }
      if let clause = genericParameterClause {
        let parameters = clause.genericParameterList.lazy.map({ $0.name.text })
        identifiers ∪= Set(parameters)
      }

      var result = genericNestedSyntaxHighlightedHTML(
        internalIdentifiers: identifiers,
        symbolLinks: symbolLinks,
        localAncestors: localAncestors,
        parserCache: &parserCache
      )
    if ¬swiftSyntaxNode.is(TokenSyntax.self) {
      // ↑ The tagging for TokenSyntax is applied to the Token or StringLiteral instead in order not to include the trivia.
      var classes = ["\(swiftSyntaxNode.syntaxNodeType)"]
      if swiftSyntaxNode.is(StringLiteralExprSyntax.self) {
        classes.prepend("string")
      }
      result.prepend(contentsOf: "<span class=\u{22}\(classes.joined(separator: " "))\u{22}>")
      result.append(contentsOf: "</span>")
    }
      return result
    }
}

extension SwiftSyntax.TokenKind {
  fileprivate var shouldBeCrossLinked: Bool {
    switch self {
    case .eof, .associatedtypeKeyword, .classKeyword, .deinitKeyword, .enumKeyword, .extensionKeyword, .funcKeyword, .importKeyword, .initKeyword, .inoutKeyword, .letKeyword, .operatorKeyword, .precedencegroupKeyword, .protocolKeyword, .structKeyword, .subscriptKeyword, .typealiasKeyword, .varKeyword, .fileprivateKeyword, .internalKeyword, .privateKeyword, .publicKeyword, .staticKeyword, .deferKeyword, .ifKeyword, .guardKeyword, .doKeyword, .repeatKeyword, .elseKeyword, .forKeyword, .inKeyword, .whileKeyword, .returnKeyword, .breakKeyword, .continueKeyword, .fallthroughKeyword, .switchKeyword, .caseKeyword, .defaultKeyword, .whereKeyword, .catchKeyword, .throwKeyword, .asKeyword, .anyKeyword, .falseKeyword, .isKeyword, .nilKeyword, .rethrowsKeyword, .superKeyword, .selfKeyword, .capitalSelfKeyword, .trueKeyword, .tryKeyword, .throwsKeyword, .wildcardKeyword, .leftParen, .rightParen, .leftBrace, .rightBrace, .leftSquareBracket, .rightSquareBracket, .leftAngle, .rightAngle, .period, .prefixPeriod, .comma, .ellipsis, .colon, .semicolon, .equal, .atSign, .pound, .prefixAmpersand, .arrow, .backtick, .backslash, .exclamationMark, .postfixQuestionMark, .infixQuestionMark, .stringQuote, .singleQuote, .multilineStringQuote, .poundKeyPathKeyword, .poundLineKeyword, .poundSelectorKeyword, .poundFileKeyword, .poundFilePathKeyword, .poundColumnKeyword, .poundFunctionKeyword, .poundDsohandleKeyword, .poundAssertKeyword, .poundSourceLocationKeyword, .poundWarningKeyword, .poundErrorKeyword, .poundIfKeyword, .poundElseKeyword, .poundElseifKeyword, .poundEndifKeyword, .poundAvailableKeyword, .poundFileLiteralKeyword, .poundImageLiteralKeyword, .poundColorLiteralKeyword, .integerLiteral, .floatingLiteral, .stringLiteral, .unknown, .dollarIdentifier, .contextualKeyword, .rawStringDelimiter, .stringSegment, .stringInterpolationAnchor, .yield, .poundFileIDKeyword, .poundUnavailableKeyword, .regexLiteral, .poundHasSymbolKeyword:
      return false
    case .identifier, .unspacedBinaryOperator, .spacedBinaryOperator, .postfixOperator, .prefixOperator:
      return true
    }
  }
  fileprivate var cssName: String {
    return "\(self)".truncated(before: "(")
  }
}

extension VariableDeclSyntax {
  fileprivate func identifierList() -> Set<String> {
    let identifiers = bindings.lazy.map { binding in
      return binding.pattern.flattenedForAPI().lazy.map { flattened in
        return flattened.identifier.text
      }
    }
    return Set(identifiers.joined())
  }
}
