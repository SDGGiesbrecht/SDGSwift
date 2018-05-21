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

        try super.init(substructureInformation: variant, source: source, tokens: tokens)

        // Catch comment tokens before headings.
        parseUnidentified(in: source, for: "//") { Comment(range: $0, source: source, tokens: []) }

        // Catch newlines.
        parseNewlines(in: source)

        // Catch punctuation.
        parseUnidentified(in: source, for: "{") { Punctuation(range: $0) }
        parseUnidentified(in: source, for: "}") { Punctuation(range: $0) }
        parseUnidentified(in: source, for: "(") { Punctuation(range: $0) }
        parseUnidentified(in: source, for: ")") { Punctuation(range: $0) }
        parseUnidentified(in: source, for: "[") { Punctuation(range: $0) }
        parseUnidentified(in: source, for: "]") { Punctuation(range: $0) }
        parseUnidentified(in: source, for: ":") { Punctuation(range: $0) }
        parseUnidentified(in: source, for: ",") { Punctuation(range: $0) }
        parseUnidentified(in: source, for: ".") { Punctuation(range: $0) }
        parseUnidentified(in: source, for: "=") { Punctuation(range: $0) }

        // Fill in whitespace.
        parseUnidentified { unidentified in
            if let whitespace = Whitespace(unidentified: unidentified, in: source) {
                return [whitespace]
            } else { // [_Exempt from Test Coverage_]
                // [_Exempt from Test Coverage_] The tests require that everying is accounted for by this point.
                return nil
            }
        }

        if BuildConfiguration.current == .debug {
            parseUnidentified { unidenified in // [_Exempt from Test Coverage_] The tests require that everying is accounted for by this point.
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
