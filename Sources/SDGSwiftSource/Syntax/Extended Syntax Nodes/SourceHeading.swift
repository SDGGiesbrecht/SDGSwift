/*
 SourceHeading.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A heading in source code.
public class SourceHeadingSyntax : ExtendedSyntax {

    internal init(mark: String, heading: String) {
        let markSyntax = ExtendedTokenSyntax(text: mark, kind: .mark)
        self.mark = markSyntax

        let headingSyntax = ExtendedTokenSyntax(text: heading, kind: .sourceHeadingText)
        self.heading = headingSyntax

        super.init(children: [markSyntax, headingSyntax])
    }

    /// The delimiter.
    let mark: ExtendedTokenSyntax

    /// The heading.
    let heading: ExtendedTokenSyntax
}
