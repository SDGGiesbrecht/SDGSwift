/*
 ExtendedSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGMathematics

import SDGSwift

/// A syntax node.
///
/// This type is comparable to `Syntax`, but represents syntax not handled by the `SwiftSyntax` module.
public class ExtendedSyntax: TextOutputStreamable {  // @exempt(from: classFinality)

  internal init(children: [ExtendedSyntax]) {  // @exempt(from: tests)  Unreachable from tvOS.
    self.children = children
  }

  // MARK: - Properties

  /// The children of this node.
  public internal(set) var children: [ExtendedSyntax]

  private var _offset: Int?
  private var positionOffset: Int {
    get {  // @exempt(from: tests)  Unreachable from tvOS.
      return _offset!
      // The unwrap can only fail if the top‐level node forgot to call determinePositions().
    }
    set {
      _offset = newValue
    }
  }
  private var endPositionOffset: Int {  // @exempt(from: tests)  Unreachable from tvOS.
    if let token = self as? ExtendedTokenSyntax {
      return positionOffset + token.text.scalars.count
    } else {
      return children.last?.endPositionOffset
        ?? positionOffset  // @exempt(from: tests) Shouldn’t be childless.
    }
  }
  internal func determinePositions() {
    var offset = 0
    determineNestedPositions(offset: &offset)
    setTreeRelationships()
  }
  internal func determineNestedPositions(offset: inout Int) {
    positionOffset = offset
    for child in children {
      child.determineNestedPositions(offset: &offset)
      if let token = child as? ExtendedTokenSyntax {
        offset = token.endPositionOffset
      }
    }
  }

  /// The parent node.
  public internal(set) weak var parent: ExtendedSyntax?
  /// The index of the node in its parent.
  public internal(set) var indexInParent: Int = 0
  internal func setTreeRelationships() {  // @exempt(from: tests)  Unreachable from tvOS.
    for index in children.indices {
      let child = children[index]
      child.parent = self
      child.indexInParent = index
      child.setTreeRelationships()
    }
  }

  /// The node’s source text.
  public var text: String {  // @exempt(from: tests)  Unreachable from tvOS.
    var result = ""
    write(to: &result)
    return result
  }

  // MARK: - Location

  #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
    /// Returns the lower bound of the node.
    ///
    /// - Parameters:
    ///     - context: The node’s context.
    public func lowerBound(in context: ExtendedSyntaxContext) -> String.ScalarOffset {
      switch context {
      case ._trivia(let trivia, context: let triviaContext):
        let sourceStart = trivia.lowerBound(in: triviaContext)
        return sourceStart + positionOffset
      case ._token(let token, context: let tokenContext):
        let sourceStart = token.lowerSyntaxBound(in: tokenContext)
        return sourceStart + positionOffset
      case ._fragment(let code, context: let codeContext, let offset):
        let fragmentLocation = code.lowerBound(in: codeContext)
        return fragmentLocation + offset
      }
    }

    /// Returns the upper bound of the node.
    ///
    /// - Parameters:
    ///     - context: The node’s context.
    public func upperBound(in context: ExtendedSyntaxContext) -> String.ScalarOffset {
      switch context {
      case ._trivia(let trivia, context: let triviaContext):
        let sourceStart = trivia.lowerBound(in: triviaContext)
        return sourceStart + endPositionOffset
      case ._token(let token, context: let tokenContext):
        let sourceStart = token.lowerSyntaxBound(in: tokenContext)
        return sourceStart + endPositionOffset
      case ._fragment(let code, context: let codeContext, let offset):
        let fragmentLocation = code.lowerBound(in: codeContext)
        return fragmentLocation + (offset + text.scalars.count)
      }
    }

    /// Returns the range of the node.
    ///
    /// - Parameters:
    ///     - context: The node’s context.
    public func range(in context: ExtendedSyntaxContext) -> Range<String.ScalarOffset> {
      return lowerBound(in: context)..<upperBound(in: context)
    }
  #endif

  // MARK: - Syntax Tree

  // #documentation(SDGSwiftSource.Syntax.ancestors())
  /// All the node’s ancestors in order from its immediate parent to the root node.
  public
    func ancestors() -> AnySequence<ExtendedSyntax>
  {  // @exempt(from: tests)  Unreachable from tvOS.
    if let parent = self.parent {
      return AnySequence(sequence(first: parent, next: { $0.parent }))
    } else {
      return AnySequence([])
    }
  }

  private
    var parentRelationship: (parent: ExtendedSyntax, index: Int)?
  {  // @exempt(from: tests)  Unreachable from tvOS.
    guard let parent = self.parent else {
      return nil
    }
    return (parent, indexInParent)
  }
  internal func ancestorRelationships() -> AnySequence<(parent: ExtendedSyntax, index: Int)> {
    if let parentRelationship = self.parentRelationship {
      return AnySequence(
        sequence(first: parentRelationship, next: { $0.parent.parentRelationship })
      )
    } else {  // @exempt(from: tests)
      // @exempt(from: tests) Unreachable. No extended token is a top‐level node.
      return AnySequence([])
    }
  }

  // #documentation(SDGSwiftSource.Syntax.firstToken())
  /// Return the first token of the node.
  public
    func firstToken() -> ExtendedTokenSyntax?
  {  // @exempt(from: tests)  Unreachable from tvOS.
    if let token = self as? ExtendedTokenSyntax,
      ¬token.text.isEmpty
    {
      return token
    }
    return children.lazy.compactMap({ $0.firstToken() }).first
  }

  // #documentation(SDGSwiftSource.Syntax.firstToken())
  /// Return the first token of the node.
  public
    func lastToken() -> ExtendedTokenSyntax?
  {  // @exempt(from: tests)  Unreachable from tvOS.
    if let token = self as? ExtendedTokenSyntax,
      ¬token.text.isEmpty
    {
      return token
    }
    return children.reversed().lazy.compactMap({ $0.lastToken() }).first
  }

  // MARK: - Rendering

  internal var renderedHtmlElement: String? {  // @exempt(from: tests)  Unreachable from tvOS.
    return nil
  }

  internal
    var renderedHTMLAttributes: [String: String]
  {  // @exempt(from: tests)  Unreachable from tvOS.
    return [:]
  }

  /// Returns the HTML result of documentation rendering.
  ///
  /// The resulting HTML depends on the CSS provided by `SyntaxHighlighter.css`.
  ///
  /// - Parameters:
  ///     - localization: The localization to use for generated content such as callout headings.
  ///     - internalIdentifiers: Optional. A set of identifiers to consider as belonging to the module.
  ///     - symbolLinks: Optional. A dictionary of target links for cross‐linking symbols. The values will be inserted as‐is in `href` attributes. URLs must already be properly encoded for this context before passing them.
  public func renderedHTML(
    localization: String,
    internalIdentifiers: Set<String> = [],
    symbolLinks: [String: String] = [:]
  ) -> String {  // @exempt(from: tests)  Unreachable from tvOS.
    var result = ""
    if let element = renderedHtmlElement {
      result.append(contentsOf: "<" + element)
      let attributes = renderedHTMLAttributes
      if ¬attributes.isEmpty {
        for key in attributes.keys.sorted() {
          result.append(contentsOf: " " + key + "=\u{22}" + attributes[key]! + "\u{22}")
        }
      }
      result.append(contentsOf: ">")
    }
    for child in children {
      result.append(
        contentsOf: child.renderedHTML(
          localization: localization,
          internalIdentifiers: internalIdentifiers,
          symbolLinks: symbolLinks
        )
      )
    }
    if let element = renderedHtmlElement {
      result.append(contentsOf: "</" + element + ">")
    }
    return result
  }

  // MARK: - Syntax Colouring

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
  ) -> String {  // @exempt(from: tests)  Unreachable from tvOS.
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
  ) -> String {  // @exempt(from: tests)  Unreachable from tvOS.
    return children.map({
      $0.nestedSyntaxHighlightedHTML(
        internalIdentifiers: internalIdentifiers,
        symbolLinks: symbolLinks
      )
    }).joined()
  }

  // MARK: - TextOutputStreamable

  public func write<Target>(
    to target: inout Target
  ) where Target: TextOutputStream {  // @exempt(from: tests)  Unreachable from tvOS.
    for child in children {
      child.write(to: &target)
    }
  }
}
