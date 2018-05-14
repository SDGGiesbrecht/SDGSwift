/*
 Parameter.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

/// A parameter.
public class Parameter : ContainerSyntaxElement {

    internal init(substructureInformation: SourceKit.Variant, source: String, tokens: [SourceKit.PrimitiveToken]) throws {
        name = Identifier(range: try SyntaxElement.range(from: substructureInformation, for: "key.name", in: source), isDefinition: true)
        try super.init(substructureInformation: substructureInformation, source: source, tokens: tokens, knownChildren: [name])

        if let typeName = try? substructureInformation.value(for: "key.typename").asString() {
            for child in children where child is UnidentifiedSyntaxElement {
                if let match = source.scalars.firstMatch(for: typeName.scalars, in: child.range) {

                    let type = Identifier(range: match.range, isDefinition: false)
                    let structure = children.filter({ ¬($0 is UnidentifiedSyntaxElement) })
                    children = structure + [type]
                    break
                }
            }
        }
    }

    // MARK: - Properties

    /// The name of the parameter.
    public let name: Identifier
    /// The type of the parameter.
    public private(set) var type: Identifier?
}
