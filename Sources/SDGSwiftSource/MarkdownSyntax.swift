/*
 MarkdownSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow
import SDGLogic
import SDGCollections
import SDGCMarkShims

public class MarkdownSyntax : ExtendedSyntax {

    // MARK: - Initialization

    internal init(node: cmark_node, in documentation: String, precedingChildren: [ExtendedSyntax] = [], followingChildren: [ExtendedSyntax] = []) {

        var children: [ExtendedSyntax] = []
        if var child = cmark_node_first_child(node) {
            children.append(child.syntax(in: documentation))
            let end = child.upperBound(in: documentation)
            while let next = cmark_node_next(child) {
                let start = next.lowerBound(in: documentation)
                if start ≠ end {
                    var trivia = String(documentation.scalars[end ..< start])
                    while let first = trivia.scalars.first {
                        if first ∈ CharacterSet.whitespaces {
                            var whitespace = String(first)
                            trivia.scalars.removeFirst()
                            while let another = trivia.scalars.first,
                                another ∈ CharacterSet.whitespaces {
                                    whitespace.scalars.append(trivia.scalars.removeFirst())
                            }
                            children.append(ExtendedTokenSyntax(text: whitespace, kind: .whitespace))
                        } else if first ∈ CharacterSet.newlines {
                            var newlines = String(first)
                            trivia.scalars.removeFirst()
                            while let another = trivia.scalars.first,
                                another ∈ CharacterSet.newlines {
                                    newlines.scalars.append(trivia.scalars.removeFirst())
                            }
                            children.append(ExtendedTokenSyntax(text: newlines, kind: .newlines))
                        } else {
                            if BuildConfiguration.current == .debug {
                                print("Unexpected markdown trivia: \(first)")
                                break
                            }
                        }
                    }
                }
                children.append(next.syntax(in: documentation))
                child = next
            }
        }
        super.init(children: precedingChildren + children + followingChildren)
    }

    internal override init(children: [ExtendedSyntax]) {
        super.init(children: children)
    }
}
