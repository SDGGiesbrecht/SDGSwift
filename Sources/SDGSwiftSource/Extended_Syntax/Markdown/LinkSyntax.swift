/*
 LinkSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections

import SDGCMarkShims

public class LinkSyntax : MarkdownSyntax {

    internal init(node: cmark_node, in documentation: String) {

        let openingDelimiter = ExtendedTokenSyntax(text: "[", kind: .linkDelimiter)
        self.openingDelimiter = openingDelimiter

        let medialDelimiter = ExtendedTokenSyntax(text: "](", kind: .linkDelimiter)
        self.medialDelimiter = medialDelimiter

        let url = ExtendedTokenSyntax(text: String(cString: cmark_node_get_url(node)), kind: .linkURL)
        self.url = url

        let closingDelimiter = ExtendedTokenSyntax(text: ")", kind: .linkDelimiter)
        self.closingDelimiter = closingDelimiter

        super.init(node: node, in: documentation, precedingChildren: [
            openingDelimiter
            ], followingChildren: [
                medialDelimiter,
                url,
                closingDelimiter
            ])

        let accountedFor: Set<ExtendedTokenKind> = [.linkDelimiter, .linkURL]
        contents = children.filter { child in
            if let token = (child as? ExtendedTokenSyntax)?.kind,
                token ∉ accountedFor {
                return true
            }
            return false
        }
    }

    // MARK: - Properties

    public let openingDelimiter: ExtendedTokenSyntax

    public private(set) var contents: [ExtendedSyntax] = []

    public let medialDelimiter: ExtendedTokenSyntax

    public let url: ExtendedTokenSyntax

    public let closingDelimiter: ExtendedTokenSyntax

    // MARK: - ExtendedSyntax

    internal override var renderedHtmlElement: String? {
        return "a"
    }

    internal override var renderedHTMLAttributes: [String: String] {
        return [
            "href": url.text
        ]
    }
}
