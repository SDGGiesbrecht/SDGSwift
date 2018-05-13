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

    // MARK: - Parsing

    internal static func parse(substructureInformation: SourceKit.Variant, in source: String) throws -> SyntaxElement {
        let kind = try substructureInformation.value(for: "key.kind").asString()
        switch kind {
        case "source.lang.swift.decl.function.method.instance":
            return try FunctionDeclaration(substructureInformation: substructureInformation, in: source)
        case "source.lang.swift.decl.struct":
            return try TypeDeclaration(substructureInformation: substructureInformation, in: source)
        case "source.lang.swift.decl.var.parameter":
            return try Parameter(substructureInformation: substructureInformation, in: source)
        case "source.lang.swift.syntaxtype.comment.mark":
            return try Heading(substructureInformation: substructureInformation, in: source)
        default:
            if BuildConfiguration.current == .debug {
                print("Unidentified substructure kind: \(kind)")
            }
            return try UnidentifiedSyntaxElement(substructureInformation: substructureInformation, in: source)
        }
    }

    // MARK: - Initialization

    /// Creates a syntax element with the specified range.
    public init(range: Range<String.ScalarView.Index>) {
        self.range = range
    }

    internal static func range(from substructureInformation: SourceKit.Variant, for key: String, in source: String) throws -> Range<String.ScalarView.Index> {
        let offset = try substructureInformation.value(for: key + "offset").asInteger()
        let length = try substructureInformation.value(for: key + "length").asInteger()

        let start = source.utf8.index(source.utf8.startIndex, offsetBy: offset)
        let end = source.utf8.index(start, offsetBy: length)
        // It is assumed that SourceKit reports valid scalar boundaries.
        return start ..< end
    }

    internal init(substructureInformation: SourceKit.Variant, in source: String) throws {
        range = try SyntaxElement.range(from: substructureInformation, for: "key.", in: source)
    }

    // MARK: - Properties

    // [_Define Documentation: SyntaxElement.range_]
    /// The range of the element.
    public var range: Range<String.ScalarView.Index>

    // MARK: - Sequence

    /// Returns a deep iterator over the element and its children.
    public func makeDeepIterator() -> SyntaxElement.DeepIterator {
        return DeepIterator(rootElement: self)
    }
}
