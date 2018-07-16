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

public class BlockCommentSyntax : TriviaSyntax {

    // MARK: - Class Properties

    internal class var openingDelimiter: TokenTriviaSyntax {
        return TokenTriviaSyntax(text: "/*", kind: .openingBlockCommentDelimiter)
    }
    private static var closingDelimiter: TokenTriviaSyntax {
        return TokenTriviaSyntax(text: "*/", kind: .closingBlockCommentDelimiter)
    }

    internal class var contentKind: TriviaTokenKind {
        return .commentText
    }

    // MARK: - Initialization

    internal init(source: String) {
        let openingDelimiter = type(of: self).openingDelimiter
        let closingDelimiter = type(of: self).closingDelimiter

        var block = source
        block.removeFirst(openingDelimiter.text.count)
        self.openingDelimiter = openingDelimiter
        var opening: [TriviaSyntax] = [openingDelimiter]

        block.removeLast(closingDelimiter.text.count)
        self.closingDelimiter = closingDelimiter
        var closing: [TriviaSyntax] = [closingDelimiter]

        if block.last == " " {
            block.removeLast()
            let indent = TokenTriviaSyntax(text: " ", kind: .whitespace)
            self.closingDelimiterIndentation = indent
            closing.prepend(indent)
        } else {
            self.closingDelimiterIndentation = nil
        }

        if block.first == "\n" {
            block.removeFirst()
            let margin = TokenTriviaSyntax(text: "\n", kind: .newlines)
            self.openingVerticalMargin = margin
            opening.append(margin)
        } else {
            self.openingVerticalMargin = nil
        }
        if block.last == "\n" {
            block.removeLast()
            let margin = TokenTriviaSyntax(text: "\n", kind: .newlines)
            self.closingVerticalMargin = margin
            closing.prepend(margin)
        } else {
            self.closingVerticalMargin = nil
        }

        let content = TokenTriviaSyntax(text: block, kind: type(of: self).contentKind)
        self.content = content
        super.init(children: opening + [content] + closing)
    }

    // MARK: - Properties

    /// The opening delimiter.
    public let openingDelimiter: TokenTriviaSyntax

    /// The opening vertical margin (a possible newline between the delimiter and the content).
    public let openingVerticalMargin: TokenTriviaSyntax?

    /// The content.
    public let content: TokenTriviaSyntax

    /// The closing vertical margin (a possible newline between the delimiter and the content).
    public let closingVerticalMargin: TokenTriviaSyntax?

    /// The indentation of the closing delimiter (a possible space preceding it).
    public let closingDelimiterIndentation: TokenTriviaSyntax?

    /// The closing delimiter.
    public let closingDelimiter: TokenTriviaSyntax
}
