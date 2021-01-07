/*
 TriviaNormalizer.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.3.2, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(WASI) || os(tvOS) || os(iOS) || os(Android) || os(watchOS))
  import SDGLogic

  import SwiftSyntax

  internal class TriviaNormalizer: SyntaxRewriter {
    internal override func visit(_ token: TokenSyntax) -> Syntax {
      var token = token
      if ¬token.leadingTrivia.isEmpty {
        token = token.withLeadingTrivia(Trivia(pieces: [.spaces(1)]))
      }
      if ¬token.trailingTrivia.isEmpty {
        token = token.withTrailingTrivia(Trivia(pieces: [.spaces(1)]))
      }
      return Syntax(token)
    }
  }
#endif
