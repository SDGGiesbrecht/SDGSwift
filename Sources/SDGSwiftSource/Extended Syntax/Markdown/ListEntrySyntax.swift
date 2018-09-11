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

import SDGLogic
import SDGCollections
import SDGText

public class ListEntrySyntax : MarkdownSyntax {

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
                token.kind == .documentationText,
                let colonMatch = token.text.firstMatch(for: ":") {

                var possibleCalloutText = String(token.text[..<colonMatch.range.lowerBound])

                var space: String?
                var parameterName: String?
                if possibleCalloutText.lowercased().hasPrefix("parameter "),
                    let spaceMatch = possibleCalloutText.firstMatch(for: " "),
                    spaceMatch.range.upperBound ≠ possibleCalloutText.endIndex {
                    space = String(spaceMatch.contents)
                    parameterName = String(possibleCalloutText[spaceMatch.range.upperBound...])
                    possibleCalloutText = String(possibleCalloutText[..<spaceMatch.range.lowerBound])
                }

                if Callout(possibleCalloutText) ≠ nil {

                    paragraph.children.removeFirst()
                    let callout = ExtendedTokenSyntax(text: possibleCalloutText, kind: .callout)
                    var scalarCount = callout.text.scalars.count

                    var spaceSyntax: ExtendedTokenSyntax?
                    if let spaceString = space {
                        spaceSyntax = ExtendedTokenSyntax(text: spaceString, kind: .whitespace)
                        scalarCount += spaceString.scalars.count
                    }
                    var parameterSyntax: ExtendedTokenSyntax?
                    if let parameter = parameterName {
                        parameterSyntax = ExtendedTokenSyntax(text: parameter, kind: .parameter)
                        scalarCount += parameter.scalars.count
                    }

                    let colon = ExtendedTokenSyntax(text: ":", kind: .colon)
                    scalarCount += colon.text.scalars.count

                    var remainder = token.text
                    remainder.scalars.removeFirst(scalarCount)
                    let remainderSyntax = ExtendedTokenSyntax(text: remainder, kind: .documentationText)
                    paragraph.children.prepend(remainderSyntax)
                    children.insert(contentsOf: [callout, colon], at: index)

                    let colonIndex = children.index(where: { $0 === colon })!
                    let contentsIndex = children.index(after: colonIndex) // @exempt(from: tests) False coverage result in Xcode 9.4.1)

                    asCallout = CalloutSyntax(
                        bullet: self.bullet,
                        indent: self.indent,
                        name: callout,
                        space: spaceSyntax,
                        parameterName: parameterSyntax,
                        colon: colon,
                        contents: Array(children[contentsIndex...]))

                    break
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

    // Storage if it is really a callout instead.
    internal var asCallout: CalloutSyntax?

    // MARK: - ExtendedSyntax

    internal override var renderedHtmlElement: String? {
        return "li"
    }
}
