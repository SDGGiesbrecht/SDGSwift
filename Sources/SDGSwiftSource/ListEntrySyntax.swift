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

    internal init(node: cmark_node, in documentation: String) {
        var precedingChildren: [ExtendedSyntax] = []

        let contentStart = node.lowerBound(in: documentation)
        let contentEnd = node.upperBound(in: documentation)
        if let whitespace = documentation.scalars.firstMatch(for: RepetitionPattern(ConditionalPattern({ $0 ∈ CharacterSet.whitespaces }), count: 1 ..< Int.max), in: contentStart ..< contentEnd) {

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
    }

    /// The bullet.
    public let bullet: ExtendedTokenSyntax?

    /// The indent after the bullet.
    public let indent: ExtendedTokenSyntax?
}
