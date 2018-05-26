/*
 DocumentationStrongText.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// Strong text in symbol documentation.
public class DocumentationStrongText : DocumentationContainerElement {

    internal init(startToken: Punctuation, endToken: Punctuation, in source: String) {
        self.startToken = startToken
        self.endToken = endToken
        super.init(range: startToken.range.lowerBound ..< endToken.range.upperBound, children: [startToken, endToken])
        parseChildren(in: source)
    }

    // MARK: - Properties

    /// The start token.
    public let startToken: Punctuation

    /// The end token.
    public let endToken: Punctuation
}
