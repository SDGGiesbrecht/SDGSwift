/*
 Documentation.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGLogic
import SDGMathematics
import SDGCollections

/// Symbol documentation.
public class Documentation : DocumentationContainerElement {

    static let tokensAndWhitespace = (Whitespace.whitespaceCharacters ∪ Newline.newlineCharacters) ∪ Set<UnicodeScalar>(["/", "*"])

    internal init(range: Range<String.ScalarView.Index>, source: String, tokens: [SourceKit.PrimitiveToken]) {
        super.init(range: range, source: source, tokens: tokens)

        let singleLineToken = "///"
        let startToken = "\u{2F}**"
        let endToken = "*/"
        let commentSource = String(source.scalars[range])
        guard commentSource.scalars.count ≥ singleLineToken.scalars.count else {
            return // Invalid syntax. Leave it as unidentified. @exempt(from: tests)
        }

        // Find tokens.
        var tokens: [SyntaxElement] = []
        if source.scalars[range].hasPrefix(singleLineToken.scalars) {
            // Single line // @exempt(from: tests) False result in Xcode 9.3.
            parseIndents(in: source)
        } else {
            // Multiline
            guard let firstUnidentified = children.first(where: { $0 is UnidentifiedSyntaxElement }),
                firstUnidentified.range.lowerBound == range.lowerBound, // @exempt(from: tests) False coverage result in Xcode 9.3.
                String(source.scalars[firstUnidentified.range]).scalars.count ≥ startToken.scalars.count else {
                    return // Overlaps something else. Leave it as unidentified. @exempt(from: tests)
            }
            tokens.append(DocumentationToken(range: range.lowerBound ..< source.scalars.index(range.lowerBound, offsetBy: startToken.scalars.count)))
            guard let lastUnidentified = children.lazy.reversed().first(where: { $0 is UnidentifiedSyntaxElement }),
                lastUnidentified.range.upperBound == range.upperBound, // @exempt(from: tests) False coverage result in Xcode 9.3.
                String(source.scalars[lastUnidentified.range]).scalars.count ≥ endToken.scalars.count else {
                    return // Overlaps something else. Leave it as unidentified. @exempt(from: tests)
            }
            tokens.append(DocumentationToken(range: source.scalars.index(range.upperBound, offsetBy: −endToken.scalars.count) ..< range.upperBound))
        }

        let structure = children.filter({ ¬($0 is UnidentifiedSyntaxElement) })
        children = structure + tokens

        // From https://developer.apple.com/library/content/documentation/Xcode/Reference/xcode_markup_formatting_ref/index.html#//apple_ref/doc/uid/TP40016497-CH2-SW1

        // Callouts
        while let keyword = children.first(where: { $0 is Keyword }) as? Keyword {
            if let bullet = source.scalars.lastMatch(for: AlternativePatterns([ // @exempt(from: tests) False result in Xcode 9.3.
                LiteralPattern("\u{2D}".scalars),
                LiteralPattern("*".scalars),
                LiteralPattern("+".scalars)
                ]), in: range.lowerBound ..< keyword.range.lowerBound),
                let colon = source.scalars.firstMatch(for: ":".scalars, in: keyword.range.upperBound ..< range.upperBound) {
                var lineEnd = keyword.range.upperBound
                source.scalars.advance(&lineEnd, over: RepetitionPattern(ConditionalPattern({ $0 ∉ Newline.newlineCharacters })))
                // @exempt(from: tests) False result in Xcode 9.3.

                let callout: SyntaxElement
                let name = String(source.scalars[keyword.range]).lowercased()
                if name == "parameter" {
                    callout = DocumentationParameter(bullet: Punctuation(range: bullet.range), callout: keyword, colon: Punctuation(range: colon.range), end: lineEnd, in: source)
                } else {
                    callout = DocumentationCallout(bullet: Punctuation(range: bullet.range), callout: keyword, colon: Punctuation(range: colon.range), end: lineEnd, in: source)
                }

                let adjusted = children.filter { ¬$0.range.overlaps(callout.range) }
                children = adjusted + [callout] // @exempt(from: tests) False result in Xcode 9.3.
            }
        }

        // Code blocks
        func nextFence(after index: String.ScalarView.Index) -> Range<String.ScalarView.Index>? {
            for child in children where child is UnidentifiedSyntaxElement {
                if let fence = source.scalars.firstMatch(for: "```".scalars, in: child.range.clamped(to: index ..< range.upperBound)) {
                    return fence.range
                }
            }
            return nil
        }
        while let startFence = nextFence(after: range.lowerBound),
            let endFence = nextFence(after: startFence.upperBound) {
                let adjusted = children.filter { child in // @exempt(from: tests) False result in Xcode 9.3.
                    ¬child.range.overlaps(startFence.lowerBound ..< endFence.upperBound)
                }
                children = adjusted + [DocumentationCodeBlock(startFence: Punctuation(range: startFence), endFence: Punctuation(range: endFence), in: source)] // @exempt(from: tests) False result in Xcode 9.3.
        }

        // Headings
        func parseSingleLineElement(_ delimiter: SDGCollections.Pattern<Unicode.Scalar>, create: (_ delimiter: Punctuation, _ end: String.ScalarView.Index) -> SyntaxElement) {

            parseUnidentified(deepSearch: false) { unidentified in
                var elements: [SyntaxElement] = []
                for match in source.scalars[unidentified.range].matches(for: delimiter) {
                    let line = match.range.lines(in: source.lines).sameRange(in: source.scalars)
                    if ¬source.scalars[line.lowerBound ..< match.range.lowerBound].contains(where: { $0 ∉ Documentation.tokensAndWhitespace }) {

                        var end = match.range.upperBound
                        source.scalars.advance(&end, over: RepetitionPattern(ConditionalPattern({ $0 ∉ Newline.newlineCharacters })))
                        end.decrease(to: unidentified.range.upperBound)
                        elements.append(create(Punctuation(range: match.range), end))
                    }
                }
                return elements
            }
        }
        parseSingleLineElement(RepetitionPattern(LiteralPattern("#".scalars), count: 1 ... 3)) { DocumentationHeading(numberSigns: $0, end: $1, in: source) }

        func parseUnderlineElement(_ delimiter: Unicode.Scalar, create: (_ start: String.ScalarView.Index, _ delimiter: Punctuation) -> SyntaxElement) {

            func nextUnderline() -> (Range<String.ScalarView.Index>, String.ScalarView.Index)? {
                for child in children where child is UnidentifiedSyntaxElement {
                    if let underline = source.scalars.firstMatch(for: RepetitionPattern(LiteralPattern([delimiter]), count: 1 ..< Int.max), in: child.range),
                        source.scalars[underline.range.upperBound...].hasPrefix(ConditionalPattern({ $0 ∈ Newline.newlineCharacters })) {
                        let line = underline.range.lines(in: source.lines)
                        if line.lowerBound ≠ source.lines.startIndex {
                            var previousLine = source.lines.index(before: line.lowerBound).samePosition(in: source.scalars)
                            previousLine.increase(to: range.lowerBound)
                            if source.scalars[previousLine ..< underline.range.lowerBound].contains(where: { $0 ∉ Documentation.tokensAndWhitespace }) {
                                return (underline.range, previousLine)
                            }
                        }

                    }
                }
                return nil
            }
            while let underline = nextUnderline() {
                let adjusted = children.filter { ¬$0.range.overlaps(underline.1 ..< underline.0.upperBound) }
                children = adjusted + [create(underline.1, Punctuation(range: underline.0))]
            }
        }
        parseUnderlineElement("=") { DocumentationHeading(start: $0, underline: $1, in: source) }
        parseUnderlineElement("\u{2D}") { DocumentationHeading(start: $0, underline: $1, in: source) }

        // Asterism
        func parseAsterism(_ scalar: Unicode.Scalar) {
            parseUnidentified(deepSearch: false) { unidentified in
                var asterisms: [SyntaxElement] = []
                for match in source.scalars[unidentified.range].matches(for: CompositePattern([
                    LiteralPattern([scalar]),
                    RepetitionPattern(CompositePattern([
                        RepetitionPattern(ConditionalPattern({ $0 ∈ Whitespace.whitespaceCharacters })),
                        LiteralPattern([scalar])
                        ]), count: 2 ..< Int.max)
                    ])) {
                        let line = match.range.lines(in: source.lines).sameRange(in: source.scalars)
                        if ¬source.scalars[line.lowerBound ..< match.range.lowerBound].contains(where: { $0 ∉ Documentation.tokensAndWhitespace }) ∧ ¬source.scalars[match.range.upperBound ..< line.upperBound].contains(where: { $0 ∉ Documentation.tokensAndWhitespace }) {
                            asterisms.append(DocumentationAsterism(range: match.range))
                        }
                }
                return asterisms
            }
        }
        parseAsterism("*")
        parseAsterism("\u{2D}")
        parseAsterism("_")

        // List element
        parseSingleLineElement(LiteralPattern("\u{2D}".scalars)) { DocumentationListElement(bullet: $0, end: $1, in: source) }
        parseSingleLineElement(LiteralPattern("*".scalars)) { DocumentationListElement(bullet: $0, end: $1, in: source) }
        parseSingleLineElement(LiteralPattern("+".scalars)) { DocumentationListElement(bullet: $0, end: $1, in: source) }
        parseSingleLineElement(CompositePattern([
            RepetitionPattern(ConditionalPattern({ $0 ∈ Set<Unicode.Scalar>(["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]) }), count: 1 ..< Int.max),
            LiteralPattern(".".scalars)
            ])) { DocumentationListElement(bullet: $0, end: $1, in: source) }

        // Nestable
        parseChildren(in: source)

        // Fix grouped parameters.
        for index in children.indices {
            let child = children[index] // @exempt(from: tests) False result in Xcode 9.3.
            if let parameterList = child as? DocumentationCallout,
                String(source.scalars[parameterList.callout.range]).lowercased() == "parameters" {

                var entries: [DocumentationListElement] = []
                var interveningNewline = false
                for followingIndex in index + 1 ..< children.endIndex {
                    let following = children[followingIndex]
                    if following is Newline {
                        if interveningNewline {
                            break // Separated by two lines.
                        } else {
                            interveningNewline = true
                        }
                    } else if let listElement = following as? DocumentationListElement {
                        interveningNewline = false
                        entries.append(listElement)
                    } else if following is Whitespace ∨ following is DocumentationToken {
                        continue // Ignore.
                    } else {
                        break // Something else intervenes.
                    }
                }

                let list = DocumentationParameterList(callout: parameterList, parameters: entries, in: source)

                let adjusted = children.filter { ¬$0.range.overlaps(list.range) }
                children = adjusted + [list] // @exempt(from: tests) False result in Xcode 9.3.

                break // Can only be one.
            }
        }
    }
}
