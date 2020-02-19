/*
 SyntaxFactory.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftSyntax won’t compile.)
  import SwiftSyntax

  extension SyntaxFactory {

    /// Creates a token.
    ///
    /// - Parameters:
    ///     - kind: A token kind.
    ///     - leadingTrivia: Optional. Leading trivia.
    ///     - trailingTrivia: Optional. Trailing trivia.
    public static func makeToken(
      _ kind: TokenKind,
      leadingTrivia: Trivia = [],
      trailingTrivia: Trivia = []
    ) -> TokenSyntax {
      return SyntaxFactory.makeToken(
        kind,
        presence: .present,
        leadingTrivia: leadingTrivia,
        trailingTrivia: trailingTrivia
      )
    }
  }
#endif
