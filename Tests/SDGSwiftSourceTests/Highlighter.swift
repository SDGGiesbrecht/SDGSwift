/*
 Highlighter.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

import SDGSwiftSource

class Highlighter : SyntaxRewriter {

    func shouldHighlight(_ token: TokenSyntax) -> Bool {
        return false
    }

    private var highlighted = ""
    func highlight(_ source: Syntax) -> String {
        highlighted = ""
        _ = visit(source)
        return highlighted
    }

    override func visit(_ node: TokenSyntax) -> Syntax {
        var text = node.text
        if shouldHighlight(node) {
            text = text.clusters.map({ "\($0)" + "\u{332}" }).joined()
        }
        highlighted += text

        return super.visit(node)
    }
}
