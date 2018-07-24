/*
 HeadingSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections
import SDGText
import SDGCMarkShims

public class HeadingSyntax : MarkdownSyntax {

    internal init(node: cmark_node, in documentation: String) {
        var precedingChildren: [ExtendedSyntax] = []
        var followingChildren: [ExtendedSyntax] = []

        let level = Int(cmark_node_get_header_level(node))

        let contentStart = node.lowerBound(in: documentation)

        var lineStart = documentation.scalars.startIndex
        if let newline = documentation.scalars.lastMatch(for: CharacterSet.newlinePattern, in: documentation.scalars.startIndex ..< contentStart) {
            lineStart = newline.range.upperBound
        }

        if let delimiter = documentation.scalars.lastMatch(for: String(repeating: "#", count: level).scalars, in: lineStart ..< contentStart) {

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
            if let newline = documentation.scalars.firstMatch(for: CharacterSet.newlinePattern, in: contentStart ..< contentEnd) {
                let newlineToken = ExtendedTokenSyntax(text: String(newline.contents), kind: .newlines)
                followingChildren.append(newlineToken)
                self.newline = newlineToken

                var delimiterEnd = documentation.scalars.endIndex
                if let nextNewline = documentation.scalars.firstMatch(for: CharacterSet.newlinePattern, in: newline.range.upperBound ..< documentation.scalars.endIndex) {
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
                    self.trailingNewlines = nil
                }

            } else {
                self.newline = nil
                underline = nil
                trailingNewlines = nil
            }
        }
        super.init(node: node, in: documentation, precedingChildren: precedingChildren, followingChildren: followingChildren)
    }

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
}
