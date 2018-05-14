/*
 FunctionDeclaration.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections

/// A function declaration.
public class FunctionDeclaration : ContainerSyntaxElement {

    internal init(substructureInformation: SourceKit.Variant, source: String, tokens: [SourceKit.PrimitiveToken]) throws {

        var nameRange = try SyntaxElement.range(from: substructureInformation, for: "key.name", in: source)
        if let match = source.scalars.firstMatch(for: ConditionalPattern({ $0 ∉ Identifier.identifierOrOperatorCharacters }), in: nameRange) {
            // Strip parameters any whitespace.
            nameRange = nameRange.lowerBound ..< match.range.lowerBound
        }
        if String(source.scalars[nameRange]) == "init" {
            name = Keyword(range: nameRange)
        } else {
            name = Identifier(range: nameRange, isDefinition: true)
        }

        try super.init(substructureInformation: substructureInformation, source: source, tokens: tokens, knownChildren: [name])

        for child in children where child is UnidentifiedSyntaxElement {
            if let match = source.scalars.firstMatch(for: "func".scalars, in: child.range) {

                let type = Keyword(range: match.range)
                let structure = children.filter({ ¬($0 is UnidentifiedSyntaxElement) })
                children = structure + [type]
                keyword = type
                break
            }
        }
    }

    // MARK: - Properties

    /// The keyword.
    public private(set) var keyword: Keyword?
    /// The name of the function (not including parameters).
    public let name: AtomicSyntaxElement
}
