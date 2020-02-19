/*
 InlineCodeSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftSyntax won’t compile.)
  import CCommonMark

  /// Inline code use in documentation.
  public class InlineCodeSyntax: MarkdownSyntax {

    // MARK: - Initialization

    internal init(node: cmark_node, in documentation: String) {
      let openingDelimiter = ExtendedTokenSyntax(text: "`", kind: .codeDelimiter)
      self.openingDelimiter = openingDelimiter

      let sourceText = node.literal ?? ""  // @exempt(from: tests) Empty literal should never happen.
      let source = CodeFragmentSyntax(range: sourceText.bounds, in: sourceText, isSwift: nil)
      self.source = source

      let closingDelimiter = ExtendedTokenSyntax(text: "`", kind: .codeDelimiter)
      self.closingDelimiter = closingDelimiter

      super.init(
        node: node,
        in: documentation,
        precedingChildren: [openingDelimiter, source, closingDelimiter]
      )
    }

    // MARK: - Properties

    /// The opening delimiter.
    public let openingDelimiter: ExtendedTokenSyntax

    /// The contents of the inline code.
    public let source: CodeFragmentSyntax

    /// The closing delimiter.
    public let closingDelimiter: ExtendedTokenSyntax

    // MARK: - ExtendedSyntax

    public override func renderedHTML(
      localization: String,
      internalIdentifiers: Set<String>,
      symbolLinks: [String: String]
    ) -> String {
      return source.syntaxHighlightedHTML(
        inline: true,
        internalIdentifiers: internalIdentifiers,
        symbolLinks: symbolLinks
      )
    }
  }
#endif
