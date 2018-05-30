/*
 DocumentationParameter.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections

/// An isolated parameter in symbol documentation.
public class DocumentationParameter : DocumentationCallout {

    internal init(bullet: Punctuation, callout: Keyword, colon: Punctuation, end: String.ScalarView.Index, in source: String) {
        let range: Range<String.ScalarView.Index>
        if let nameStart = source.scalars.firstMatch(for: ConditionalPattern({ $0 ∉ Whitespace.whitespaceCharacters }), in: callout.range.upperBound ..< colon.range.lowerBound)?.range.lowerBound { // [_Exempt from Test Coverage_] False result in Xcode 9.3.
            range = nameStart ..< colon.range.lowerBound
        } else {
            // Invalid syntax anyway.
            range = callout.range.upperBound ..< colon.range.lowerBound
        }
        let parameter = Identifier(range: range, isDefinition: false, isParameterDocumentation: true)
        self.parameter = parameter
        super.init(bullet: bullet, callout: callout, colon: colon, end: end, in: source, knownChildren: [parameter])
    }

    // MARK: - Properties

    /// The parameter name.
    public let parameter: Identifier
}
