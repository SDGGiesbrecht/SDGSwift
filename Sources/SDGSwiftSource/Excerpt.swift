/*
 Excerpt.swift

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

/// An excerpt of Swift source code.
public class Excerpt : ContainerSyntaxElement {

    // MARK: - Initialization

    /// Creates an excerpt with the specified source code.
    ///
    /// Throws: A `SourceKit.Error`.
    public init(from source: String) throws {
        let variant = try SourceKit.parse(source: source)
        let tokens = try Excerpt.tokens(fromVariant: variant, source: source)
        try super.init(substructureInformation: variant, source: source, tokens: tokens)
        try postProcess(source: source)
    }

    internal init(variant: SourceKit.Variant, source: String) throws {
        let tokens = try Excerpt.tokens(fromVariant: variant, source: source)
        try super.init(substructureInformation: variant, source: source, tokens: tokens)
        try postProcess(source: source)
    }

    private static func tokens(fromVariant variant: SourceKit.Variant, source: String) throws -> [SourceKit.PrimitiveToken] {
        return try variant.value(for: "key.syntaxmap").asArray().map { entry in
            return SourceKit.PrimitiveToken(range: try SyntaxElement.range(from: entry, for: "key.", in: source), kind: try entry.value(for: "key.kind").asString())
        }
    }

    private func postProcess(source: String) throws {

        // Parse documentation code blocks.
        func nextBlock() -> DocumentationCodeBlock? {
            let block = makeDeepIterator().first(where: { element in
                if let block = element as? DocumentationCodeBlock,
                    block.parsed == false {
                    return true
                } else {
                    return false
                }
            })
            if let found = block {
                return found as? DocumentationCodeBlock
            } else {
                return nil
            }
        }
        while let block = nextBlock() {
            try block.parseContents(source: source)
        }

        // Catch comment tokens before headings.
        parseUnidentified(in: source, for: "//", deepSearch: true) { Comment(range: $0, source: source, tokens: []) }

        // Catch newlines.
        parseNewlines(in: source, deepSearch: true)

        // Catch punctuation.
        parseUnidentified(in: source, for: "{", deepSearch: true) { Punctuation(range: $0) }
        parseUnidentified(in: source, for: "}", deepSearch: true) { Punctuation(range: $0) }
        parseUnidentified(in: source, for: "(", deepSearch: true) { Punctuation(range: $0) }
        parseUnidentified(in: source, for: ")", deepSearch: true) { Punctuation(range: $0) }
        parseUnidentified(in: source, for: "[", deepSearch: true) { Punctuation(range: $0) }
        parseUnidentified(in: source, for: "]", deepSearch: true) { Punctuation(range: $0) }
        parseUnidentified(in: source, for: "\u{2D}>", deepSearch: true) { Punctuation(range: $0) }
        parseUnidentified(in: source, for: ":", deepSearch: true) { Punctuation(range: $0) }
        parseUnidentified(in: source, for: ",", deepSearch: true) { Punctuation(range: $0) }
        parseUnidentified(in: source, for: ".", deepSearch: true) { Punctuation(range: $0) }
        parseUnidentified(in: source, for: "=", deepSearch: true) { Punctuation(range: $0) }

        // Fill in whitespace.
        parseUnidentified(deepSearch: true) { unidentified in
            if let whitespace = Whitespace(unidentified: unidentified, in: source) {
                return [whitespace]
            } else { // [_Exempt from Test Coverage_]
                // [_Exempt from Test Coverage_] The tests require that everying is accounted for by this point.
                return nil
            }
        }

        if BuildConfiguration.current == .debug {
            for unidentified in makeDeepIterator() where unidentified is UnidentifiedSyntaxElement {// [_Exempt from Test Coverage_] The tests require that everying is accounted for by this point.
                print("Unidentified element.")
                print("Parent: \(String(describing: unidentified.parent))")
                print("Source: “\(String(source.scalars[unidentified.range]))”")
            }
        }
    }
}
