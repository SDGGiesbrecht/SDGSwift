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
import SDGText

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

  public func _nestedSyntaxHighlightedHTML(
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
}
