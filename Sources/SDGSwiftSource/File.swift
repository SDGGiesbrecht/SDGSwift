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

        // Fill in whitespace.
        for element in makeDeepIterator() {
            if let unidentified = element as? UnidentifiedSyntaxElement,
                let whitespace = Whitespace(unidentified: unidentified, in: source),
                let parent = element.parent as? ContainerSyntaxElement {

                let replacement = parent.children.filter { $0.range.lowerBound ≠ element.range.lowerBound }
                parent.children = replacement + [whitespace]
            }
        }
    }

    // MARK: - Properties

    /// The location of the file.
    public var location: URL
}
