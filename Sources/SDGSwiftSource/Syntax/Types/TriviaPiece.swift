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

    public var text: String {
        var result = ""
        write(to: &result)
        return result
    }
}
