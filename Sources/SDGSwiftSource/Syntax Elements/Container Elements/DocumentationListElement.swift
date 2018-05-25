/*
 DocumentationListElement.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A list element in symbol documentation.
public class DocumentationListElement : DocumentationContainerElement {

    internal init(bullet: Punctuation, end: String.ScalarView.Index, in source: String) {
        self.bullet = bullet
        super.init(range: bullet.range.lowerBound ..< end, children: [bullet])
        parseChildren(in: source)
    }

    // MARK: - Properties

    /// The bullet.
    public let bullet: Punctuation
}
