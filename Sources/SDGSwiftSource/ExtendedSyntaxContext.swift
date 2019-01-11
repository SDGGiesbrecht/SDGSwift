/*
 ExtendedSyntaxContext.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public indirect enum ExtendedSyntaxContext {

    // MARK: - Cases

    case trivia(TriviaPiece, context: TriviaPieceContext)
    case token(TokenSyntax, context: SyntaxContext)
    case fragment(CodeFragmentSyntax, context: ExtendedSyntaxContext, offset: Int)

    // MARK: - Properties

    internal var source: String {
        switch self {
        case .trivia(_, context: let context):
            return context.source
        case .token(_, context: let context):
            return context.fragmentContext
        case .fragment(_, context: let context, offset: _):
            return context.source
        }
    }
}
