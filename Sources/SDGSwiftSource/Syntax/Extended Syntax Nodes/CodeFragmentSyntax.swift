/*
 CodeFragmentSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGMathematics
import SDGCollections

import SwiftSyntax
import enum SDGHTML.HTML

/// A fragment of code used in documentation.
public class CodeFragmentSyntax : ExtendedSyntax {

    internal init(range: Range<String.ScalarView.Index>, in source: String, isSwift: Bool?) {
        self.isSwift = isSwift

        self.context = source
        self.range = range
        let fragmentSource = String(source.scalars[range])
        let fragment = ExtendedTokenSyntax(text: fragmentSource, kind: .source)
        self.source = fragment

        super.init(children: [fragment])
    }

    // MARK: - Properties

    internal let isSwift: Bool?
    /// The unparsed source code of the fragment.
    public let source: ExtendedTokenSyntax

    internal let context: String

    internal let range: Range<String.ScalarView.Index>
    internal var offset: Int {
        return context.scalars.distance(from: context.scalars.startIndex, to: range.lowerBound)
    }

    /// The syntax of the source code contained in this token.
    public func syntax() throws -> [SyntaxFragment]? {
        if isSwift == true {
            let parsed = try SyntaxParser.parse(context)
            return syntax(of: parsed)
        } else if isSwift == false {
            return nil
        } else {
            if let parsed = try? SyntaxParser.parse(context) {
                return syntax(of: parsed)
            } else { // @exempt(from: tests) Reachability unknown. (SwiftSyntax no longer throws on invalid syntax.)
                return nil // @exempt(from: tests)
            }
        }
    }

    private func syntax(of node: Syntax) -> [SyntaxFragment] {
        let location = node.triviaRange(in: SyntaxContext(fragmentContext: context, fragmentOffset: 0, parentContext: nil))
        if location.overlaps(range) {
            if location ⊆ range {
                return [.syntax(node)]
            } else {
                if let token = node as? TokenSyntax {
                    var position = location.lowerBound
                    var result = syntax(of: token.leadingTrivia, startingAt: position)
                    position = context.scalars.index(position, offsetBy: token.leadingTrivia.source().scalars.count)

                    let end = context.scalars.index(position, offsetBy: token.text.scalars.count)
                    if position ..< end ⊆ range {
                        result.append(.syntax(token.withLeadingTrivia([]).withTrailingTrivia([])))
                    }
                    position = end

                    result.append(contentsOf: syntax(of: token.trailingTrivia, startingAt: position))

                    return result
                } else {
                    return Array(node.children.map({ syntax(of: $0) }).joined())
                }
            }
        } else {
            return []
        }
    }

    private func syntax(of trivia: Trivia, startingAt position: String.ScalarView.Index) -> [SyntaxFragment] {
        var location = position
        var result: [SyntaxFragment] = []
        for index in trivia.indices {
            let piece = trivia[index]
            result.append(contentsOf: syntax(of: piece, startingAt: location, siblings: trivia, index: index))
            location = context.scalars.index(location, offsetBy: piece.text.scalars.count)
        }
        return result
    }

    private func syntax(of trivia: TriviaPiece, startingAt position: String.ScalarView.Index, siblings: Trivia, index: Trivia.Index) -> [SyntaxFragment] {
        let location = position ..< context.scalars.index(position, offsetBy: trivia.text.scalars.count)
        if location.overlaps(range) {
            if location ⊆ range {
                return [.trivia(trivia, siblings, index)]
            } else {
                switch trivia {
                case .spaces, .tabs, .verticalTabs, .formfeeds, .newlines, .carriageReturns, .carriageReturnLineFeeds, .backticks, .lineComment, .docLineComment, .garbageText: // @exempt(from: tests) Unreachable. Never multiline; never split between multiple fragments.
                    return [.trivia(trivia, siblings, index)]
                case .blockComment, .docBlockComment:
                    let extended = trivia.syntax(siblings: siblings, index: index)

                    let text = trivia.text
                    var startOffset = 0
                    var endOffset = text.scalars.count
                    if location.lowerBound < range.lowerBound {
                        startOffset += context.scalars.distance(from: location.lowerBound, to: range.lowerBound)
                    }
                    if location.upperBound > range.upperBound {
                        endOffset −= context.scalars.distance(from: range.upperBound, to: location.upperBound)
                    }

                    let fragment = FragmentSyntax(scalarOffsets: startOffset ..< endOffset, in: extended)
                    return [.extendedSyntax(fragment)]
                }
            }
        } else {
            return []
        }
    }

    // MARK: - ExtendedSyntax

    internal func unknownSyntaxHighlightedHTML(internalIdentifiers: Set<String>, symbolLinks: [String: String]) -> String {
        var source: String

        if context == self.source.text, // Not part of something bigger.
            let selectorLink = symbolLinks[context] {
            source = HTML.escapeTextForCharacterData(context)

            func mark(_ searchTerm: String, as class: String) {
                source.replaceMatches(for: searchTerm, with: "</span><span class=\u{22}\(`class`)\u{22}>\(searchTerm)</span><span class=\u{22}internal identifier\u{22}>")
            }
            mark("(", as: "punctuation")
            mark(")", as: "punctuation")
            mark(":", as: "punctuation")
            mark("_", as: "keyword")

            source.prepend(contentsOf: "<span class=\u{22}internal identifier\u{22}>")
            source.append(contentsOf: "</span>")

            source.prepend(contentsOf: "<a href=\u{22}\(HTML.escapeTextForAttribute(selectorLink))\u{22}>")
            source.append(contentsOf: "</a>")
        } else {
            source = super.nestedSyntaxHighlightedHTML(internalIdentifiers: internalIdentifiers, symbolLinks: symbolLinks)
        }

        source.prepend(contentsOf: "<span class=\u{22}code\u{22}>")
        source.append(contentsOf: "</span>")
        return source
    }

    internal override func nestedSyntaxHighlightedHTML(internalIdentifiers: Set<String>, symbolLinks: [String: String]) -> String {

        if context == self.source.text, // Not part of something bigger.
            symbolLinks[context] ≠ nil {
            return unknownSyntaxHighlightedHTML(internalIdentifiers: internalIdentifiers, symbolLinks: symbolLinks)
        }

        if let syntax = try? self.syntax(),
            syntax.map({ $0.source() }).joined() == text {
            return String(syntax.map({ $0.nestedSyntaxHighlightedHTML(internalIdentifiers: internalIdentifiers, symbolLinks: symbolLinks) }).joined())
        } else {
            return unknownSyntaxHighlightedHTML(internalIdentifiers: internalIdentifiers, symbolLinks: symbolLinks)
        }
    }
}
