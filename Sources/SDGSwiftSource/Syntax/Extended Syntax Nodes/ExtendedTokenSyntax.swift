/*
 ExtendedTokenSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

import enum SDGHTML.HTML

/// A syntax node representing a single token.
///
/// This type is comparable to `TokenSyntax`, but represents syntax not handled by the `SwiftSyntax` module.
public final class ExtendedTokenSyntax: ExtendedSyntax {

  // MARK: - Initialization

  internal init(
    text: String,
    kind: ExtendedTokenKind
  ) {  // @exempt(from: tests)  Unreachable from tvOS.
    self._text = text
    self.kind = kind
    super.init(children: [])
  }

  // MARK: - Properties

  private let _text: String

  /// The kind of the token.
  public let kind: ExtendedTokenKind

  // MARK: - Syntax Tree

  // #documentation(SDGSwiftSource.TokenSyntax.nextToken())
  /// Returns the next token.
  public
    func previousToken() -> ExtendedTokenSyntax?
  {  // @exempt(from: tests)  Unreachable from tvOS.
    func previousSibling(of relationship: (parent: ExtendedSyntax, index: Int)) -> ExtendedSyntax? {
      var result: ExtendedSyntax?
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

  // #documentation(SDGSwiftSource.TokenSyntax.nextToken())
  /// Returns the next token.
  public
    func nextToken() -> ExtendedTokenSyntax?
  {  // @exempt(from: tests)  Unreachable from tvOS.
    func nextSibling(of relationship: (parent: ExtendedSyntax, index: Int)) -> ExtendedSyntax? {
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

  // MARK: - ExtendedSyntax

  public override func renderedHTML(
    localization: String,
    internalIdentifiers: Set<String>,
    symbolLinks: [String: String]
  ) -> String {  // @exempt(from: tests)  Unreachable from tvOS.
    switch kind {
    case .quotationMark, .string, .whitespace, .newlines, .lineCommentDelimiter,
      .openingBlockCommentDelimiter, .closingBlockCommentDelimiter, .commentText, .commentURL,
      .mark, .sourceHeadingText, .lineDocumentationDelimiter, .openingBlockDocumentationDelimiter,
      .closingBlockDocumentationDelimiter, .bullet, .codeDelimiter, .language, .source,
      .headingDelimiter, .fontModificationDelimiter, .linkDelimiter, .linkURL,
      .imageDelimiter, .quotationDelimiter, .parameter, .colon:
      return ""
    case .documentationText:
      var escaped = HTML.escapeTextForCharacterData(text)
      // Prevent escaping escapes.
      escaped.replaceMatches(for: "&#x0026;", with: "&")
      return escaped
    case .asterism:
      return "<hr>"
    case .callout:
      return "<p class=\u{22}callout‐label \(text.lowercased())\u{22}>"
        + HTML.escapeTextForCharacterData(String(Callout(text)!.localizedText(localization)))
        + "</p>"
    case .lineSeparator:
      return "<br>"
    }
  }

  internal
    func syntaxHighlightingClass() -> String?
  {  // @exempt(from: tests)  Unreachable from tvOS.
    switch kind {

    case .quotationMark:
      return "string‐punctuation"

    case .string, .commentText, .documentationText:
      return "text"

    case .whitespace:
      return nil  // Ignored.

    case .newlines, .commentURL, .source, .linkURL, .lineSeparator:
      return nil  // Handled elsewhere.

    case .lineCommentDelimiter, .openingBlockCommentDelimiter, .closingBlockCommentDelimiter,
      .lineDocumentationDelimiter, .openingBlockDocumentationDelimiter,
      .closingBlockDocumentationDelimiter, .bullet, .codeDelimiter, .headingDelimiter, .asterism,
      .fontModificationDelimiter, .linkDelimiter, .imageDelimiter, .quotationDelimiter, .colon:
      return "comment‐punctuation"

    case .mark, .language, .callout:
      return "comment‐keyword"

    case .sourceHeadingText:
      return "source‐heading"

    case .parameter:
      return "internal identifier"
    }
  }

  internal override func nestedSyntaxHighlightedHTML(
    internalIdentifiers: Set<String>,
    symbolLinks: [String: String]
  ) -> String {  // @exempt(from: tests)  Unreachable from tvOS.
    if kind == .commentURL ∨ kind == .linkURL {
      return
        "<a href=\u{22}\(HTML.escapeTextForAttribute(text))\u{22} class=\u{22}url\u{22}>\(text)</a>"
    } else {
      var source = HTML.escapeTextForCharacterData(_text)
      if let `class` = syntaxHighlightingClass() {
        source.prepend(contentsOf: "<span class=\u{22}\(`class`)\u{22}>")
        source.append(contentsOf: "</span>")
      }
      return source
    }
  }

  // MARK: - TextOutputStreamable

  public override func write<Target>(
    to target: inout Target
  ) where Target: TextOutputStream {  // @exempt(from: tests)  Unreachable from tvOS.
    _text.write(to: &target)
  }
}
