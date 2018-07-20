/*
 MarkdownSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGCMarkShims

public class MarkdownSyntax : ExtendedSyntax {

    // MARK: - Initialization

    internal init(node: cmark_node, in documentation: String, precedingChildren: [ExtendedSyntax] = [], followingChildren: [ExtendedSyntax] = []) {
        var children: [ExtendedSyntax] = []
        if var child = cmark_node_first_child(node) {
            children.append(child.syntax(in: documentation))
            while let next = cmark_node_next(child) {
                children.append(next.syntax(in: documentation))
                child = next
            }
        }
        super.init(children: precedingChildren + children + followingChildren)
    }
}
