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
import SDGLocalization

/// An element of Swift syntax.
///
/// - Warning: Do not subclass `SyntaxElement` directly. Subclass either `ContainerSyntaxElement` or `AtomicSyntaxElement` instead.
open class SyntaxElement {

    // MARK: - Parsing

    internal static func parse(substructureInformation: SourceKit.Variant, source: String, tokens: [SourceKit.PrimitiveToken]) throws -> SyntaxElement {
        let kind = try substructureInformation.value(for: "key.kind").asString()
        switch kind {
        case "source.lang.swift.decl.function.method.instance":
            return try FunctionDeclaration(substructureInformation: substructureInformation, source: source, tokens: tokens)
        case "source.lang.swift.decl.struct":
            return try TypeDeclaration(substructureInformation: substructureInformation, source: source, tokens: tokens)
        case "source.lang.swift.decl.var.global",
             "source.lang.swift.decl.var.instance":
            return try VariableDeclaration(substructureInformation: substructureInformation, source: source, tokens: tokens)
        case "source.lang.swift.decl.var.parameter":
            return try Parameter(substructureInformation: substructureInformation, source: source, tokens: tokens)
        case "source.lang.swift.expr.argument":
            return try Argument(substructureInformation: substructureInformation, source: source, tokens: tokens)
        case "source.lang.swift.expr.array":
            return try ArrayLiteral(substructureInformation: substructureInformation, source: source, tokens: tokens)
        case "source.lang.swift.expr.call":
            return try Expression(substructureInformation: substructureInformation, source: source, tokens: tokens)
        case "source.lang.swift.expr.tuple":
            return try Tuple(substructureInformation: substructureInformation, source: source, tokens: tokens)
        case "source.lang.swift.syntaxtype.comment.mark":
            return try Heading(substructureInformation: substructureInformation, source: source, tokens: tokens)
        default:
            // [_Exempt from Test Coverage_]
            if BuildConfiguration.current == .debug {
                print("Unidentified substructure kind: \(kind)")
            }
            return try UnidentifiedSyntaxElement(substructureInformation: substructureInformation, in: source)
        }
    }

    // MARK: - Initialization

    /// Creates a syntax element with the specified range.
    public init(range: Range<String.ScalarView.Index>) { // [_Exempt from Test Coverage_] False coverage result in Xcode 9.3.
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

    internal init(substructureInformation: SourceKit.Variant, in source: String) throws { // [_Exempt from Test Coverage_] False coverage result in Xcode 9.3.
        range = try SyntaxElement.range(from: substructureInformation, for: "key.", in: source)
    }

    // MARK: - Properties

    // [_Define Documentation: SyntaxElement.range_]
    /// The range of the element.
    public var range: Range<String.ScalarView.Index>

    /// The parent syntax element.
    public internal(set) weak var parent: SyntaxElement?

    // MARK: - Iteration

    /// Returns a deep iterator over the element and its children.
    public func makeDeepIterator() -> SyntaxElement.DeepIterator {
        return DeepIterator(rootElement: self)
    }
}
