/*
 ListEntrySyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGCollections
import SDGText

public class ListEntrySyntax : MarkdownSyntax {

    // From https://github.com/apple/swift/blob/master/include/swift/Markup/SimpleFields.def
    private static let casedCallouts: [String] = [
        "Parameters",

        "Attention",
        "Author",
        "Authors",
        "Bug",
        "Complexity",
        "Copyright",
        "Date",
        "Experiment",
        "Important",
        "Invariant",
        "LocalizationKey",
        "MutatingVariant",
        "NonmutatingVariant",
        "Note",
        "Postcondition",
        "Precondition",
        "Remark",
        "Remarks",
        "Returns",
        "Requires",
        "See",
        "Since",
        "Tag",
        "ToDo",
        "Throws",
        "Version",
        "Warning",
        "Keyword",
        "Recommended",
        "RecommendedOver"
    ]
    private static let allCallouts = Array([ListEntrySyntax.casedCallouts, ListEntrySyntax.casedCallouts.map({ $0.lowercased() })].joined())

    internal init(node: cmark_node, in documentation: String) {
        var precedingChildren: [ExtendedSyntax] = []

        let contentStart = node.lowerBound(in: documentation)
        let contentEnd = node.upperBound(in: documentation)
        if let whitespace = documentation.scalars.firstMatch(for: RepetitionPattern(ConditionalPattern({ $0 ∈ CharacterSet.whitespaces }), count: 1 ..< Int.max), in: contentStart ..< contentEnd) {
            // @exempt(from: tests) False coverage result in Xcode 9.4.1.

            let bullet = ExtendedTokenSyntax(text: String(documentation.scalars[contentStart ..< whitespace.range.lowerBound]), kind: .bullet)
            self.bullet = bullet
            precedingChildren.append(bullet)

            let space = ExtendedTokenSyntax(text: String(documentation.scalars[whitespace.range]), kind: .whitespace)
            self.indent = space
            precedingChildren.append(space)
        } else {
            bullet = nil
            indent = nil
        }

        super.init(node: node, in: documentation, precedingChildren: precedingChildren)

        // Detect callouts.
        search: for index in children.indices {
            let child = children[index] // @exempt(from: tests) False coverage result in Xcode 9.4.1.
            if let token = child as? ExtendedTokenSyntax,
                token.kind ∈ Set([.bullet, .whitespace]) {
                continue
            } else if let paragraph = child as? ParagraphSyntax,
                let token = paragraph.children.first as? ExtendedTokenSyntax,
                token.kind == .documentationText {

                for callout in ListEntrySyntax.allCallouts {
                    if token.text.hasPrefix(callout + ": ") {
                        paragraph.children.removeFirst()
                        let callout = ExtendedTokenSyntax(text: callout, kind: .callout)
                        let colon = ExtendedTokenSyntax(text: ":", kind: .colon)
                        var remainder = token.text
                        remainder.scalars.removeFirst(callout.text.scalars.count + colon.text.scalars.count)
                        let remainderSyntax = ExtendedTokenSyntax(text: remainder, kind: .documentationText)
                        paragraph.children.prepend(remainderSyntax)
                        children.insert(contentsOf: [callout, colon], at: index)
                    }
                }
            } else {
                break
            }
        }
    }

    /// The bullet.
    public let bullet: ExtendedTokenSyntax?

    /// The indent after the bullet.
    public let indent: ExtendedTokenSyntax?
}
