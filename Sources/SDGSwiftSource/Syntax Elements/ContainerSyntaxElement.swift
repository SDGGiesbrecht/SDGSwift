/*
 ContainerSyntaxElement.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic
import SDGMathematics
import SDGCollections

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

    internal init(substructureInformation: SourceKit.Variant, source: String, tokens: [SourceKit.PrimitiveToken], knownChildren: [SyntaxElement] = []) throws { // [_Exempt from Test Coverage_] False coverage result in Xcode 9.3.
        try super.init(substructureInformation: substructureInformation, in: source)
        defer { resolve(tokens: tokens, source: source) }
        guard let substructure = try? substructureInformation.value(for: "key.substructure") else {
            children = knownChildren
            return
        }

        var substructureElements: [SyntaxElement] = []
        for next in try substructure.asArray().map({ try SyntaxElement.parse(substructureInformation: $0, source: source, tokens: tokens) }) {
            if let last = substructureElements.last,
                next.range.overlaps(last.range),
                next.range ⊆ last.range,
                let lastContainer = last as? ContainerSyntaxElement {
                // “next” is really a subelement of “last”

                substructureElements.removeLast()
                var lastChildren = lastContainer.children.filter { ¬$0.range.overlaps(next.range) }
                lastChildren.append(next)
                lastContainer.children = lastChildren
                substructureElements.append(lastContainer)

            } else {
                substructureElements.append(next)
            }
        }

        children = knownChildren + substructureElements
    }

    internal init(range: Range<String.ScalarView.Index>, source: String, tokens: [SourceKit.PrimitiveToken], knownChildren: [SyntaxElement] = []) { // [_Exempt from Test Coverage_] False coverage result in Xcode 9.3.
        super.init(range: range)
        children = knownChildren
        resolve(tokens: tokens, source: source)
    }

    private func resolve(tokens: [SourceKit.PrimitiveToken], source: String) {
        var resolvedTokens: [SyntaxElement] = []
        for child in children where child is UnidentifiedSyntaxElement {
            var relevantTokens = tokens.tokens(in: child.range)
            while let token = relevantTokens.first {
                relevantTokens.removeFirst()

                switch token.kind {
                case "source.lang.swift.syntaxtype.attribute.builtin":
                    resolvedTokens.append(Keyword(range: token.range))
                case "source.lang.swift.syntaxtype.comment":
                    // Group them to nest URLs, etc.
                    var endIndex = token.range.upperBound
                    var childTokens: [SourceKit.PrimitiveToken] = []
                    while let next = relevantTokens.first,
                        next.range.lowerBound == endIndex, // contiguous
                        next.kind ∈ ["source.lang.swift.syntaxtype.comment", "source.lang.swift.syntaxtype.comment.url"] as Set<String> {

                            relevantTokens.removeFirst() // Consume it.
                            endIndex = next.range.upperBound
                            if next.kind ≠ "source.lang.swift.syntaxtype.comment" {
                                // Nest special regions.
                                childTokens.append(next)
                            }
                    }
                    resolvedTokens.append(Comment(range: token.range.lowerBound ..< endIndex, source: source, tokens: childTokens))
                case "source.lang.swift.syntaxtype.comment.url":
                    resolvedTokens.append(CommentURL(range: token.range))
                case "source.lang.swift.syntaxtype.doccomment":
                    // Group them to nest callouts, etc.
                    var endIndex = token.range.upperBound
                    var childTokens: [SourceKit.PrimitiveToken] = []
                    while let next = relevantTokens.first,
                        ¬source.scalars[endIndex ..< next.range.lowerBound].contains(where: { $0 ∉ Whitespace.whitespaceCharacters ∧ $0 ∉ Newline.newlineCharacters }), // contiguous
                        next.kind ∈ ["source.lang.swift.syntaxtype.doccomment", "source.lang.swift.syntaxtype.doccomment.field"] as Set<String> {

                            relevantTokens.removeFirst() // Consume it.
                            endIndex = next.range.upperBound
                            if next.kind ≠ "source.lang.swift.syntaxtype.doccomment" {
                                // Nest special regions.
                                childTokens.append(next)
                            }
                    }
                    resolvedTokens.append(Documentation(range: token.range.lowerBound ..< endIndex, source: source, tokens: childTokens))
                case "source.lang.swift.syntaxtype.doccomment.field":
                    resolvedTokens.append(Keyword(range: token.range))
                case "source.lang.swift.syntaxtype.identifier":
                    resolvedTokens.append(Identifier(range: token.range, isDefinition: false))
                case "source.lang.swift.syntaxtype.keyword":
                    resolvedTokens.append(Keyword(range: token.range))
                case "source.lang.swift.syntaxtype.number":
                    resolvedTokens.append(Number(range: token.range))
                case "source.lang.swift.syntaxtype.string":
                    resolvedTokens.append(StringLiteral(range: token.range, source: source))
                case "source.lang.swift.syntaxtype.typeidentifier":
                    resolvedTokens.append(TypeIdentifier(range: token.range, isDefinition: false))
                default:
                    // [_Exempt from Test Coverage_]
                    if BuildConfiguration.current == .debug {
                        print("Unidentified token kind: \(token.kind)")
                    }
                    resolvedTokens.append(UnidentifiedSyntaxElement(range: token.range))
                }
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
                        let lowerBound = sorted[index].range.upperBound
                        let upperBound = sorted[next].range.lowerBound
                        if lowerBound ≤ upperBound {
                            inserts.append(UnidentifiedSyntaxElement(range: lowerBound ..< upperBound))
                        } else {
                            if BuildConfiguration.current == .debug {
                                print("Overlapping children:")
                                print(type(of: self))
                                print([type(of: sorted[index]), type(of: sorted[next])])
                            }
                        }
                    }
                }
            }

            if sorted.isEmpty {
                inserts.append(UnidentifiedSyntaxElement(range: range))
            } else if ¬range.isEmpty {
                if range.lowerBound < sorted.first!.range.lowerBound {
                    inserts.append(UnidentifiedSyntaxElement(range: range.lowerBound ..< sorted.first!.range.lowerBound))
                } else if BuildConfiguration.current == .debug,
                    range.lowerBound ≠ sorted.first!.range.lowerBound {
                    print("Child out of bounds:")
                    print(type(of: self))
                    print(type(of: sorted.first!))
                }

                if sorted.last!.range.upperBound < range.upperBound {
                    inserts.append(UnidentifiedSyntaxElement(range: sorted.last!.range.upperBound ..< range.upperBound))
                } else if BuildConfiguration.current == .debug,
                    sorted.last!.range.upperBound ≠ range.upperBound {
                    print("Child out of bounds:")
                    print(type(of: self))
                    print(type(of: sorted.last!))
                }
            }
            _children = sorted.appending(contentsOf: inserts).sorted(by: { $0.range.lowerBound < $1.range.lowerBound })
            for child in _children {
                child.parent = self
            }
        }
    }

    // MARK: - Offsets

    internal override func offset(by distance: Int, in source: String) {
        super.offset(by: distance, in: source)
        for child in children {
            child.offset(by: distance, in: source)
        }
    }

    internal func insert(interruption: SyntaxElement, in source: String) {
        let length = source.distance(from: interruption.range.lowerBound, to: interruption.range.upperBound)
        range = range.lowerBound ..< source.scalars.index(range.upperBound, offsetBy: length)
        for child in children.reversed() {
            if child.range.lowerBound ≥ interruption.range.lowerBound {
                child.offset(by: length, in: source)
            } else if child.range.overlaps(interruption.range) {
                if let container = child as? ContainerSyntaxElement {
                    container.insert(interruption: interruption, in: source)
                } else if let atomic = child as? AtomicSyntaxElement {
                    let others = children.filter { $0.range.lowerBound ≠ child.range.lowerBound }
                    children = others.appending(contentsOf: atomic.splitting(arround: interruption, in: source))
                }
            } else {
                break
            }
        }
    }

    // MARK: - Parsing

    internal func parseUnidentified(deepSearch: Bool, parse: (UnidentifiedSyntaxElement) -> [SyntaxElement]?) {
        let elements: [SyntaxElement]
        if deepSearch {
            elements = Array(makeDeepIterator())
        } else {
            elements = children
        }
        for element in elements {
            if let unidentified = element as? UnidentifiedSyntaxElement {
                if let replacement = parse(unidentified),
                    ¬replacement.isEmpty,
                    let parent = element.parent as? ContainerSyntaxElement {
                    let otherChildren = parent.children.filter { $0.range.lowerBound ≠ element.range.lowerBound }
                    parent.children = otherChildren + replacement
                }
            }
        }
    }

    internal func parseUnidentified(in source: String, for literal: String, deepSearch: Bool, create: (Range<String.ScalarView.Index>) -> SyntaxElement) {
        return parseUnidentified(deepSearch: deepSearch) { unidentified in
            let matches = source.scalars.matches(for: literal.scalars, in: unidentified.range)
            if matches.isEmpty {
                return nil
            } else {
                return matches.map { create($0.range) }
            }
        }
    }

    internal func parseNewlines(in source: String, deepSearch: Bool) {
        parseUnidentified(in: source, for: "\u{D}\u{A}" /* CR + LF */, deepSearch: deepSearch) { Newline(range: $0) }
        parseUnidentified(in: source, for: "\u{A}" /* LF */, deepSearch: deepSearch) { Newline(range: $0) }
    }
}
