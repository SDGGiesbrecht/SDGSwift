/*
 File.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow
import SDGLogic

/// A Swift file.
public class File : ContainerSyntaxElement {

    // MARK: - Initialization

    /// Loads a Swift file.
    ///
    /// Throws: A `SourceKit.Error`.
    public init(from location: URL) throws {
        self.location = location
        let variant = try SourceKit.parse(file: location)
        let source = try String(from: location)

        let tokens = try variant.value(for: "key.syntaxmap").asArray().map { entry in
            return SourceKit.PrimitiveToken(range: try SyntaxElement.range(from: entry, for: "key.", in: source), kind: try entry.value(for: "key.kind").asString())
        }
        print(tokens.map({ ($0.kind, String(source.scalars[$0.range])) })) // [_Warning: Temporary._]

        try super.init(substructureInformation: variant, source: source, tokens: tokens)

        func parseUnidentified(_ parse: (UnidentifiedSyntaxElement) -> [SyntaxElement]?) {
            for element in makeDeepIterator() {
                if let unidentified = element as? UnidentifiedSyntaxElement {
                    if let replacement = parse(unidentified),
                        let parent = element.parent as? ContainerSyntaxElement {
                        let otherChildren = parent.children.filter { $0.range.lowerBound ≠ element.range.lowerBound }
                        parent.children = otherChildren + replacement
                    }
                }
            }
        }

        func parseUnidentified(for literal: String, create: (Range<String.ScalarView.Index>) -> SyntaxElement) {
            return parseUnidentified() { unidentified in
                let matches = source.scalars.matches(for: literal.scalars, in: unidentified.range)
                if matches.isEmpty {
                    return nil
                } else {
                    return matches.map { create($0.range) }
                }
            }
        }

        // Catch comment tokens before headings.
        parseUnidentified(for: "//") { Comment(range: $0, source: source, tokens: []) }

        // Catch punctuation.
        parseUnidentified(for: "{") { Punctuation(range: $0) }
        parseUnidentified(for: "}") { Punctuation(range: $0) }
        parseUnidentified(for: "(") { Punctuation(range: $0) }
        parseUnidentified(for: ")") { Punctuation(range: $0) }
        parseUnidentified(for: ":") { Punctuation(range: $0) }
        parseUnidentified(for: ".") { Punctuation(range: $0) }
        parseUnidentified(for: "=") { Punctuation(range: $0) }

        // Fill in whitespace.
        parseUnidentified() { unidentified in
            if let whitespace = Whitespace(unidentified: unidentified, in: source) {
                return [whitespace]
            } else {
                return nil
            }
        }

        if BuildConfiguration.current == .debug {
            parseUnidentified() { unidenified in
                print("Unidentified element.")
                print("Parent: \(String(describing: unidenified.parent))")
                print("Source: “\(String(source.scalars[unidenified.range]))”")
                return nil
            }
        }
    }

    // MARK: - Properties

    /// The location of the file.
    public var location: URL
}
