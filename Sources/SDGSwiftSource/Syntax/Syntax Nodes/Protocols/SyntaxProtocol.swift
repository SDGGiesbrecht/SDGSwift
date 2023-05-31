/*
 SyntaxProtocol.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

  import Foundation

  import SDGControlFlow
  import SDGLogic
  import SDGMathematics
  import SDGCollections
  import SDGText
  import SDGPersistence
  import SDGLocalization

  import SwiftSyntax
  import enum SDGHTML.HTML

  import SDGSwift

  extension SyntaxProtocol {

    // MARK: - Properties

    private func resolvedExistential() -> SyntaxProtocol {
      return Syntax(self).asProtocol(SyntaxProtocol.self)
    }

    /// Returns the source code of this syntax node.
    public func source() -> String {
      var result = ""
      write(to: &result)
      return result
    }

    // MARK: - Location

    private func index(
      in context: SyntaxContext,
      for position: AbsolutePosition
    ) -> String.ScalarOffset {
      let string = context.fragmentContext
      let utf8 = string.utf8
      let utf8Index = utf8.index(utf8.startIndex, offsetBy: position.utf8Offset)
      let fragmentIndex = utf8Index.samePosition(in: string.scalars)!
      let fragmentOffset = string.offset(of: fragmentIndex)

      guard let parent = context.parentContext else {
        return fragmentOffset
      }
      let code = parent.code
      let codeOffset = fragmentOffset − code.range.lowerBound
      let codePosition: String.ScalarOffset = code.lowerBound(in: parent.context)
      return codePosition + codeOffset
    }

    /// Returns the lower bound of the leading trivia.
    ///
    /// - Parameters:
    ///     - context: The node’s context.
    public func lowerTriviaBound(in context: SyntaxContext) -> String.ScalarOffset {
      return index(in: context, for: position)
    }

    /// Returns the lower bound of the node excluding leading trivia.
    ///
    /// - Parameters:
    ///     - context: The node’s context.
    public func lowerSyntaxBound(in context: SyntaxContext) -> String.ScalarOffset {
      return index(in: context, for: positionAfterSkippingLeadingTrivia)
    }

    /// Returns the upper bound of the node excluding trailing trivia.
    ///
    /// - Parameters:
    ///     - context: The node’s context.
    public func upperSyntaxBound(in context: SyntaxContext) -> String.ScalarOffset {
      return index(in: context, for: endPositionBeforeTrailingTrivia)
    }

    /// Returns the upper bound of the trailing trivia.
    ///
    /// - Parameters:
    ///     - context: The node’s context.
    public func upperTriviaBound(in context: SyntaxContext) -> String.ScalarOffset {
      return index(in: context, for: endPosition)
    }

    /// Returns the range of the node excluding trivia.
    ///
    /// - Parameters:
    ///     - context: The node’s context.
    public func syntaxRange(in context: SyntaxContext) -> Range<String.ScalarOffset> {
      return lowerSyntaxBound(in: context)..<upperSyntaxBound(in: context)
    }

    /// Returns the range of the node including trivia.
    ///
    /// - Parameters:
    ///     - context: The node’s context.
    public func triviaRange(in context: SyntaxContext) -> Range<String.ScalarOffset> {
      return lowerTriviaBound(in: context)..<upperTriviaBound(in: context)
    }

    // MARK: - Syntax Tree

    // @documentation(SDGSwiftSource.Syntax.ancestors())
    /// All the node’s ancestors in order from its immediate parent to the root node.
    public func ancestors() -> AnySequence<Syntax> {
      if let parent = self.parent {
        return AnySequence(sequence(first: parent, next: { $0.parent }))
      } else {
        return AnySequence([])
      }
    }

    internal func ancestorRelationships() -> AnySequence<(parent: Syntax, index: Int)> {
      if let parentRelationship = self.parentRelationship {
        return AnySequence(
          sequence(first: parentRelationship, next: { $0.parent.parentRelationship })
        )
      } else {
        return AnySequence([])
      }
    }

    // @documentation(SDGSwiftSource.Syntax.firstToken())
    /// Return the first token of the node.
    public func firstToken() -> TokenSyntax? {
      if let token = Syntax(self).as(TokenSyntax.self),
        token.presence == .present
      {
        return token
      }
      return children(viewMode: .sourceAccurate).lazy.compactMap({ $0.firstToken() }).first
    }

    // @documentation(SDGSwiftSource.Syntax.lastToken())
    /// Returns the last token of the node.
    public func lastToken() -> TokenSyntax? {
      if let token = Syntax(self).as(TokenSyntax.self),
        token.presence == .present
      {
        return token
      }
      return children(viewMode: .sourceAccurate).reversed().lazy.compactMap({ $0.lastToken() })
        .first
    }

    private var parentRelationship: (parent: Syntax, index: Int)? {
      guard let parent = self.parent else {
        return nil
      }
      return (parent, indexInParent)
    }

    // MARK: - Syntax Highlighting

    // @documentation(SDGSwiftSource.Syntax.syntaxHighlightedHTML)
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
      return SyntaxHighlighter.frame(
        highlightedSyntax: nestedSyntaxHighlightedHTML(
          internalIdentifiers: internalIdentifiers,
          symbolLinks: symbolLinks
        ),
        inline: inline
      )
    }

    internal func nestedSyntaxHighlightedHTML(
      internalIdentifiers: Set<String>,
      symbolLinks: [String: String]
    ) -> String {
      let existential = resolvedExistential()
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
      }
    }

    // MARK: - Debugging

    internal func warnUnidentified(
      file: StaticString = #fileID,
      function: StaticString = #function
    ) {  // @exempt(from: tests)
      #if DEBUG
        print("Unidentified syntax node: \(Swift.type(of: self)) (\(file), \(function))")
      #endif
    }
  }
