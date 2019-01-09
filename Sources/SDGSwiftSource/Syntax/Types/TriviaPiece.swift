/*
 TriviaPiece.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGSwiftLocalizations

extension TriviaPiece {

    public var text: String {
        var result = ""
        write(to: &result)
        return result
    }

    // MARK: - Location

    public func lowerBound(in context: TriviaPieceContext) -> String.ScalarView.Index {
        switch context {
        case .trivia(let trivia, index: let index, parent: let parent):
            var location = trivia.lowerBound(in: parent)
            let source = parent.tokenContext.fragmentContext
            for predecessor in trivia.indices where predecessor < index {
                location = source.scalars.index(location, offsetBy: trivia[predecessor].text.scalars.count)
            }
            return location
        case .fragment(let code, context: let codeContext, offset: let offset):
            let fragmentLocation = code.lowerBound(in: codeContext)
            return codeContext.source.scalars.index(fragmentLocation, offsetBy: offset)
        }
    }

    private func upperBound(from lowerBound: String.ScalarView.Index, in context: TriviaPieceContext) -> String.ScalarView.Index {
        switch context {
        case .trivia(_, index: _, parent: let parent):
            let source = parent.tokenContext.fragmentContext
            return source.scalars.index(lowerBound, offsetBy: text.scalars.count)
        case .fragment(let code, context: let codeContext, offset: let offset):
            let fragmentLocation = code.lowerBound(in: codeContext)
            return codeContext.source.scalars.index(fragmentLocation, offsetBy: offset)
        }
    }
    public func upperBound(in context: TriviaPieceContext) -> String.ScalarView.Index {
        return upperBound(from: lowerBound(in: context), in: context)
    }

    public func range(in context: TriviaPieceContext) -> Range<String.ScalarView.Index> {
        let lowerBound = self.lowerBound(in: context)
        return lowerBound ..< upperBound(from: lowerBound, in: context)
    }

    // MARK: - Parsing

    public func syntax(siblings: Trivia, index: Trivia.Index) -> ExtendedSyntax {
        let result: ExtendedSyntax
        switch self {
        case .spaces, .tabs:
            result = ExtendedTokenSyntax(text: text, kind: .whitespace)
        case .verticalTabs, .formfeeds, .newlines, .carriageReturns, .carriageReturnLineFeeds:
            result = ExtendedTokenSyntax(text: text, kind: .newlines)
        case .backticks:
            result = ExtendedTokenSyntax(text: text, kind: .escape)
        case .lineComment:
            result = LineDeveloperCommentSyntax(source: text, siblings: siblings, index: index)
        case .blockComment:
            result = BlockDeveloperCommentSyntax(source: text)
        case .docLineComment:
            result = LineDocumentationSyntax(source: text, siblings: siblings, index: index)
        case .docBlockComment:
            result = BlockDocumentationSyntax(source: text)
        case .garbageText:
            result = ExtendedTokenSyntax(text: text, kind: .source) // @exempt(from: tests)
        }
        result.determinePositions()
        return result
    }
}
