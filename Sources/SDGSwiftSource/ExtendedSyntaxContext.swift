/*
 ExtendedSyntaxContext.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public enum ExtendedSyntaxContext {

    // MARK: - Cases

    case trivia(TriviaPieceContext)
    case token(TokenSyntax, context: SyntaxContext)
    case fragment(offset: Int, parent: SyntaxContext)

    // MARK: - Properties

    internal var totalOffset: Int {
        #warning("Not implemented yet.")
        return 0
    }
}
