/*
 Extension.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// An extension.
public class Extension : ContainerSyntaxElement {

    // MARK: - Initialization

    internal init(substructureInformation: SourceKit.Variant, source: String, tokens: [SourceKit.PrimitiveToken]) throws {
        type = TypeIdentifier(range: try SyntaxElement.range(from: substructureInformation, for: "key.name", in: source), isDefinition: false)
        try super.init(substructureInformation: substructureInformation, source: source, tokens: tokens, knownChildren: [type])
    }

    // MARK: - Properties

    public let type: TypeIdentifier

    // MARK: - API

    // #documentation(SDGSwiftSource.SyntaxElement.api())
    /// Returns the API provided by this element.
    open override func api() -> [APIElement] {
        return [ExtensionAPI(type: "?")]
    }
}
