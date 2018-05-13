/*
 PrimitiveToken.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

extension SourceKit {

    internal struct PrimitiveToken {
        internal var range: Range<String.ScalarView.Index>
        internal var kind: String
    }
}

extension Array where Element == SourceKit.PrimitiveToken {

    func tokens(in range: Range<String.ScalarView.Index>) -> [SourceKit.PrimitiveToken] {
        var result: [SourceKit.PrimitiveToken] = []
        var iterator = makeIterator()
        while let next = iterator.next(),
            next.range.upperBound ≤ range.upperBound {
                if range.lowerBound ≤ next.range.lowerBound {
                    result.append(next)
                }
        }
        return result
    }
}
