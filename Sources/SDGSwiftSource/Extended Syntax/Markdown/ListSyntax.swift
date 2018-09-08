/*
 ListSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public class ListSyntax : MarkdownSyntax {

    // MARK: - Initialization

    internal init(node: cmark_node, in documentation: String) {
        super.init(node: node, in: documentation)

        if let callout = children.first as? CalloutSyntax {
            asCallout = callout
        }
    }

    // Storage if it is really a callout instead.
    internal var asCallout: CalloutSyntax? = nil

    // MARK: - ExtendedSyntax

    internal override var renderedHtmlElement: String? {
        return "ul"
    }
}
