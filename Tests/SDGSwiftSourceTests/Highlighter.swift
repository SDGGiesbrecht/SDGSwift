/*
 Highlighter.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGPersistenceTestUtilities

import SDGSwiftSource

class Highlighter : SyntaxScanner {

    func shouldHighlight(_ token: TokenSyntax) -> Bool {
        return false
    }

    func shouldHighlight(_ trivia: ExtendedTokenSyntax) -> Bool {
        return false
    }

    @discardableResult func compare(syntax: Syntax, parsedFrom url: URL, againstSpecification name: String, overwriteSpecificationInsteadOfFailing: Bool, file: StaticString = #file, line: UInt = #line) throws -> String {
        let result = try highlight(syntax)

        let specification = afterDirectory.appendingPathComponent(name).appendingPathComponent(url.deletingPathExtension().lastPathComponent).appendingPathExtension("txt")

        SDGPersistenceTestUtilities.compare(result, against: specification, overwriteSpecificationInsteadOfFailing: overwriteSpecificationInsteadOfFailing, file: file, line: line)
        return result
    }

    private var highlighted = ""
    private func highlight(_ source: Syntax) throws -> String {
        highlighted = ""
        _ = try scan(source)
        return highlighted
    }

    override func visit(_ node: Syntax) -> Bool {
        if let token = node as? TokenSyntax {
            highlighted += shouldHighlight(token) ? highlight(token.text) : token.text
        }
        return true
    }

    override func visit(_ node: ExtendedSyntax) -> Bool {
        if let token = node as? ExtendedTokenSyntax {
            highlighted += shouldHighlight(token) ? highlight(token.text) : token.text
        }
        return true
    }

    private func highlight(_ source: String) -> String {
        return source.clusters.map({ "\($0)" + "\u{332}" }).joined()
    }
}
