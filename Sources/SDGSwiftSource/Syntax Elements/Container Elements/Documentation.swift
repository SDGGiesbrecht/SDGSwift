/*
 Documentation.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics
import SDGCollections

/// Documentation.
public class Documentation : ContainerSyntaxElement {

    internal init(range: Range<String.ScalarView.Index>, source: String) {
        super.init(range: range, source: source, tokens: [])

        let singleLineToken = "///"
        let startToken = "/**"
        let endToken = "*/"
        let commentSource = String(source.scalars[range])
        guard commentSource.scalars.count ≥ singleLineToken.scalars.count else {
            return // Invalid syntax. Leave it as unidentified. [_Exempt from Test Coverage_]
        }

        var multiline: Bool

        // Find tokens.
        var tokens: [SyntaxElement] = []
        if source.scalars[range].hasPrefix(singleLineToken.scalars) {
            // Single line
            multiline = false
            for child in children where child is UnidentifiedSyntaxElement {
                let childSource = source.scalars[child.range]
                for match in childSource.matches(for: singleLineToken.scalars) {
                    tokens.append(DocumentationToken(range: match.range))
                }
            }
        } else {
            // Multiline
            multiline = true
            guard let firstUnidentified = children.first(where: { $0 is UnidentifiedSyntaxElement }),
                firstUnidentified.range.lowerBound == range.lowerBound, // [_Exempt from Test Coverage_] False coverage result in Xcode 9.3.
                String(source.scalars[firstUnidentified.range]).scalars.count ≥ startToken.scalars.count else {
                    return // Overlaps something else. Leave it as unidentified. [_Exempt from Test Coverage_]
            }
            tokens.append(DocumentationToken(range: range.lowerBound ..< source.scalars.index(range.lowerBound, offsetBy: startToken.scalars.count)))
            guard let lastUnidentified = children.lazy.reversed().first(where: { $0 is UnidentifiedSyntaxElement }),
                lastUnidentified.range.upperBound == range.upperBound, // [_Exempt from Test Coverage_] False coverage result in Xcode 9.3.
                String(source.scalars[lastUnidentified.range]).scalars.count ≥ endToken.scalars.count else {
                    return // Overlaps something else. Leave it as unidentified. [_Exempt from Test Coverage_]
            }
            tokens.append(DocumentationToken(range: source.scalars.index(range.upperBound, offsetBy: −endToken.scalars.count) ..< range.upperBound))
        }

        var structure = children.filter({ ¬($0 is UnidentifiedSyntaxElement) })
        children = structure + tokens

        var contents: [SyntaxElement] = []
        if multiline {
            for element in children where element is UnidentifiedSyntaxElement {
                contents.append(DocumentationText(range: element.range))
            }
        } else {
            for element in children where element is UnidentifiedSyntaxElement {
                if let newline = source.scalars[element.range].firstMatch(for: ConditionalPattern({ $0 ∈ Newline.newlineCharacters })) {
                    contents.append(DocumentationText(range: element.range.lowerBound ..< newline.range.lowerBound))
                } else {
                    contents.append(DocumentationText(range: element.range))
                }
            }
        }

        structure = children.filter({ ¬($0 is UnidentifiedSyntaxElement) })
        children = structure + contents

        // [_Warning: Need to handle Markdown syntax._]
    }
}
