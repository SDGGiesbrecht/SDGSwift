/*
 DocumentationContainerElement.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGCollections

/// A container element related to symbol documentation.
public class DocumentationContainerElement : ContainerSyntaxElement {

    internal func parseIndents(in source: String) {
        parseNewlines(in: source, deepSearch: false)
        parseUnidentified(in: source, for: "///", deepSearch: false) { DocumentationToken(range: $0) }
    }

    internal func parseChildren(in source: String) {
        parseIndents(in: source)

        func parseInlineStyle(token: String, create: (_ start: Punctuation, _ end: Punctuation) -> SyntaxElement) {
            parseUnidentified(deepSearch: false) { unidentified in
                let matches = source.scalars.matches(for: LiteralPattern(token.scalars), in: unidentified.range)
                let pairs = stride(from: 0, to: matches.endIndex.rounded(.down, toMultipleOf: 2), by: 2).map { (matches[$0], matches[$0 + 1]) }
                var result: [SyntaxElement] = []
                for pair in pairs {
                    result.append(create(Punctuation(range: pair.0.range), Punctuation(range: pair.1.range)))
                }
                return result
            }
        }

        // Inline code
        parseInlineStyle(token: "`") { DocumentationCodeBlock(startFence: $0, endFence: $1, in: source) }

        // Strong
        parseInlineStyle(token: "**") { DocumentationStrongText(startToken: $0, endToken: $1, in: source) }
        parseInlineStyle(token: "__") { DocumentationStrongText(startToken: $0, endToken: $1, in: source) }

        // Emphasis
        parseInlineStyle(token: "*") { DocumentationEmphasis(startToken: $0, endToken: $1, in: source) }
        parseInlineStyle(token: "_") { DocumentationEmphasis(startToken: $0, endToken: $1, in: source) }

        // Links
        parseUnidentified(deepSearch: false) { unidentified in
            var links: [DocumentationLink] = []
            for match in source.scalars.matches(for: CompositePattern([
                LiteralPattern("[".scalars),
                RepetitionPattern(ConditionalPattern({ $0 ≠ "]" })),
                LiteralPattern("](".scalars),
                RepetitionPattern(ConditionalPattern({ $0 ≠ ")" })),
                LiteralPattern(")".scalars)
                ]), in: unidentified.range) {
                    let medialToken = source.scalars.firstMatch(for: "](".scalars, in: match.range)!.range
                    links.append(DocumentationLink(start: match.range.lowerBound, medialToken: medialToken, end: match.range.upperBound, in: source))
            }
            return links
        }

        // The rest is text.
        parseUnidentified(deepSearch: false) { unidentified in
            if source.scalars[unidentified.range].contains(where: { $0 ∉ Whitespace.whitespaceCharacters }) {
                return [DocumentationText(range: unidentified.range)]
            } else {
                return [Whitespace(range: unidentified.range)]
            }
        }
    }
}
