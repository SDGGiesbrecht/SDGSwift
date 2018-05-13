/*
 ContainerSyntaxElement.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

/// An element of Swift syntax which contains child elements.
open class ContainerSyntaxElement : SyntaxElement {

    // MARK: - Initialization

    /// Creates a syntax element with the specified range and child elements.
    ///
    /// The specified children will be automatically sorted and any gaps will be filled in with instances of `UnidentifiedSyntaxElement`.
    ///
    /// - Precondition: The child elements must not overlap or extend outside the parent range.
    public init(range: Range<String.ScalarView.Index>, children: [SyntaxElement]) {
        _children = ContainerSyntaxElement.normalize(children, for: range)
        super.init(range: range)
    }

    internal override init(substructureInformation: SourceKit.Variant, in file: String) throws {
        try super.init(substructureInformation: substructureInformation, in: file)
        children = [] // [_Warning: Substructure not parsed yet._]
    }

    // MARK: - Properties

    private static func normalize(_ children: [SyntaxElement], for parentRange: Range<String.ScalarView.Index>) -> [SyntaxElement] {
        let sorted = children.sorted(by: { $0.range.lowerBound < $1.range.lowerBound })
        var inserts: [SyntaxElement] = []
        for index in sorted.indices {
            let next = sorted.index(after: index)
            if next ≠ sorted.endIndex {
                if sorted[index].range.upperBound ≠ sorted[next].range.lowerBound {
                    inserts.append(UnidentifiedSyntaxElement(range: sorted[index].range.upperBound ..< sorted[next].range.lowerBound))
                }
            }
        }
        if ¬parentRange.isEmpty {
            if sorted.isEmpty {
                inserts.append(UnidentifiedSyntaxElement(range: parentRange))
            } else {
                if parentRange.lowerBound ≠ sorted.first!.range.lowerBound {
                    inserts.append(UnidentifiedSyntaxElement(range: parentRange.lowerBound ..< sorted.first!.range.upperBound))
                }
                if sorted.last!.range.upperBound ≠ parentRange.upperBound {
                    inserts.append(UnidentifiedSyntaxElement(range: sorted.last!.range.upperBound ..< parentRange.upperBound))
                }
            }
        }
        return sorted.appending(contentsOf: inserts).sorted(by: { $0.range.lowerBound < $1.range.lowerBound })
    }

    private var _children: [SyntaxElement] = []
    /// The child elements.
    ///
    /// The specified children will be automatically sorted and any gaps will be filled in with instances of `UnidentifiedSyntaxElement`.
    ///
    /// - Precondition: The child elements must not overlap or extend outside the parent range.
    public var children: [SyntaxElement] {
        get {
            return _children
        }
        set {
            _children = ContainerSyntaxElement.normalize(newValue, for: range)
        }
    }
}
