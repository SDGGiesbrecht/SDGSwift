/*
 ImageSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections

import SDGCMarkShims

public class ImageSyntax : MarkdownSyntax {

    internal init(node: cmark_node, in documentation: String) {

        let imageDelimiter = ExtendedTokenSyntax(text: "!", kind: .imageDelimiter)
        self.imageDelimiter = imageDelimiter

        let openingDelimiter = ExtendedTokenSyntax(text: "[", kind: .linkDelimiter)
        self.openingDelimiter = openingDelimiter

        let medialDelimiter = ExtendedTokenSyntax(text: "](", kind: .linkDelimiter)
        self.medialDelimiter = medialDelimiter

        let url = ExtendedTokenSyntax(text: String(cString: cmark_node_get_url(node)), kind: .linkURL)
        self.url = url

        let closingDelimiter = ExtendedTokenSyntax(text: ")", kind: .linkDelimiter)
        self.closingDelimiter = closingDelimiter

        super.init(node: node, in: documentation, precedingChildren: [
            imageDelimiter,
            openingDelimiter
            ], followingChildren: [
                medialDelimiter,
                url,
                closingDelimiter
            ])

        let accountedFor: Set<ExtendedTokenKind> = [.imageDelimiter, .linkDelimiter, .linkURL]
        contents = children.filter { child in
            if let token = (child as? ExtendedTokenSyntax)?.kind,
                token ∉ accountedFor {
                return true
            }
            return false
        }
    }

    // MARK: - Properties

    public let imageDelimiter: ExtendedTokenSyntax

    public let openingDelimiter: ExtendedTokenSyntax

    public private(set) var contents: [ExtendedSyntax] = []

    public let medialDelimiter: ExtendedTokenSyntax

    public let url: ExtendedTokenSyntax

    public let closingDelimiter: ExtendedTokenSyntax

    // MARK: - ExtendedSyntax

    public override func renderedHTML(localization: String, internalIdentifiers: Set<String>, symbolLinks: [String: String]) -> String {
        let alternate = HTML.escape(contents.map({ $0.text }).joined())
        return "<img alt=\u{22}" + alternate + "\u{22} src=\u{22}" + HTML.escapeAttribute(url.text) + "\u{22}>"
    }
}
