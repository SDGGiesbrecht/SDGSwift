/*
 This source file is part of the Swift.org open source project
 
 Copyright (c) 2014 - 2017 Apple Inc. and the Swift project authors
 Licensed under Apache License v2.0 with Runtime Library Exception
 
 See http://swift.org/LICENSE.txt for license information
 See http://swift.org/CONTRIBUTORS.txt for Swift project authors
 */

extension Collection where Iterator.Element : Equatable {
    /// Split around a delimiting subsequence with maximum number of splits == 2
    func spm_split(around delimiter: [Iterator.Element]) -> ([Iterator.Element], [Iterator.Element]?) {

        let orig = Array(self)
        let end = orig.endIndex
        let delimCount = delimiter.count

        var index = orig.startIndex
        while index+delimCount <= end {
            let cur = Array(orig[index..<index+delimCount])
            if cur == delimiter {
                //found
                let leading = Array(orig[0..<index])
                let trailing = Array(orig.suffix(orig.count-leading.count-delimCount))
                return (leading, trailing)
            } else {
                //not found, move index down
                index += 1
            }
        }
        return (orig, nil)
    }
}

