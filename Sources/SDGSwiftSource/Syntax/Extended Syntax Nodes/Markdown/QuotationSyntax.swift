/*
 QuotationSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGLogic
import SDGCollections
import SDGText

import CCommonMark

/// A quotation in documentation.
public class QuotationSyntax : MarkdownSyntax {

    internal init(node: cmark_node, in documentation: String) {
        var precedingChildren: [ExtendedSyntax] = []

        let contentStart = node.lowerBound(in: documentation)

        var lineStart = documentation.scalars.startIndex
        if let newline = documentation.scalars[documentation.scalars.startIndex ..< contentStart].lastMatch(for: CharacterSet.newlinePattern) {
            lineStart = newline.range.upperBound
        }

        if let delimiter = documentation.scalars[lineStart ..< contentStart].lastMatch(for: ">".scalars) {

            let delimiterSyntax = ExtendedTokenSyntax(text: String(delimiter.contents), kind: .quotationDelimiter)
            self.delimiter = delimiterSyntax
            precedingChildren.append(delimiterSyntax)

            let indent = ExtendedTokenSyntax(text: String(documentation.scalars[delimiter.range.upperBound ..< contentStart]), kind: .whitespace)
            self.indent = indent
            precedingChildren.append(indent)
        } else {
            delimiter = nil // @exempt(from: tests) Unreachable with valid source.
            indent = nil
        }

        super.init(node: node, in: documentation, precedingChildren: precedingChildren)

        // Fix intervening delimiters.
        do {
            var children = self.children
            for index in children.indices.reversed() {
                if children[index] is ParagraphSyntax,
                    index ≠ children.startIndex {
                    let newlineIndex = children.index(before: index)
                    if let newlineToken = children[newlineIndex] as? ExtendedTokenSyntax,
                        newlineToken.kind == .newlines,
                        newlineIndex ≠ children.startIndex {
                        let predecessor = children.index(before: newlineIndex)
                        if children[predecessor] is ParagraphSyntax {
                            children.insert(contentsOf: [
                                ExtendedTokenSyntax(text: delimiter?.text ?? ">", kind: .quotationDelimiter), // @exempt(from: tests)
                                ExtendedTokenSyntax(text: "\n", kind: .newlines),
                                ExtendedTokenSyntax(text: delimiter?.text ?? ">", kind: .quotationDelimiter), // @exempt(from: tests)
                                ExtendedTokenSyntax(text: indent?.text ?? " ", kind: .whitespace) // @exempt(from: tests)
                                ], at: index)
                        }
                    }
                }
            }
            self.children = children
        }

        if let last = children.last,
            let lastParagraph = last as? ParagraphSyntax,
            lastParagraph.text.hasPrefix("―") {
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
