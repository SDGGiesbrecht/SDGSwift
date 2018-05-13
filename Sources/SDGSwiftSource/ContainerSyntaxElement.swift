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
        super.init(range: range)
        self.children = children
    }

    internal init(substructureInformation: SourceKit.Variant, source: String, tokens: [SourceKit.PrimitiveToken], knownChildren: [SyntaxElement] = []) throws {
        try super.init(substructureInformation: substructureInformation, in: source)
        guard let substructure = try? substructureInformation.value(for: "key.substructure") else {
            children = knownChildren
            return
        }
        children = try knownChildren + substructure.asArray().map { try SyntaxElement.parse(substructureInformation: $0, source: source, tokens: tokens) }
        resolve(tokens: tokens, source: source)
    }

    internal init(range: Range<String.ScalarView.Index>, source: String, tokens: [SourceKit.PrimitiveToken]) {
        super.init(range: range)
        resolve(tokens: tokens, source: source)
    }

    private func resolve(tokens: [SourceKit.PrimitiveToken], source: String) {
        var resolvedTokens: [SyntaxElement] = []
        for child in children where child is UnidentifiedSyntaxElement {
            // [_Warning: Remove._]
            print(type(of: self))
            print(String(source.scalars[child.range]))
            let containedTokens = tokens.tokens(in: child.range)
            for token in containedTokens {
                // [_Warning: Remove._]
                print(token.kind)
            }
        }

        let structure = children.filter({ ¬($0 is UnidentifiedSyntaxElement) })
        children = structure + resolvedTokens
    }

    // MARK: - Properties

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
            let sorted = newValue.sorted(by: { $0.range.lowerBound < $1.range.lowerBound })
            var inserts: [SyntaxElement] = []
            for index in sorted.indices {
                let next = sorted.index(after: index)
                if next ≠ sorted.endIndex {
                    if sorted[index].range.upperBound ≠ sorted[next].range.lowerBound {
                        inserts.append(UnidentifiedSyntaxElement(range: sorted[index].range.upperBound ..< sorted[next].range.lowerBound))
                    }
                }
            }
            if ¬range.isEmpty {
                if sorted.isEmpty {
                    inserts.append(UnidentifiedSyntaxElement(range: range))
                } else {
                    if range.lowerBound ≠ sorted.first!.range.lowerBound {
                        inserts.append(UnidentifiedSyntaxElement(range: range.lowerBound ..< sorted.first!.range.lowerBound))
                    }
                    if sorted.last!.range.upperBound ≠ range.upperBound {
                        inserts.append(UnidentifiedSyntaxElement(range: sorted.last!.range.upperBound ..< range.upperBound))
                    }
                }
            }
            _children = sorted.appending(contentsOf: inserts).sorted(by: { $0.range.lowerBound < $1.range.lowerBound })
        }
    }
}
