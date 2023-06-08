/*
 TriviaContext.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SwiftSyntax

  /// The context of a trivia group.
  public struct TriviaContext {

    // MARK: - Initialization

    internal init(token: TokenSyntax, tokenContext: SyntaxContext, leading: Bool) {
      self.token = token
      self.tokenContext = tokenContext
      self.leading = leading
    }

    // MARK: - Properties

    internal let token: TokenSyntax
    internal let tokenContext: SyntaxContext
    internal let leading: Bool
  }
