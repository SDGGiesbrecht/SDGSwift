/*
 BlockCommentSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLocalization

public class BlockCommentSyntax : ExtendedSyntax {

    // MARK: - Class Properties

    internal class var openingDelimiter: ExtendedTokenSyntax {
        return ExtendedTokenSyntax(text: "/*", kind: .openingBlockCommentDelimiter)
    }
    private static var closingDelimiter: ExtendedTokenSyntax {
        return ExtendedTokenSyntax(text: "*/", kind: .closingBlockCommentDelimiter)
    }

    internal class var contentKind: ExtendedTokenKind {
        return .commentText
    }

    // MARK: - Initialization

    internal init(source: String) {
        let openingDelimiter = type(of: self).openingDelimiter
        let closingDelimiter = type(of: self).closingDelimiter

        var block = source
        block.removeFirst(openingDelimiter.text.count)
        self.openingDelimiter = openingDelimiter
        var opening: [ExtendedTokenSyntax] = [openingDelimiter]

        block.removeLast(closingDelimiter.text.count)
        self.closingDelimiter = closingDelimiter
        var closing: [ExtendedTokenSyntax] = [closingDelimiter]

        if block.last == " " {
            block.removeLast()
            let indent = ExtendedTokenSyntax(text: " ", kind: .whitespace)
            self.closingDelimiterIndentation = indent
            closing.prepend(indent)
        } else {
            self.closingDelimiterIndentation = nil
        }

        if block.first == "\n" {
            block.removeFirst()
            let margin = ExtendedTokenSyntax(text: "\n", kind: .newlines)
            self.openingVerticalMargin = margin
            opening.append(margin)
        } else {
            self.openingVerticalMargin = nil
        }
        if block.last == "\n" {
            block.removeLast()
            let margin = ExtendedTokenSyntax(text: "\n", kind: .newlines)
            self.closingVerticalMargin = margin
            closing.prepend(margin)
        } else {
            self.closingVerticalMargin = nil
        }

        let contentKind = type(of: self).contentKind
        let lines = block.lines.map { [ExtendedTokenSyntax(text: String($0.line), kind: contentKind)] }
        let content = Array(lines.joined(separator: [ExtendedTokenSyntax(text: "\n", kind: .newlines)]))
        self.content = content
        super.init(children: opening + content + closing)
    }

    // MARK: - Properties

    /// The opening delimiter.
    public let openingDelimiter: ExtendedTokenSyntax

    /// The opening vertical margin (a possible newline between the delimiter and the content).
    public let openingVerticalMargin: ExtendedTokenSyntax?

    /// The content.
    public let content: [ExtendedTokenSyntax]

    /// The closing vertical margin (a possible newline between the delimiter and the content).
    public let closingVerticalMargin: ExtendedTokenSyntax?

    /// The indentation of the closing delimiter (a possible space preceding it).
    public let closingDelimiterIndentation: ExtendedTokenSyntax?

    /// The closing delimiter.
    public let closingDelimiter: ExtendedTokenSyntax
}
