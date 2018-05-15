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
        // [_Workaround: Linux does not report URLs. (Swift 4.1)_]
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

        let singeLineToken = "//"
        let commentSource = String(source.scalars[range])
        guard commentSource.scalars.count ≥ singeLineToken.scalars.count else {
            return // Invalid syntax. Leave it as unidentified. [_Exempt from Test Coverage_]
        }

        // Find tokens.
        var resolvedNesting: [SyntaxElement] = []
        if source.scalars[range].hasPrefix(singeLineToken.scalars) {
            // Single line
            guard let unidentified = children.first(where: { $0 is UnidentifiedSyntaxElement }),
                unidentified.range.lowerBound == range.lowerBound,
                String(source.scalars[unidentified.range]).scalars.count ≥ singeLineToken.scalars.count else {
                return // Overlaps something else. Leave it as unidentified. [_Exempt from Test Coverage_]
            }
            resolvedNesting.append(CommentToken(range: range.lowerBound ..< source.scalars.index(range.lowerBound, offsetBy: singeLineToken.scalars.count)))
        } else {
            // Multiline (possibly nested)
            for child in children where child is UnidentifiedSyntaxElement {
                for match in source.scalars.matches(for: AlternativePatterns([
                    LiteralPattern("/*".scalars),
                    LiteralPattern("*/".scalars)
                    ]), in: child.range) {
                        resolvedNesting.append(CommentToken(range: match.range))
                }
            }
        }

        let structure = children.filter({ ¬($0 is UnidentifiedSyntaxElement) })
        children = structure + resolvedNesting

        // The rest is text.
        var text: [SyntaxElement] = []
        for child in children where child is UnidentifiedSyntaxElement {
            text.append(CommentText(range: child.range))
        }
        let other = children.filter({ ¬($0 is UnidentifiedSyntaxElement) })
        children = other + text
    }
}
