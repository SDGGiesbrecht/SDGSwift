/*
 TriviaContext.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public struct TriviaContext {

    // MARK: - Initialization

    internal init(token: TokenSyntax, tokenContext: SyntaxContext, trailing: Bool) {
        self.token = token
        self.tokenContext = tokenContext
        self.trailing = trailing
    }

    // MARK: - Properties

    private let token: TokenSyntax
    private let tokenContext: SyntaxContext
    private let trailing: Bool
}
