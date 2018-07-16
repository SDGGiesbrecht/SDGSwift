/*
 CommentContent.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGLocalization

public class CommentContentSyntax : ExtendedSyntax {

    // MARK: - Initialization

    internal init(source: String) {
        var source = source
        var children: [ExtendedSyntax] = []

        while let `protocol` = source.scalars.firstMatch(for: "://".scalars)?.range {
            let start = source.scalars.lastMatch(for: " ".scalars, in: source.startIndex ..< `protocol`.lowerBound)?.range.upperBound ?? source.startIndex
            let end = source.scalars.firstMatch(for: " ".scalars, in: `protocol`.upperBound ..< source.scalars.endIndex)?.range.lowerBound ?? source.endIndex

            if start ≠ source.startIndex {
                children.append(ExtendedTokenSyntax(text: String(source[..<start]), kind: .commentText))
            }
            children.append(ExtendedTokenSyntax(text: String(source[start..<end]), kind: .commentURL))
            source.scalars.removeSubrange(source.scalars.startIndex ..< end)
        }

        if ¬source.isEmpty {
            children.append(ExtendedTokenSyntax(text: source, kind: .commentText))
        }

        super.init(children: children)
    }
}
