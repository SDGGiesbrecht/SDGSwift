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
        isPublic = try substructureInformation.asDictionary()["key.accessibility"]?.asString() == "source.lang.swift.accessibility.public"
        name = Identifier(range: try SyntaxElement.range(from: substructureInformation, for: "key.name", in: source), isDefinition: true)
        try super.init(substructureInformation: substructureInformation, source: source, tokens: tokens, knownChildren: [name])

        for child in children where child.range.lowerBound > name.range.lowerBound {
            if let type = child as? TypeIdentifier {
                self.type = type
                break
            }
        }
    }

    // MARK: - Properties

    /// The name of the variable.
    public let name: Identifier

    /// The type of the variable.
    public private(set) var type: TypeIdentifier?

    /// Whether the variable is public.
    public let isPublic: Bool

    // MARK: - API

    // #documentation(SDGSwiftSource.SyntaxElement.api())
    /// Returns the API provided by this element.
    open override func api(source: String) -> [APIElement] {
        if isPublic {
            return [VariableAPI(name: String(source.scalars[name.range]), type: type.flatMap({ String(source.scalars[$0.range]) }))]
        } else {
            return []
        }
    }
}
