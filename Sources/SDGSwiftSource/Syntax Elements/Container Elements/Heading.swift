/*
 Heading.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGCollections

/// A heading (also known as a mark).
public class Heading : ContainerSyntaxElement {

    internal init(substructureInformation: SourceKit.Variant, source: String, tokens: [SourceKit.PrimitiveToken]) throws {
        try super.init(substructureInformation: substructureInformation, source: source, tokens: tokens)

        var location = range.lowerBound
        var parsedChildren: [SyntaxElement] = []

        if let match = source.scalars.firstMatch(for: "MARK:".scalars, in: location ..< range.upperBound) {
            // @exempt(from: tests) False coverage result in Xcode 9.3.

            let mark = Keyword(range: match.range)
            location = match.range.upperBound
            parsedChildren.append(mark)
            self.mark = mark
        }

        if let match = source.scalars.firstMatch(for: "\u{2D}".scalars, in: location ..< range.upperBound),
            ¬source.scalars[location ..< match.range.lowerBound].contains(where: { $0 ∉ Whitespace.whitespaceCharacters }) {
            // @exempt(from: tests) False coverage result in Xcode 9.3.

            let divider = Punctuation(range: match.range)
            location = match.range.upperBound
            parsedChildren.append(divider)
            self.divider = divider
        }

        if let match = source.scalars.firstMatch(for: ConditionalPattern({ $0 ∉ Whitespace.whitespaceCharacters }), in: location ..< range.upperBound) {
            // @exempt(from: tests) False coverage result in Xcode 9.3.

            let text = HeadingText(range: match.range.lowerBound ..< range.upperBound)
            parsedChildren.append(text)
            self.text = text
        }

        self.children = parsedChildren
    }

    // MARK: - Properties

    public private(set) var mark: Keyword?
    public private(set) var divider: Punctuation?
    public private(set) var text: HeadingText?
}
