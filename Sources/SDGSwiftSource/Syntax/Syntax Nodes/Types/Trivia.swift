/*
 Trivia.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SwiftSyntax

  import SDGSwift

  extension Trivia {

    // MARK: - Properties

    /// The source code of the trivia.
    public func source() -> String {
      return map({ $0.text }).joined()
    }

    // MARK: - Location

    /// Returns the lower bound of the trivia.
    ///
    /// - Parameters:
    ///     - context: The trivia’s context.
    public func lowerBound(in context: TriviaContext) -> String.ScalarOffset {
      if context.leading {
        return context.token.lowerTriviaBound(in: context.tokenContext)
      } else {
        return context.token.upperSyntaxBound(in: context.tokenContext)
      }
    }

    /// Returns the upper bound of the trivia.
    ///
    /// - Parameters:
    ///     - context: The trivia’s context.
    public func upperBound(in context: TriviaContext) -> String.ScalarOffset {
      if context.leading {
        return context.token.lowerSyntaxBound(in: context.tokenContext)
      } else {
        return context.token.upperTriviaBound(in: context.tokenContext)
      }
    }

    /// Returns the range of the trivia.
    ///
    /// - Parameters:
    ///     - context: The trivia’s context.
    public func range(in context: TriviaContext) -> Range<String.ScalarOffset> {
      return lowerBound(in: context)..<upperBound(in: context)
    }

    // MARK: - Syntax Tree

    /// Returns the token to which the trivia is attached.
    ///
    /// - Parameters:
    ///     - context: The trivia’s context.
    public func parentToken(context: TriviaContext) -> TokenSyntax? {
      return context.token
    }

    /// Returns the last piece of trivia.
    public func last() -> TriviaPiece? {
      var result: TriviaPiece?
      for element in self {
        result = element
      }
      return result
    }

    /// Returns the trivia group immediately preceding this one.
    ///
    /// - Parameters:
    ///     - context: The trivia’s context.
    public func previousTrivia(context: TriviaContext) -> Trivia? {
      return context.token.previousToken()?.trailingTrivia
    }

    /// Returns the trivia group immediately following this one.
    ///
    /// - Parameters:
    ///     - context: The trivia’s context.
    public func nextTrivia(context: TriviaContext) -> Trivia? {
      return context.token.nextToken()?.leadingTrivia
    }

    // MARK: - Syntax Highlighting

    internal func nestedSyntaxHighlightedHTML(
      internalIdentifiers: Set<String>,
      symbolLinks: [String: String]
    ) -> String {
      var result = ""
      for index in indices {
        let piece = self[index]

        let extended = piece.syntax(siblings: self, index: index)
        result += extended.nestedSyntaxHighlightedHTML(
          internalIdentifiers: internalIdentifiers,
          symbolLinks: symbolLinks
        )
      }
      return result
    }
  }
#endif
