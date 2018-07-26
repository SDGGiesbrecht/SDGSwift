/*
 CodeBlockSyntax.swift

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

import SDGSwiftSyntaxShims
import SDGCMarkShims

public class CodeBlockSyntax : MarkdownSyntax {

    // MARK: - Initialization

    internal init(node: cmark_node, in documentation: String) {
        var precedingChildren: [ExtendedSyntax] = []
        var followingChildren: [ExtendedSyntax] = []

        var contents = String(documentation.scalars[node.lowerBound(in: documentation) ..< node.upperBound(in: documentation)])

        contents.removeFirst(3)
        let openingDelimiter = ExtendedTokenSyntax(text: "```", kind: .codeDelimiter)
        self.openingDelimiter = openingDelimiter
        precedingChildren.append(openingDelimiter)

        contents.removeLast(3)
        let closingDelimiter = ExtendedTokenSyntax(text: "```", kind: .codeDelimiter)
        self.closingDelimiter = closingDelimiter
        followingChildren.prepend(closingDelimiter)

        if let language = contents.scalars.prefix(upTo: CharacterSet.newlinePattern) { // @exempt(from: tests) False coverage result in Xcode 9.4.1.
            let token = ExtendedTokenSyntax(text: String(language.contents), kind: .language)
            contents.scalars.removeSubrange(language.range)
            self.language = token
            precedingChildren.append(token)
        } else {
            language = nil
        }

        let openingVerticalMargin = ExtendedTokenSyntax(text: String(contents.removeFirst()), kind: .newlines)
        self.openingVerticalMargin = openingVerticalMargin
        precedingChildren.append(openingVerticalMargin)

        let closingVerticalMargin = ExtendedTokenSyntax(text: String(contents.removeLast()), kind: .newlines)
        self.closingVerticalMargin = closingVerticalMargin
        followingChildren.prepend(closingVerticalMargin)

        let source = CodeFragmentSyntax(range: contents.bounds, in: contents)
        self.source = source

        super.init(node: node, in: documentation, precedingChildren: precedingChildren + [source] + followingChildren)
    }

    // MARK: - Properties

    /// The opening delimiter.
    public let openingDelimiter: ExtendedTokenSyntax

    /// The opening vertical margin (the newline between the delimiter and the content).
    public let openingVerticalMargin: ExtendedTokenSyntax

    /// The source language identifier.
    public let language: ExtendedTokenSyntax?

    /// The source code.
    public let source: CodeFragmentSyntax

    /// The closing vertical margin (the newline between the delimiter and the content).
    public let closingVerticalMargin: ExtendedTokenSyntax

    /// The closing delimiter.
    public let closingDelimiter: ExtendedTokenSyntax
}
