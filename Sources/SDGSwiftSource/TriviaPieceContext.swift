/*
 TriviaPieceContext.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public indirect enum TriviaPieceContext {

    // MARK: - Cases

    case trivia(Trivia, index: Trivia.Index, parent: TriviaContext)
    case fragment(CodeFragmentSyntax, context: ExtendedSyntaxContext, offset: Int)

    // MARK: - Properties

    internal var source: String {
        switch self {
        case .trivia(_, index: _, parent: let parent):
            return parent.tokenContext.fragmentContext
        case .fragment(let fragment, context: _, offset: _):
            return fragment.context
        }
    }
}
