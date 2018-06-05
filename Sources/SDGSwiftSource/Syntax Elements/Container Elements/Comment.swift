/*
 Comment.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGMathematics
import SDGCollections

/// A comment.
public class Comment : ContainerSyntaxElement {

    internal init(range: Range<String.ScalarView.Index>, source: String, tokens: [SourceKit.PrimitiveToken]) {
        super.init(range: range, source: source, tokens: tokens)

        #if os(Linux)
        // [_Workaround: Linux does not report URLs. (Swift 4.1.2)_]
        var urls: [CommentURL] = []
        for match in source.scalars.matches(for: CompositePattern([
            RepetitionPattern(ConditionalPattern({ $0 ∉ CharacterSet.whitespacesAndNewlines })),
            LiteralPattern("://".scalars),
            RepetitionPattern(ConditionalPattern({ $0 ∉ CharacterSet.whitespacesAndNewlines }))
            ]), in: range) {
            urls.append(CommentURL(range: match.range))
        }
        children = urls
        #endif

        let singleLineToken = "//"
        let commentSource = String(source.scalars[range])
        guard commentSource.scalars.count ≥ singleLineToken.scalars.count else {
            return // Invalid syntax. Leave it as unidentified. [_Exempt from Test Coverage_]
        }

        // Find tokens.
        var resolvedNesting: [SyntaxElement] = []
        if source.scalars[range].hasPrefix(singleLineToken.scalars) {
            // [_Exempt from Test Coverage_] False coverage result in Xcode 9.3.
            // Single line
            guard let unidentified = children.first(where: { $0 is UnidentifiedSyntaxElement }),
                unidentified.range.lowerBound == range.lowerBound, // [_Exempt from Test Coverage_] False coverage result in Xcode 9.3.
                String(source.scalars[unidentified.range]).scalars.count ≥ singleLineToken.scalars.count else {
                return // Overlaps something else. Leave it as unidentified. [_Exempt from Test Coverage_]
            }
            resolvedNesting.append(CommentToken(range: range.lowerBound ..< source.scalars.index(range.lowerBound, offsetBy: singleLineToken.scalars.count)))
        } else {
            // Multiline (possibly nested)
            for child in children where child is UnidentifiedSyntaxElement {
                for match in source.scalars.matches(for: AlternativePatterns([// [_Exempt from Test Coverage_] False coverage result in Xcode 9.3.
                    LiteralPattern("/*".scalars),
                    LiteralPattern("*/".scalars)
                    ]), in: child.range) {
                        resolvedNesting.append(CommentToken(range: match.range))
                }
            }
        }

        let structure = children.filter({ ¬($0 is UnidentifiedSyntaxElement) })
        children = structure + resolvedNesting

        // Find newlines.
        parseNewlines(in: source, deepSearch: false)

        // The rest is text.
        parseUnidentified(deepSearch: false) { [CommentText(range: $0.range)] }
    }
}
