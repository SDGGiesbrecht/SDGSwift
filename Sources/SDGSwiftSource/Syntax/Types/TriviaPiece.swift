/*
 TriviaPiece.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGSwiftLocalizations

extension TriviaPiece {

    public func syntax(siblings: Trivia, index: Trivia.Index) -> ExtendedSyntax {
        switch self {
        case .spaces, .tabs:
            return ExtendedTokenSyntax(text: text, kind: .whitespace)
        case .verticalTabs, .formfeeds, .newlines, .carriageReturns, .carriageReturnLineFeeds:
            return ExtendedTokenSyntax(text: text, kind: .newlines)
        case .backticks:
            return ExtendedTokenSyntax(text: text, kind: .escape)
        case .lineComment:
            return LineDeveloperCommentSyntax(source: text, siblings: siblings, index: index)
        case .blockComment:
            return BlockDeveloperCommentSyntax(source: text)
        case .docLineComment:
            return LineDocumentationSyntax(source: text, siblings: siblings, index: index)
        case .docBlockComment:
            return BlockDocumentationSyntax(source: text)
        case .garbageText:
            return ExtendedTokenSyntax(text: text, kind: .source) // @exempt(from: tests)
        }
    }

    public var text: String {
        var result = ""
        write(to: &result)
        return result
    }
}
