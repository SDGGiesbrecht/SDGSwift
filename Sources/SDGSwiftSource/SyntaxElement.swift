/*
 SyntaxElement.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// An element of Swift syntax.
///
/// - Warning: Do not subclass `SyntaxElement` directly. Subclass either `ContainerSyntaxElement` or `AtomicSyntaxElement` instead.
open class SyntaxElement {

    // MARK: - Initialization

    /// Creates a syntax element with the specified range.
    public init(range: Range<String.ScalarView.Index>) {
        self.range = range
    }

    internal init(substructureInformation: SourceKit.Variant, in file: String) throws {
        let offset = try substructureInformation.value(for: "key.offset").asInteger()
        let length = try substructureInformation.value(for: "key.length").asInteger()

        let start = file.utf8.index(file.utf8.startIndex, offsetBy: offset)
        let end = file.utf8.index(start, offsetBy: length)
        // It is assumed that SourceKit reports valid scalar boundaries.
        range = start ..< end
    }

    // MARK: - Properties

    // [_Define Documentation: SyntaxElement.range_]
    /// The range of the element.
    public final var range: Range<String.ScalarView.Index>
}
