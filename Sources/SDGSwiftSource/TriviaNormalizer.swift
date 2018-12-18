/*
 TriviaNormalizer.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

internal class TriviaNormalizer : SyntaxRewriter {
    override func visit(_ token: TokenSyntax) -> Syntax {
        var token = token
        if ¬token.leadingTrivia.isEmpty {
            token = token.withLeadingTrivia(Trivia(pieces: [.spaces(1)]))
        }
        if ¬token.trailingTrivia.isEmpty {
            token = token.withTrailingTrivia(Trivia(pieces: [.spaces(1)]))
        }
        return token
    }
}
