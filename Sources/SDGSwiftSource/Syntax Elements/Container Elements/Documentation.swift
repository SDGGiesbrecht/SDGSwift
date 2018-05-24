/*
 Documentation.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGLogic
import SDGMathematics
import SDGCollections

/// Documentation.
public class Documentation : ContainerSyntaxElement {

    static let tokensAndWhitespace = Whitespace.whitespaceCharacters ∪ Set<UnicodeScalar>(["/", "*"])

    internal init(range: Range<String.ScalarView.Index>, source: String, tokens: [SourceKit.PrimitiveToken]) {
        super.init(range: range, source: source, tokens: tokens)

        let singleLineToken = "///"
        let startToken = "/**"
        let endToken = "*/"
        let commentSource = String(source.scalars[range])
        guard commentSource.scalars.count ≥ singleLineToken.scalars.count else {
            return // Invalid syntax. Leave it as unidentified. [_Exempt from Test Coverage_]
        }

        // Find tokens.
        var tokens: [SyntaxElement] = []
        if source.scalars[range].hasPrefix(singleLineToken.scalars) {
            // Single line
            for child in children where child is UnidentifiedSyntaxElement {
                let childSource = source.scalars[child.range]
                for match in childSource.matches(for: singleLineToken.scalars) {
                    tokens.append(DocumentationToken(range: match.range))
                }
            }
        } else {
            // Multiline
            guard let firstUnidentified = children.first(where: { $0 is UnidentifiedSyntaxElement }),
                firstUnidentified.range.lowerBound == range.lowerBound, // [_Exempt from Test Coverage_] False coverage result in Xcode 9.3.
                String(source.scalars[firstUnidentified.range]).scalars.count ≥ startToken.scalars.count else {
                    return // Overlaps something else. Leave it as unidentified. [_Exempt from Test Coverage_]
            }
            tokens.append(DocumentationToken(range: range.lowerBound ..< source.scalars.index(range.lowerBound, offsetBy: startToken.scalars.count)))
            guard let lastUnidentified = children.lazy.reversed().first(where: { $0 is UnidentifiedSyntaxElement }),
                lastUnidentified.range.upperBound == range.upperBound, // [_Exempt from Test Coverage_] False coverage result in Xcode 9.3.
                String(source.scalars[lastUnidentified.range]).scalars.count ≥ endToken.scalars.count else {
                    return // Overlaps something else. Leave it as unidentified. [_Exempt from Test Coverage_]
            }
            tokens.append(DocumentationToken(range: source.scalars.index(range.upperBound, offsetBy: −endToken.scalars.count) ..< range.upperBound))
        }

        let structure = children.filter({ ¬($0 is UnidentifiedSyntaxElement) })
        children = structure + tokens

        // Find newlines.
        parseNewlines(in: source)

        // Find single line elements.
        func parseSingleLineElements(_ delimiter: SDGCollections.Pattern<Unicode.Scalar>) {

            parseUnidentified() { unidentified in
                var delimiters: [Punctuation] = []
                for match in source.scalars[unidentified.range].matches(for: delimiter) {
                    let line = match.range.lines(in: source.lines).sameRange(in: source.scalars)
                    if ¬source.scalars[line.lowerBound ..< match.range.lowerBound].contains(where: { $0 ∉ Documentation.tokensAndWhitespace }) {
                        delimiters.append(Punctuation(range: match.range))
                    }
                }
                return delimiters
            }
        }
        // Heading
        parseSingleLineElements(LiteralPattern("###".scalars))
        parseSingleLineElements(LiteralPattern("##".scalars))
        parseSingleLineElements(LiteralPattern("##".scalars))
        // List element (or callout)
        parseSingleLineElements(LiteralPattern("\u{2D}".scalars))
        parseSingleLineElements(LiteralPattern("*".scalars))
        parseSingleLineElements(LiteralPattern("+".scalars))
        // [_Warning: Needs to handle Markdown._]

        /// The rest is text.
        parseUnidentified { [DocumentationText(range: $0.range)] }
    }
}
