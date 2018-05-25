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
        var contentElements: [SyntaxElement] = []
        var interveningElements: [SyntaxElement] = []
        var contentSource = ""
        for child in children where child is UnidentifiedSyntaxElement ∨ child is Newline {
            if child is UnidentifiedSyntaxElement ∨ child is Newline {
                contentElements.append(child)
                contentSource.append(String(source.scalars[child.range]))
            } else {
                interveningElements.append(child)
            }
        }
        let exerpt = try Exerpt(from: contentSource)
        print(exerpt.makeDeepIterator().map({ type(of: $0) }))
    }

    // MARK: - Properties

    /// The start fence.
    public let startFence: Punctuation

    /// The end fence.
    public let endFence: Punctuation

    /// The language specifier.
    public let language: Keyword?
}
