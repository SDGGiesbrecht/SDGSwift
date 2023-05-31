/*
 FunctionalSyntaxScanner.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SwiftSyntax

  /// A syntax scanner that can be used by providing closures instead of subclassing.
  public struct FunctionalSyntaxScanner: SyntaxScanner {

    // MARK: - Initialization

    /// Creates a syntax scanner with behaviour defined by the provided closures.
    ///
    /// See the corresponding methods of `SyntaxScanner` for documentation relating to each closure.
    ///
    /// - Parameters:
    ///     - checkSyntax: Optional. A closure which checks syntax nodes.
    ///     - checkExtendedSyntax: Optional. A closure which checks extended syntax nodes.
    ///     - checkTrivia: Optional. A closure which checks trivia.
    ///     - checkTriviaPiece: Optional. A closure which checks trivia pieces.
    ///     - shouldExtendToken: Optional. A closure which decides whether or not to parse the token’s extended syntax.
    ///     - shouldExtendFragment: Optional. A closure which decides whether or not to parse a code fragment.
    public init(
      checkSyntax: @escaping (_ node: Syntax, _ nodeContext: SyntaxContext) -> Bool = { _, _ in true
      },
      checkExtendedSyntax: @escaping (
        _ extendedNode: ExtendedSyntax, _ extendedNodeContext: ExtendedSyntaxContext
      ) -> Bool = { _, _ in true },
      checkTrivia: @escaping (_ trivia: Trivia, _ triviaContext: TriviaContext) -> Bool = { _, _ in
        true
      },
      checkTriviaPiece: @escaping (
        _ triviaPiece: TriviaPiece, _ triviaPieceContext: TriviaPieceContext
      ) -> Bool = { _, _ in true },
      shouldExtendToken: @escaping (_ token: TokenSyntax) -> Bool = { _ in true },
      shouldExtendFragment: @escaping (_ codeFragment: CodeFragmentSyntax) -> Bool = { _ in true }
    ) {

      self.checkSyntax = checkSyntax
      self.checkExtendedSyntax = checkExtendedSyntax
      self.checkTrivia = checkTrivia
      self.checkTriviaPiece = checkTriviaPiece
      self.shouldExtendToken = shouldExtendToken
      self.shouldExtendFragment = shouldExtendFragment
    }

    // MARK: - Properties

    private let checkSyntax: (Syntax, SyntaxContext) -> Bool
    private let checkExtendedSyntax: (ExtendedSyntax, ExtendedSyntaxContext) -> Bool
    private let checkTrivia: (Trivia, TriviaContext) -> Bool
    private let checkTriviaPiece: (TriviaPiece, TriviaPieceContext) -> Bool
    private let shouldExtendToken: (TokenSyntax) -> Bool
    private let shouldExtendFragment: (CodeFragmentSyntax) -> Bool

    // MARK: - SyntaxScanner

    public func visit(_ node: Syntax, context: SyntaxContext) -> Bool {
      return checkSyntax(node, context)
    }

    public func visit(_ node: ExtendedSyntax, context: ExtendedSyntaxContext) -> Bool {
      return checkExtendedSyntax(node, context)
    }

    public func visit(_ node: Trivia, context: TriviaContext) -> Bool {
      return checkTrivia(node, context)
    }

    public func visit(_ node: TriviaPiece, context: TriviaPieceContext) -> Bool {
      return checkTriviaPiece(node, context)
    }

    public func shouldExtend(_ node: TokenSyntax) -> Bool {
      return shouldExtendToken(node)
    }

    public func shouldExtend(_ node: CodeFragmentSyntax) -> Bool {
      return shouldExtendFragment(node)
    }
  }
