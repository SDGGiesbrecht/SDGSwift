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
    }

    // MARK: - Properties

    /// The name of the variable.
    public let name: Identifier

    /// Whether the variable is public.
    public let isPublic: Bool

    // MARK: - API

    // #documentation(SDGSwiftSource.SyntaxElement.api())
    /// Returns the API provided by this element.
    open override func api(source: String) -> [APIElement] {
        if isPublic {
            return [VariableAPI(name: String(source.scalars[name.range]))]
        } else {
            return []
        }
    }
}
