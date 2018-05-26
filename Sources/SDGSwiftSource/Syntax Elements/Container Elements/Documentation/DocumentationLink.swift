/*
 DocumentationLink.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A link in symbol documentation.
public class DocumentationLink : DocumentationContainerElement {

    internal init(start: String.ScalarView.Index, medialToken: Range<String.ScalarView.Index>, end: String.ScalarView.Index, in source: String) {

        let startToken = Punctuation(range: start ..< source.scalars.index(after: start))
        self.startToken = startToken

        let medialToken = Punctuation(range: medialToken)
        self.medialToken = medialToken

        let endToken = Punctuation(range: source.scalars.index(before: end) ..< end)
        self.endToken = endToken

        let url = DocumentationLinkURL(range: medialToken.range.upperBound ..< endToken.range.lowerBound)
        self.url = url

        super.init(range: start ..< end, children: [startToken, medialToken, url, endToken])
        parseChildren(in: source)
    }

    // MARK: - Properties

    /// The start token.
    public let startToken: Punctuation

    /// The token marking the end of the link text and the start of the URL.
    public let medialToken: Punctuation

    /// The target URL.
    public let url: DocumentationLinkURL

    /// The end token.
    public let endToken: Punctuation
}
