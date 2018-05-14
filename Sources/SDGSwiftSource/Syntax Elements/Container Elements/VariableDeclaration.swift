/*
 VariableDeclaration.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

/// A variable declaration.
public class VariableDeclaration : ContainerSyntaxElement {

    internal init(substructureInformation: SourceKit.Variant, source: String, tokens: [SourceKit.PrimitiveToken]) throws {
        name = Identifier(range: try SyntaxElement.range(from: substructureInformation, for: "key.name", in: source), isDefinition: true)
        try super.init(substructureInformation: substructureInformation, source: source, tokens: tokens, knownChildren: [name])

        for child in children where child is UnidentifiedSyntaxElement {
            if let match = source.scalars.firstMatch(for: "var".scalars, in: child.range) {

                let type = Keyword(range: match.range)
                let structure = children.filter({ ¬($0 is UnidentifiedSyntaxElement) })
                children = structure + [type]
                mutability = type
                break
            }
        }
    }

    // MARK: - Properties

    /// The variable’s mutability. (i.e. `let` or `var`)
    public private(set) var mutability: Keyword?
    /// The name of the variable.
    public let name: Identifier
}
