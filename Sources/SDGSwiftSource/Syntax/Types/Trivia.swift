/*
 Trivia.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension Trivia {

    // MARK: - Properties

    public func source() -> String {
        return String(map({ $0.text }).joined())
    }

    // MARK: - Syntax Tree

    public func last() -> TriviaPiece? {
        var result: TriviaPiece?
        for element in self {
            result = element
        }
        return result
    }

    // MARK: - Syntax Highlighting

    internal func nestedSyntaxHighlightedHTML(internalIdentifiers: Set<String>, symbolLinks: [String: String]) -> String {
        var result = ""
        for index in indices {
            let piece = self[index]

            let extended = piece.syntax(siblings: self, index: index)
            result += extended.nestedSyntaxHighlightedHTML(internalIdentifiers: internalIdentifiers, symbolLinks: symbolLinks)
        }
        return result
    }
}
