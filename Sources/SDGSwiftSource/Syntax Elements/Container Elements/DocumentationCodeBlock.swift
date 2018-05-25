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
        var children: [SyntaxElement] = [startFence, endFence]

        var languageEnd = startFence.range.upperBound
        source.scalars.advance(&languageEnd, over: RepetitionPattern(ConditionalPattern({ $0 ∉ Newline.newlineCharacters })))
        languageEnd.decrease(to: endFence.range.lowerBound)
        if languageEnd ≠ startFence.range.upperBound {
            let language = Keyword(range: startFence.range.upperBound ..< languageEnd)
            self.language = language
            children.append(language)
        } else {
            self.language = nil
        }

        super.init(range: startFence.range.lowerBound ..< endFence.range.upperBound, children: children)
        parseIndents(in: source)

        // [_Warning: Need to parse contents._]
    }

    // MARK: - Properties

    /// The start fence.
    public let startFence: Punctuation

    /// The end fence.
    public let endFence: Punctuation

    /// The language specifier.
    public let language: Keyword?
}
