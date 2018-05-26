/*
 DocumentationCodeBlock.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGMathematics
import SDGCollections

/// A code block in symbol documentation.
public class DocumentationCodeBlock : DocumentationContainerElement {

    internal init(startFence: Punctuation, endFence: Punctuation, in source: String) {
        self.startFence = startFence
        self.endFence = endFence
        var tokens: [SyntaxElement] = [startFence, endFence]

        if String(source.scalars[startFence.range]) == "```" {
            var languageEnd = startFence.range.upperBound
            source.scalars.advance(&languageEnd, over: RepetitionPattern(ConditionalPattern({ $0 ∉ Newline.newlineCharacters })))
            languageEnd.decrease(to: endFence.range.lowerBound)
            if languageEnd ≠ startFence.range.upperBound {
                let language = Keyword(range: startFence.range.upperBound ..< languageEnd)
                self.language = language
                tokens.append(language)
            } else {
                self.language = nil
            }
        } else {
            self.language = nil
        }

        super.init(range: startFence.range.lowerBound ..< endFence.range.upperBound, children: tokens)
        parseIndents(in: source)
    }

    func parseContents(source: String) throws {
        parsed = true

        var contentStart = startFence.range.upperBound
        if let language = self.language {
            contentStart = language.range.upperBound
        }

        var interveningElements: [SyntaxElement] = []
        var contentSource = ""
        for child in children where child is UnidentifiedSyntaxElement ∨ child is Newline {
            if child is UnidentifiedSyntaxElement ∨ child is Newline {
                contentSource.append(String(source.scalars[child.range]))
            } else {
                interveningElements.append(child)
            }
        }
        let excerpt = try Excerpt(from: contentSource)
        excerpt.offset(by: source.scalars.distance(from: source.scalars.startIndex, to: contentStart), in: source)
        for element in interveningElements where element.range.lowerBound ≥ contentStart {
            excerpt.insert(interruption: element, in: source)
        }

        let structure = children.filter { ¬$0.range.overlaps(excerpt.range) }
        children = structure + [excerpt]
    }

    // MARK: - Properties

    internal var parsed: Bool = false

    /// The start fence.
    public let startFence: Punctuation

    /// The end fence.
    public let endFence: Punctuation

    /// The language specifier.
    public let language: Keyword?
}
