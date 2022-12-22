/*
 FunctionalSyntaxScanner.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
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

    // #workaround(workspace version 0.42.0, Redundant, but inheritance broken.)
    // #documentation(SDGSwiftSource.SyntaxScanner.visit)
    /// Visits a syntax node.
    ///
    /// Subclass this to read information from a particular node.
    ///
    /// - Important: The provided context is only valid for the node with which it was received, not for any of its parents, children or neighbours.
    ///
    /// - Parameters:
    ///     - node: The current node.
    ///     - context: The context of the current node.
    ///
    /// - Returns: Whether or not the scanner should visit the node’s children. The superclass implementation returns `true`, thus scanning the entire syntax tree. Subclasses can speed up the scan by returning `false` if it is already known that nothing relevant could be nested within the node. For example, a scanner concerned with the exposed API does not care about function bodies, and can skip scanning them entirely by returning `false` whenever they appear.
    public func visit(_ node: Syntax, context: SyntaxContext) -> Bool {
      return checkSyntax(node, context)
    }

    // #workaround(workspace version 0.42.0, Redundant, but inheritance broken.)
    // #documentation(SDGSwiftSource.SyntaxScanner.visit)
    /// Visits a syntax node.
    ///
    /// Subclass this to read information from a particular node.
    ///
    /// - Important: The provided context is only valid for the node with which it was received, not for any of its parents, children or neighbours.
    ///
    /// - Parameters:
    ///     - node: The current node.
    ///     - context: The context of the current node.
    ///
    /// - Returns: Whether or not the scanner should visit the node’s children. The superclass implementation returns `true`, thus scanning the entire syntax tree. Subclasses can speed up the scan by returning `false` if it is already known that nothing relevant could be nested within the node. For example, a scanner concerned with the exposed API does not care about function bodies, and can skip scanning them entirely by returning `false` whenever they appear.
    public func visit(_ node: ExtendedSyntax, context: ExtendedSyntaxContext) -> Bool {
      return checkExtendedSyntax(node, context)
    }

    // #workaround(workspace version 0.42.0, Redundant, but inheritance broken.)
    // #documentation(SDGSwiftSource.SyntaxScanner.visit)
    /// Visits a syntax node.
    ///
    /// Subclass this to read information from a particular node.
    ///
    /// - Important: The provided context is only valid for the node with which it was received, not for any of its parents, children or neighbours.
    ///
    /// - Parameters:
    ///     - node: The current node.
    ///     - context: The context of the current node.
    ///
    /// - Returns: Whether or not the scanner should visit the node’s children. The superclass implementation returns `true`, thus scanning the entire syntax tree. Subclasses can speed up the scan by returning `false` if it is already known that nothing relevant could be nested within the node. For example, a scanner concerned with the exposed API does not care about function bodies, and can skip scanning them entirely by returning `false` whenever they appear.
    public func visit(_ node: Trivia, context: TriviaContext) -> Bool {
      return checkTrivia(node, context)
    }

    // #workaround(workspace version 0.42.0, Redundant, but inheritance broken.)
    // #documentation(SDGSwiftSource.SyntaxScanner.visit)
    /// Visits a syntax node.
    ///
    /// Subclass this to read information from a particular node.
    ///
    /// - Important: The provided context is only valid for the node with which it was received, not for any of its parents, children or neighbours.
    ///
    /// - Parameters:
    ///     - node: The current node.
    ///     - context: The context of the current node.
    ///
    /// - Returns: Whether or not the scanner should visit the node’s children. The superclass implementation returns `true`, thus scanning the entire syntax tree. Subclasses can speed up the scan by returning `false` if it is already known that nothing relevant could be nested within the node. For example, a scanner concerned with the exposed API does not care about function bodies, and can skip scanning them entirely by returning `false` whenever they appear.
    public func visit(_ node: TriviaPiece, context: TriviaPieceContext) -> Bool {
      return checkTriviaPiece(node, context)
    }

    // #workaround(workspace version 0.42.0, Redundant, but inheritance broken.)
    // #documentation(SDGSwiftSource.SyntaxScanner.shouldExtend(TokenSyntax))
    /// Checks whether a node should be scanned in its extended form.
    ///
    /// Subclass this to skip extended parsing for particular tokens.
    ///
    /// - Parameters:
    ///     - node: A `TokenSyntax` instance.
    ///
    /// - Returns: Whether extended parsing should be applied to a node. Return `true` to try to have the token visited as an `ExtendedSyntax` subclass; return `false` to skip extended parsing and have the token visited as a `TokenSyntax` instance. If the node does not support extended parsing, the result will be ignored and a `TokenSyntax` instance will be visited regardless.
    public func shouldExtend(_ node: TokenSyntax) -> Bool {
      return shouldExtendToken(node)
    }

    // #workaround(workspace version 0.42.0, Redundant, but inheritance broken.)
    // #documentation(SDGSwiftSource.SyntaxScanner.shouldExtend(CodeFragmentSyntax))
    /// Checks whether a node should be scanned in its extended form.
    ///
    /// Subclass this to skip extended parsing for particular tokens.
    ///
    /// - Parameters:
    ///     - node: A `CodeFragmentSyntax` instance.
    ///
    /// - Returns: Whether extended parsing should be applied to a node. Return `true` to try to have the token visited as `Syntax` subclasses; return `false` to skip extended parsing and have the token visited as a `CodeFragmentSyntax` instance.
    public func shouldExtend(_ node: CodeFragmentSyntax) -> Bool {
      return shouldExtendFragment(node)
    }
  }
#endif
