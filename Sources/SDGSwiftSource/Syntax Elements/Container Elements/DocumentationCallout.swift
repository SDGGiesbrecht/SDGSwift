/*
 DocumentationCallout.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A list element in symbol documentation.
public class DocumentationCallout : DocumentationContainerElement {

    internal init(bullet: Punctuation, callout: Keyword, colon: Punctuation, end: String.ScalarView.Index, in source: String) {
        self.bullet = bullet
        self.callout = callout
        self.colon = colon
        super.init(range: bullet.range.lowerBound ..< end, children: [bullet, callout, colon])
        parseChildren(in: source)
    }

    // MARK: - Properties

    /// The bullet.
    public let bullet: Punctuation

    /// The callout.
    public let callout: Keyword

    /// The colon.
    public let colon: Punctuation
}
