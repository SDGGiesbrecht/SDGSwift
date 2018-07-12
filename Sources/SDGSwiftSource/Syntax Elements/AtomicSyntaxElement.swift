/*
 AtomicSyntaxElement.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGLocalization

/// An element of Swift syntax which cannot be broken up any further.
///
/// Subclassing Requirements:
///   - `var textFreedom: TextFreedom { get }`
open class AtomicSyntaxElement : SyntaxElement {

    /// Creates a syntax element with the specified range.
    public required override init(range: Range<String.ScalarView.Index>) { // @exempt(from: tests) False coverage result in Xcode 9.3.
        super.init(range: range)
    }

    internal override init(substructureInformation: SourceKit.Variant, in source: String) throws { // @exempt(from: tests) False coverage result in Xcode 9.3.
        try super.init(substructureInformation: substructureInformation, in: source)
    }

    // MARK: - Properties

    // @documentation(SyntaxElement.textFreedom)
    /// How much freedom the user has in choosing the text of the element.
    public var textFreedom: TextFreedom {
        primitiveMethod()
    }

    // Offsets

    internal func splitting(arround interruption: SyntaxElement, in source: String) -> [SyntaxElement] {
        var elements: [SyntaxElement] = [interruption]
        if range.lowerBound ≠ interruption.range.lowerBound {
            elements.append(type(of: self).init(range: range.lowerBound ..< interruption.range.lowerBound))
        }
        let remainder = source.distance(from: interruption.range.lowerBound, to: range.upperBound)
        if remainder ≠ 0 {
            elements.append(type(of: self).init(range: interruption.range.upperBound ..< source.scalars.index(interruption.range.upperBound, offsetBy: remainder)))
        }
        return elements
    }
}
