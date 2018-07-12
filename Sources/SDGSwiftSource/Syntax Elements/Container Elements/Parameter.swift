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
        let possibleLabel = Identifier(range: try SyntaxElement.range(from: substructureInformation, for: "key.name", in: source), isDefinition: true)
        if ¬possibleLabel.range.isEmpty {
            label = possibleLabel // @exempt(from: tests) False result in Xcode 9.3.
            try super.init(substructureInformation: substructureInformation, source: source, tokens: tokens, knownChildren: [possibleLabel])
        } else {
            label = nil
            try super.init(substructureInformation: substructureInformation, source: source, tokens: tokens, knownChildren: [])
        }
        for child in children {
            if let name = child as? Identifier { // @exempt(from: tests) False coverage result in Xcode 9.3.
                name.isDefinition = true
                break
            }
        }
    }

    // MARK: - Properties

    /// The label of the parameter.
    public let label: Identifier?
}
