/*
 FragmentSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics
import SDGCollections

public class FragmentSyntax : ExtendedSyntax {

    init(clusterOffsets: CountableRange<Int>, in syntax: ExtendedSyntax) {
        var cropped: [ExtendedSyntax] = []
        var index = 0
        for child in syntax.children {
            let childText = child.text
            let childLength = childText.clusters.count
            let start = index
            let end = start + childLength
            defer { index = end }

            if clusterOffsets ⊇ start ..< end  {
                cropped.append(child)
            } else if clusterOffsets.overlaps(start ..< end) {
                var lower = clusterOffsets.lowerBound − start
                var upper = clusterOffsets.upperBound − start
                upper.decrease(to: childLength)
                lower.increase(to: 0)
                let childOffsets = lower ..< upper

                if let token = child as? ExtendedTokenSyntax {
                    var childText = childText
                    if childLength > upper {
                        childText.truncate(at: childText.index(childText.startIndex, offsetBy: upper))
                    }
                    childText.removeFirst(lower)
                    cropped.append(ExtendedTokenSyntax(text: childText, kind: token.kind))
                } else {
                    cropped.append(FragmentSyntax(clusterOffsets: childOffsets, in: child))
                }
            } else if start > clusterOffsets.upperBound {
                break
            }
        }
        super.init(children: cropped)
    }
}
