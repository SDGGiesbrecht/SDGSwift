/*
 DocumentationParameterListEntry.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections

/// A grouped parameter in symbol documentation.
public class DocumentationParameterListEntry : DocumentationListElement {

    internal init?(entry: DocumentationListElement, in source: String) {
        guard let colon = source.scalars.firstMatch(for: ":".scalars, in: entry.bullet.range.upperBound ..< entry.range.upperBound)?.range else {
            return nil
        }

        guard let nameStart = source.scalars.firstMatch(for: ConditionalPattern({ $0 ∉ Whitespace.whitespaceCharacters }), in: entry.bullet.range.upperBound ..< colon.lowerBound)?.range.lowerBound else {
            return nil

        }
        let nameRange = nameStart ..< colon.lowerBound

        let colonToken = Punctuation(range: colon)
        self.colon = colonToken
        let parameter = Identifier(range: nameRange, isDefinition: false, isParameterDocumentation: true)
        self.parameter = parameter
        super.init(bullet: entry.bullet, end: entry.range.upperBound, in: source, knownChildren: [colonToken, parameter])
    }

    // MARK: - Properties

    /// The parameter name.
    public let parameter: Identifier

    /// The colon.
    public let colon: Punctuation
}
