/*
 HeadingSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections
import SDGText
import SDGCMarkShims

/// A documentation heading.
public class HeadingSyntax : MarkdownSyntax {

    // MARK: - Initialization

    internal init(node: cmark_node, in documentation: String) {
        var precedingChildren: [ExtendedSyntax] = []
        var followingChildren: [ExtendedSyntax] = []

        let level = Int(cmark_node_get_header_level(node))
        self.level = level

        let contentStart = node.lowerBound(in: documentation)

        var lineStart = documentation.scalars.startIndex
        if let newline = documentation.scalars[documentation.scalars.startIndex ..< contentStart].lastMatch(for: CharacterSet.newlinePattern) {
            lineStart = newline.range.upperBound
        }

        if let delimiter = documentation.scalars[lineStart ..< contentStart].lastMatch(for: String(repeating: "#", count: level).scalars) {

            let delimiterSyntax = ExtendedTokenSyntax(text: String(delimiter.contents), kind: .headingDelimiter)
            numberSignDelimiter = delimiterSyntax
            precedingChildren.append(delimiterSyntax)

            let indent = ExtendedTokenSyntax(text: String(documentation.scalars[delimiter.range.upperBound ..< contentStart]), kind: .whitespace)
            self.indent = indent
            precedingChildren.append(indent)

            newline = nil
            underline = nil
            trailingNewlines = nil
        } else {
            numberSignDelimiter = nil
            indent = nil

            let contentEnd = documentation.scalars.index(before: node.upperBound(in: documentation))
            if let newline = documentation.scalars[contentStart ..< contentEnd].firstMatch(for: CharacterSet.newlinePattern) {
                let newlineToken = ExtendedTokenSyntax(text: String(newline.contents), kind: .newlines)
                followingChildren.append(newlineToken)
                self.newline = newlineToken

                var delimiterEnd = documentation.scalars.endIndex
                if let nextNewline = documentation.scalars[newline.range.upperBound ..< documentation.scalars.endIndex].firstMatch(for: CharacterSet.newlinePattern) {
                    delimiterEnd = nextNewline.range.lowerBound
                }
                let underline = ExtendedTokenSyntax(text: String(documentation.scalars[newline.range.upperBound ..< delimiterEnd]), kind: .headingDelimiter)
                followingChildren.append(underline)
                self.underline = underline

                let trailingNewlinesString = String(documentation.scalars[delimiterEnd ..< contentEnd])
                if ¬trailingNewlinesString.isEmpty {
                    let trailingNewlines = ExtendedTokenSyntax(text: trailingNewlinesString, kind: .newlines)
                    self.trailingNewlines = trailingNewlines
                    followingChildren.append(trailingNewlines)
                } else {
                    self.trailingNewlines = nil // @exempt(from: tests) Unreachable with valid syntax.
                }

            } else {
                self.newline = nil // @exempt(from: tests) Unreachable with valid syntax.
                underline = nil
                trailingNewlines = nil
            }
        }
        super.init(node: node, in: documentation, precedingChildren: precedingChildren, followingChildren: followingChildren)
    }

    // MARK: - Properties

    private let level: Int

    /// The number sign delimiter.
    public let numberSignDelimiter: ExtendedTokenSyntax?

    /// The indent after the number sign delimiter.
    public let indent: ExtendedTokenSyntax?

    /// The newline before the underline delimiter.
    public let newline: ExtendedTokenSyntax?

    /// The underline delimiter.
    public let underline: ExtendedTokenSyntax?

    /// Trailing newlines.
    public let trailingNewlines: ExtendedTokenSyntax?

    // MARK: - ExtendedSyntax

    internal override var renderedHtmlElement: String? {
        switch level {
        case ...1:
            return "h1"
        case 2:
            return "h2"
        case 3:
            return "h3"
        case 4:
            return "h4"
        case 5:
            return "h5"
        default:
            return "h6"
        }
    }
}
