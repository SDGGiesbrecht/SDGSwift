/*
 TriviaPieceContext.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SwiftSyntax

/// The context of a trivia piece.
public indirect enum TriviaPieceContext {

    // MARK: - Cases

    case _trivia(Trivia, index: Trivia.Index, parent: TriviaContext)
    case _fragment(CodeFragmentSyntax, context: ExtendedSyntaxContext, offset: Int)

    // MARK: - Properties

    internal var source: String {
        switch self {
        case ._trivia(_, index: _, parent: let parent):
            return parent.tokenContext.fragmentContext
        case ._fragment(_, context: let context, offset: _):
            return context.source
        }
    }
}
