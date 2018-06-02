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
        let length = source.scalars[range].count
        var quotationMarks: [Punctuation] = []

        if length ≥ 1,
            source.scalars[range.lowerBound] == "\u{22}" {
            quotationMarks.append(Punctuation(range: range.lowerBound ..< source.scalars.index(after: range.lowerBound)))
        }
        if length ≥ 2 {
            let start = source.scalars.index(before: range.upperBound)
            if source.scalars[start] == "\u{22}" {
                quotationMarks.append(Punctuation(range: start ..< range.upperBound))
            }
        }

        super.init(range: range, children: quotationMarks)
        parseUnidentified(deepSearch: false) { [StringLiteralText(range: $0.range)] }
    }
}
