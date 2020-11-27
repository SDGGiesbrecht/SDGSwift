/*
 QuotationSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.3.1, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(WASI) || os(Android))
  import Foundation

  import SDGLogic
  import SDGCollections
  import SDGText

  import cmark

  /// A quotation in documentation.
  public final class QuotationSyntax: MarkdownSyntax {

    internal init(node: cmark_node, in documentation: String) {
      var precedingChildren: [ExtendedSyntax] = []

      let nodeStart = node.lowerBound(in: documentation)
      let nodeEnd = node.upperBound(in: documentation)

      let delimiterPattern = ">"
      if documentation.scalars[nodeStart..<nodeEnd].hasPrefix(delimiterPattern.scalars) {
        let delimiterEnd = documentation.scalars.index(
          nodeStart,
          offsetBy: delimiterPattern.scalars.count
        )

        let delimiterSyntax = ExtendedTokenSyntax(
          text: delimiterPattern,
          kind: .quotationDelimiter
        )
        self.delimiter = delimiterSyntax
        precedingChildren.append(delimiterSyntax)

        var indentStart = delimiterEnd
        while indentStart ≠ nodeEnd,
          documentation.scalars[indentStart].properties.isWhitespace
        {
          indentStart = documentation.scalars.index(after: indentStart)
        }
        let indent = ExtendedTokenSyntax(
          text: String(documentation.scalars[delimiterEnd..<indentStart]),
          kind: .whitespace
        )
        self.indent = indent
        precedingChildren.append(indent)
      } else {
        delimiter = nil  // @exempt(from: tests) Unreachable with valid source.
        indent = nil
      }

      super.init(node: node, in: documentation, precedingChildren: precedingChildren)

      // Fix intervening delimiters.
      do {
        var children = self.children
        for index in children.indices.reversed() {
          if children[index] is ParagraphSyntax,
            index ≠ children.startIndex
          {
            let newlineIndex = children.index(before: index)
            if let newlineToken = children[newlineIndex] as? ExtendedTokenSyntax,
              newlineToken.kind == .newlines,
              newlineIndex ≠ children.startIndex
            {
              let predecessor = children.index(before: newlineIndex)
              if children[predecessor] is ParagraphSyntax {
                children.insert(
                  contentsOf: [
                    ExtendedTokenSyntax(
                      text: delimiter?.text ?? ">",  // @exempt(from: tests)
                      kind: .quotationDelimiter
                    ),
                    ExtendedTokenSyntax(text: "\n", kind: .newlines),
                    ExtendedTokenSyntax(
                      text: delimiter?.text ?? ">",  // @exempt(from: tests)
                      kind: .quotationDelimiter
                    ),
                    ExtendedTokenSyntax(
                      text: indent?.text ?? " ",  // @exempt(from: tests)
                      kind: .whitespace
                    ),
                  ],
                  at: index
                )
              }
            }
          }
        }
        self.children = children
      }

      if let last = children.last,
        let lastParagraph = last as? ParagraphSyntax,
        lastParagraph.text.hasPrefix("―")
      {
        lastParagraph.isCitation = true
      }
    }

    /// The number sign delimiter.
    public let delimiter: ExtendedTokenSyntax?

    /// The indent after the number sign delimiter.
    public let indent: ExtendedTokenSyntax?

    // MARK: - ExtendedSyntax

    internal override var renderedHtmlElement: String? {
      return "blockquote"
    }
  }
#endif
