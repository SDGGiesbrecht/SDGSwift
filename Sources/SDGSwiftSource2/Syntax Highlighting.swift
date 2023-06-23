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

  // #documentation(SDGSwiftSource.Syntax.syntaxHighlightedHTML)
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
        parserCache: &cache
      ),
      inline: inline
    )
  }

  internal func genericNestedSyntaxHighlightedHTML(
    internalIdentifiers: Set<String>,
    symbolLinks: [String: String],
    parserCache: inout ParserCache
  ) -> String {
    return children(cache: &parserCache).map({ child in
      child._nestedSyntaxHighlightedHTML(
        internalIdentifiers: internalIdentifiers,
        symbolLinks: symbolLinks,
        parserCache: &parserCache
      )
    }).joined()
  }

  public func _nestedSyntaxHighlightedHTML(
    internalIdentifiers: Set<String>,
    symbolLinks: [String: String],
    parserCache: inout ParserCache
  ) -> String {
    return genericNestedSyntaxHighlightedHTML(
      internalIdentifiers: internalIdentifiers,
      symbolLinks: symbolLinks,
      parserCache: &parserCache
    )
  }
}

extension Token {
  public func _nestedSyntaxHighlightedHTML(
    internalIdentifiers: Set<String>,
    symbolLinks: [String: String],
    parserCache: inout ParserCache
  ) -> String {
    switch kind {
    case .commentURL, .linkURL:
      return
        "<a href=\u{22}\(HTML.escapeTextForAttribute(text()))\u{22} class=\u{22}url\u{22}>\(text())</a>"
    default:
      var source = HTML.escapeTextForCharacterData(text())
      if let `class` = syntaxHighlightingClass(internalIdentifiers: internalIdentifiers) {
        source.prepend(contentsOf: "<span class=\u{22}\(`class`)\u{22}>")
        source.append(contentsOf: "</span>")
      }
      return source
    }
  }
  private func syntaxHighlightingClass(internalIdentifiers: Set<String>) -> String? {
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

        #warning("Not implemented yet.")
        /*if isInIfConfigurationCondition() {
          return "compilation‐condition"
        }*/

        #warning("Not implemented yet.")
        /*if let attribute = parent?.as(AttributeSyntax.self),
          attribute.attributeName == self
        {
          // @available, @objc, etc.
          return "keyword"
        }*/

        #warning("Not implemented yet.")
        /*if let parameter = parent?.as(FunctionParameterSyntax.self),
          parameter.firstName == self
        {
          return "internal identifier"
        }*/

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

extension BlockComment {
  public func _nestedSyntaxHighlightedHTML(
    internalIdentifiers: Set<String>,
    symbolLinks: [String: String],
    parserCache: inout ParserCache
  ) -> String {
    var source = genericNestedSyntaxHighlightedHTML(
      internalIdentifiers: internalIdentifiers,
      symbolLinks: symbolLinks,
      parserCache: &parserCache
    )
    source.prepend(contentsOf: "<span class=\u{22}comment\u{22}>")
    source.append(contentsOf: "</span>")
    return source
  }
}

#warning("Is this relevant?")
/*extension Fragment {
  public func _nestedSyntaxHighlightedHTML(
    internalIdentifiers: Set<String>,
    symbolLinks: [String: String],
    parserCache: inout ParserCache
  ) -> String {
    // CodeFragment
    if context == self.source.text,  // Not part of something bigger.
      symbolLinks[context] ≠ nil
    {
      return unknownSyntaxHighlightedHTML(
        internalIdentifiers: internalIdentifiers,
        symbolLinks: symbolLinks
      )
    }

    if let syntax = try? self.syntax(),
      syntax.map({ $0.source() }).joined() == text
    {
      return String(
        syntax.map({
          $0.nestedSyntaxHighlightedHTML(
            internalIdentifiers: internalIdentifiers,
            symbolLinks: symbolLinks
          )
        }).joined()
      )
    } else {
      return unknownSyntaxHighlightedHTML(
        internalIdentifiers: internalIdentifiers,
        symbolLinks: symbolLinks
      )
    }
  }
  // SyntaxFragment
  internal func nestedSyntaxHighlightedHTML(
    internalIdentifiers: Set<String>,
    symbolLinks: [String: String],
    parserCache: inout ParserCache
  ) -> String {
    switch self {
    case .syntax(let syntaxNode):
      return syntaxNode.nestedSyntaxHighlightedHTML(
        internalIdentifiers: internalIdentifiers,
        symbolLinks: symbolLinks
      )
    case .extendedSyntax(let syntaxNode):
      return syntaxNode.nestedSyntaxHighlightedHTML(
        internalIdentifiers: internalIdentifiers,
        symbolLinks: symbolLinks
      )
    case .trivia(let piece, let group, let index):
      return piece.syntax(siblings: group, index: index).nestedSyntaxHighlightedHTML(
        internalIdentifiers: internalIdentifiers,
        symbolLinks: symbolLinks
      )
    }
  }
}*/

extension LineComment {
  public func _nestedSyntaxHighlightedHTML(
    internalIdentifiers: Set<String>,
    symbolLinks: [String: String],
    parserCache: inout ParserCache
  ) -> String {
    var source = genericNestedSyntaxHighlightedHTML(
      internalIdentifiers: internalIdentifiers,
      symbolLinks: symbolLinks,
      parserCache: &parserCache
    )
    source.prepend(contentsOf: "<span class=\u{22}comment\u{22}>")
    source.append(contentsOf: "</span>")
    return source
  }
}

extension StringLiteral {
  public func _nestedSyntaxHighlightedHTML(
    internalIdentifiers: Set<String>,
    symbolLinks: [String: String],
    parserCache: inout ParserCache
  ) -> String {
    var source = genericNestedSyntaxHighlightedHTML(
      internalIdentifiers: internalIdentifiers,
      symbolLinks: symbolLinks,
      parserCache: &parserCache
    )
    source.prepend(contentsOf: "<span class=\u{22}string\u{22}>")
    source.append(contentsOf: "</span>")
    return source
  }
}

extension SwiftSyntaxNode {
  public func _nestedSyntaxHighlightedHTML(
    internalIdentifiers: Set<String>,
    symbolLinks: [String: String],
    parserCache: inout ParserCache
  ) -> String {
    #warning("Not implemented yet.")
    return genericNestedSyntaxHighlightedHTML(internalIdentifiers: internalIdentifiers, symbolLinks: symbolLinks, parserCache: &parserCache)
    /*let existential = resolvedExistential()
    let existentialName = "\(type(of: existential))"
    switch existential {
    case let token as TokenSyntax:
      var result = token.leadingTrivia.nestedSyntaxHighlightedHTML(
        internalIdentifiers: internalIdentifiers,
        symbolLinks: symbolLinks
      )

      if let extended = token.extended {
        result = extended.nestedSyntaxHighlightedHTML(
          internalIdentifiers: internalIdentifiers,
          symbolLinks: symbolLinks
        )
        result.prepend(
          contentsOf:
            "<span class=\u{22}\(existentialName) \(token.tokenKind.cssName)\u{22}>"
        )
        result.append(contentsOf: "</span>")
      } else {
        var source = HTML.escapeTextForCharacterData(token.text)

        var classes = [
          existentialName, token.tokenKind.cssName,
        ]
        if let `class` = token.syntaxHighlightingClass(internalIdentifiers: internalIdentifiers) {
          classes.prepend(`class`)
        }
        source.prepend(contentsOf: "<span class=\u{22}\(classes.joined(separator: " "))\u{22}>")
        source.append(contentsOf: "</span>")

        if token.tokenKind.shouldBeCrossLinked,
          let url = symbolLinks[token.text]
        {
          source.prepend(contentsOf: "<a href=\u{22}\(HTML.escapeTextForAttribute(url))\u{22}>")
          source.append(contentsOf: "</a>")
        }
        result += source
      }

      result += token.trailingTrivia.nestedSyntaxHighlightedHTML(
        internalIdentifiers: internalIdentifiers,
        symbolLinks: symbolLinks
      )
      return result
    default:
      var identifiers = internalIdentifiers

      var identifier: TokenSyntax?
      var variableBindings: Set<String>?
      var parameterClause: ParameterClauseSyntax?
      var genericParameterClause: GenericParameterClauseSyntax?
      switch existential {
      case let structure as StructDeclSyntax:
        identifier = structure.identifier
        genericParameterClause = structure.genericParameterClause
      case let `class` as ClassDeclSyntax:
        identifier = `class`.identifier
        genericParameterClause = `class`.genericParameterClause
      case let enumeration as EnumDeclSyntax:
        identifier = enumeration.identifier
        genericParameterClause = enumeration.genericParameters
      case let `protocol` as ProtocolDeclSyntax:
        identifier = `protocol`.identifier
      case let alias as TypealiasDeclSyntax:
        identifier = alias.identifier
        genericParameterClause = alias.genericParameterClause
      case let associated as AssociatedtypeDeclSyntax:
        identifier = associated.identifier
        genericParameterClause = nil
      case let initializer as InitializerDeclSyntax:
        parameterClause = initializer.signature.input
        genericParameterClause = initializer.genericParameterClause
      case let variable as VariableDeclSyntax:
        variableBindings = variable.identifierList()
      case let `case` as EnumCaseDeclSyntax:
        variableBindings = `case`.identifierList()
      case let `subscript` as SubscriptDeclSyntax:
        parameterClause = `subscript`.indices
        genericParameterClause = `subscript`.genericParameterClause
      case let function as FunctionDeclSyntax:
        identifier = function.identifier
        parameterClause = function.signature.input
        genericParameterClause = function.genericParameterClause
      case let `operator` as OperatorDeclSyntax:
        identifier = `operator`.identifier
      case let precedence as PrecedenceGroupDeclSyntax:
        identifier = precedence.identifier
      default:
        break
      }
      if let identifier = identifier {
        identifiers.insert(identifier.text)
      }
      if let bindings = variableBindings {
        identifiers ∪= bindings
      }
      if let clause = parameterClause {
        let parameters = clause.parameterList.lazy.map({ $0.internalName?.text }).compactMap({
          $0
        })
        identifiers ∪= Set(parameters)
      }
      if let clause = genericParameterClause {
        let parameters = clause.genericParameterList.lazy.map({ $0.name.text })
        identifiers ∪= Set(parameters)
      }

      var result = children(viewMode: .sourceAccurate).map({
        $0.nestedSyntaxHighlightedHTML(internalIdentifiers: identifiers, symbolLinks: symbolLinks)
      }).joined()
      var classes = [
        existentialName
      ]
      if existential is StringLiteralExprSyntax {
        classes.prepend("string")
      }
      result.prepend(contentsOf: "<span class=\u{22}\(classes.joined(separator: " "))\u{22}>")
      result.append(contentsOf: "</span>")
      return result
    }*/
  }
}

#warning("Is this still relevant?")
/*extension TriviaNode {
  public func _nestedSyntaxHighlightedHTML(
    internalIdentifiers: Set<String>,
    symbolLinks: [String: String],
    parserCache: inout ParserCache
  ) -> String {
    var result = ""
    for index in indices {
      let piece = self[index]

      let extended = piece.syntax(siblings: self, index: index)
      result += extended.nestedSyntaxHighlightedHTML(
        internalIdentifiers: internalIdentifiers,
        symbolLinks: symbolLinks
      )
    }
    return result
  }
}*/
