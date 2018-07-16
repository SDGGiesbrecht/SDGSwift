/*
 TextFreedomHighlighter.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLocalization

import SDGSwiftSource

class TextFreedomHighlighter : Highlighter {

    static var targetTestFreedom: SyntaxElement.TextFreedom = .arbitrary

    override func shouldHighlight(_ token: TokenSyntax) -> Bool {
        return token.tokenKind.textFreedom == type(of: self).targetTestFreedom
    }
    override func shouldHighlight(_ trivia: TokenTriviaSyntax) -> Bool {
        return trivia.kind.textFreedom == type(of: self).targetTestFreedom
    }
}
