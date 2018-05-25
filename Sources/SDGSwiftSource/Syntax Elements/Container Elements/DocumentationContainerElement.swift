/*
 DocumentationContainerElement.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections

/// A container element related to symbol documentation.
public class DocumentationContainerElement : ContainerSyntaxElement {

    internal func parseIndents(in source: String) {
        parseNewlines(in: source)
        parseUnidentified(in: source, for: "///") { DocumentationToken(range: $0) }
    }

    internal func parseChildren(in source: String) {
        parseIndents(in: source)

        func parseInlineStyle(token: String, create: (_ start: Punctuation, _ end: Punctuation) -> SyntaxElement) {
            parseUnidentified { unidentified in
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
        parseUnidentified(in: source, for: "**") { Punctuation(range: $0) }
        parseUnidentified(in: source, for: "__") { Punctuation(range: $0) }

        // Emphasis
        parseUnidentified(in: source, for: "*") { Punctuation(range: $0) }
        parseUnidentified(in: source, for: "_") { Punctuation(range: $0) }

        // [_Warning: Need to handle links._]

        // The rest is text.
        parseUnidentified { unidentified in
            if source.scalars[unidentified.range].contains(where: { $0 ∉ Whitespace.whitespaceCharacters }) {
                return [DocumentationText(range: unidentified.range)]
            } else {
                return [Whitespace(range: unidentified.range)]
            }
        }
    }
}
