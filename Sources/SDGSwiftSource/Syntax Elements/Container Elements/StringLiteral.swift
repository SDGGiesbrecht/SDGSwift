/*
 StringLiteral.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

/// A string literal.
public class StringLiteral : ContainerSyntaxElement {

    internal init(range: Range<String.ScalarView.Index>, source: String) {
        guard source.scalars[range].count ≥ 2 else {
            super.init(range: range, children: []) // [_Exempt from Test Coverage_] Should be unreachable.
            return
        }

        let textStart = source.scalars.index(after: range.lowerBound)
        let textEnd = source.scalars.index(before: range.upperBound)
        super.init(range: range, children: [
            Punctuation(range: range.lowerBound ..< textStart),
            StringLiteralText(range: textStart ..< textEnd),
            Punctuation(range: textEnd ..< range.upperBound)
            ])
    }
}
