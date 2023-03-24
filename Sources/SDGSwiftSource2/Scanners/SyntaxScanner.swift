/*
 SyntaxScanner.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SwiftSyntax

  /// A scanner for read‐only handling of a syntax tree.
  public protocol SyntaxScanner {
    // #workaround(Incomplete.)

    // @documentation(SDGSwiftSource.SyntaxScanner.visit)
    /// Visits a syntax node.
    ///
    /// Provide a custom implementation of this to read information from a particular node.
    ///
    /// - Important: The provided context is only valid for the node with which it was received, not for any of its parents, children or neighbours.
    ///
    /// - Parameters:
    ///     - node: The current node.
    ///     - context: The context of the current node.
    ///
    /// - Returns: Whether or not the scanner should visit the node’s children. The default implementation returns `true`, thus scanning the entire syntax tree. Types can speed up the scan by returning `false` if it is already known that nothing relevant could be nested within the node. For example, a scanner concerned with the exposed API does not care about function bodies, and can skip scanning them entirely by returning `false` whenever they appear.
    mutating func visit(_ node: Syntax, context: SyntaxContext) -> Bool

    // #documentation(SDGSwiftSource.SyntaxScanner.visit)
    /// Visits a syntax node.
    ///
    /// Provide a custom implementation of this to read information from a particular node.
    ///
    /// - Important: The provided context is only valid for the node with which it was received, not for any of its parents, children or neighbours.
    ///
    /// - Parameters:
    ///     - node: The current node.
    ///     - context: The context of the current node.
    ///
    /// - Returns: Whether or not the scanner should visit the node’s children. The default implementation returns `true`, thus scanning the entire syntax tree. Types can speed up the scan by returning `false` if it is already known that nothing relevant could be nested within the node. For example, a scanner concerned with the exposed API does not care about function bodies, and can skip scanning them entirely by returning `false` whenever they appear.
    mutating func visit(_ node: ExtendedSyntax, context: ExtendedSyntaxContext) -> Bool

    // #documentation(SDGSwiftSource.SyntaxScanner.visit)
    /// Visits a syntax node.
    ///
    /// Provide a custom implementation of this to read information from a particular node.
    ///
    /// - Important: The provided context is only valid for the node with which it was received, not for any of its parents, children or neighbours.
    ///
    /// - Parameters:
    ///     - node: The current node.
    ///     - context: The context of the current node.
    ///
    /// - Returns: Whether or not the scanner should visit the node’s children. The default implementation returns `true`, thus scanning the entire syntax tree. Types can speed up the scan by returning `false` if it is already known that nothing relevant could be nested within the node. For example, a scanner concerned with the exposed API does not care about function bodies, and can skip scanning them entirely by returning `false` whenever they appear.
    mutating func visit(_ node: Trivia, context: TriviaContext) -> Bool

    // #documentation(SDGSwiftSource.SyntaxScanner.visit)
    /// Visits a syntax node.
    ///
    /// Provide a custom implementation of this to read information from a particular node.
    ///
    /// - Important: The provided context is only valid for the node with which it was received, not for any of its parents, children or neighbours.
    ///
    /// - Parameters:
    ///     - node: The current node.
    ///     - context: The context of the current node.
    ///
    /// - Returns: Whether or not the scanner should visit the node’s children. The default implementation returns `true`, thus scanning the entire syntax tree. Types can speed up the scan by returning `false` if it is already known that nothing relevant could be nested within the node. For example, a scanner concerned with the exposed API does not care about function bodies, and can skip scanning them entirely by returning `false` whenever they appear.
    mutating func visit(_ node: TriviaPiece, context: TriviaPieceContext) -> Bool

    // @documentation(SDGSwiftSource.SyntaxScanner.shouldExtend(TokenSyntax))
    /// Checks whether a node should be scanned in its extended form.
    ///
    /// Implement this to skip extended parsing for particular tokens.
    ///
    /// - Parameters:
    ///     - node: A `TokenSyntax` instance.
    ///
    /// - Returns: Whether extended parsing should be applied to a node. Return `true` to try to have the token visited as an `ExtendedSyntax` tree; return `false` to skip extended parsing and have the token visited as a `TokenSyntax` instance. If the node does not support extended parsing, the result will be ignored and a `TokenSyntax` instance will be visited regardless.
    func shouldExtend(_ node: TokenSyntax) -> Bool
  }

  extension SyntaxScanner {

    // MARK: - Default Implementations

    // #workaround(workspace version 0.42.0, Redundant documentation, but inheritance is broken.)
    // #documentation(SDGSwiftSource.SyntaxScanner.visit)
    /// Visits a syntax node.
    ///
    /// Provide a custom implementation of this to read information from a particular node.
    ///
    /// - Important: The provided context is only valid for the node with which it was received, not for any of its parents, children or neighbours.
    ///
    /// - Parameters:
    ///     - node: The current node.
    ///     - context: The context of the current node.
    ///
    /// - Returns: Whether or not the scanner should visit the node’s children. The default implementation returns `true`, thus scanning the entire syntax tree. Types can speed up the scan by returning `false` if it is already known that nothing relevant could be nested within the node. For example, a scanner concerned with the exposed API does not care about function bodies, and can skip scanning them entirely by returning `false` whenever they appear.
    public mutating func visit(_ node: Syntax, context: SyntaxContext) -> Bool {
      return true
    }

    // #workaround(workspace version 0.42.0, Redundant documentation, but inheritance is broken.)
    // #documentation(SDGSwiftSource.SyntaxScanner.visit)
    /// Visits a syntax node.
    ///
    /// Provide a custom implementation of this to read information from a particular node.
    ///
    /// - Important: The provided context is only valid for the node with which it was received, not for any of its parents, children or neighbours.
    ///
    /// - Parameters:
    ///     - node: The current node.
    ///     - context: The context of the current node.
    ///
    /// - Returns: Whether or not the scanner should visit the node’s children. The default implementation returns `true`, thus scanning the entire syntax tree. Types can speed up the scan by returning `false` if it is already known that nothing relevant could be nested within the node. For example, a scanner concerned with the exposed API does not care about function bodies, and can skip scanning them entirely by returning `false` whenever they appear.
    public mutating func visit(_ node: ExtendedSyntax, context: ExtendedSyntaxContext) -> Bool {
      return true
    }

    // #workaround(workspace version 0.42.0, Redundant documentation, but inheritance is broken.)
    // #documentation(SDGSwiftSource.SyntaxScanner.visit)
    /// Visits a syntax node.
    ///
    /// Provide a custom implementation of this to read information from a particular node.
    ///
    /// - Important: The provided context is only valid for the node with which it was received, not for any of its parents, children or neighbours.
    ///
    /// - Parameters:
    ///     - node: The current node.
    ///     - context: The context of the current node.
    ///
    /// - Returns: Whether or not the scanner should visit the node’s children. The default implementation returns `true`, thus scanning the entire syntax tree. Types can speed up the scan by returning `false` if it is already known that nothing relevant could be nested within the node. For example, a scanner concerned with the exposed API does not care about function bodies, and can skip scanning them entirely by returning `false` whenever they appear.
    public mutating func visit(_ node: Trivia, context: TriviaContext) -> Bool {
      return true
    }

    // #workaround(workspace version 0.42.0, Redundant documentation, but inheritance is broken.)
    // #documentation(SDGSwiftSource.SyntaxScanner.visit)
    /// Visits a syntax node.
    ///
    /// Provide a custom implementation of this to read information from a particular node.
    ///
    /// - Important: The provided context is only valid for the node with which it was received, not for any of its parents, children or neighbours.
    ///
    /// - Parameters:
    ///     - node: The current node.
    ///     - context: The context of the current node.
    ///
    /// - Returns: Whether or not the scanner should visit the node’s children. The default implementation returns `true`, thus scanning the entire syntax tree. Types can speed up the scan by returning `false` if it is already known that nothing relevant could be nested within the node. For example, a scanner concerned with the exposed API does not care about function bodies, and can skip scanning them entirely by returning `false` whenever they appear.
    public mutating func visit(_ node: TriviaPiece, context: TriviaPieceContext) -> Bool {
      return true
    }

    // #workaround(workspace version 0.42.0, Redundant documentation, but inheritance is broken.)
    // #documentation(SDGSwiftSource.SyntaxScanner.shouldExtend(TokenSyntax))
    /// Checks whether a node should be scanned in its extended form.
    ///
    /// Implement this to skip extended parsing for particular tokens.
    ///
    /// - Parameters:
    ///     - node: A `TokenSyntax` instance.
    ///
    /// - Returns: Whether extended parsing should be applied to a node. Return `true` to try to have the token visited as an `ExtendedSyntax` tree; return `false` to skip extended parsing and have the token visited as a `TokenSyntax` instance. If the node does not support extended parsing, the result will be ignored and a `TokenSyntax` instance will be visited regardless.
    public func shouldExtend(_ node: TokenSyntax) -> Bool {
      return true
    }

    // MARK: - Scanning

    // @documentation(SDGSwiftSource.SyntaxScanner.scan)
    /// Scans the node and its children.
    ///
    /// - Parameters:
    ///     - node: The node to scan.
    public mutating func scan(_ node: SourceFileSyntax) {
      scan(
        Syntax(node),
        context: SyntaxContext()
      )
    }
    private mutating func scan(_ node: Syntax, context: SyntaxContext) {
      if let token = node.as(TokenSyntax.self) {
        let leadingTriviaContext = TriviaContext()
        scan(token.leadingTrivia, context: leadingTriviaContext)
        if shouldExtend(token),
          let extended = token.extended
        {
          let newContext = ExtendedSyntaxContext()
          if visit(extended, context: newContext) {
            for child in extended.children {
              scan(child, context: newContext)
            }
          }
        } else {
          _ = visit(Syntax(token), context: context)
        }
        let trailingTriviaContext = TriviaContext()
        scan(token.trailingTrivia, context: trailingTriviaContext)
      } else {
        if visit(node, context: context) {
          for child in node.children {
            scan(child, context: context)
          }
        }
      }
    }

    private mutating func scan(_ node: ExtendedSyntax, context: ExtendedSyntaxContext) {
      // #workaround(Skipping code fragment syntax.)
      if visit(node, context: context) {
        // #workaround(Skipping children because none exist yet.)
        for _ in node.children {}
      }
    }

    private mutating func scan(_ trivia: Trivia, context: TriviaContext) {
      if visit(trivia, context: context) {
        for index in trivia.indices {
          let newContext = TriviaPieceContext()
          let piece = trivia[index]
          scan(piece, context: newContext)
        }
      }
    }

    private mutating func scan(_ piece: TriviaPiece, context: TriviaPieceContext) {
      if visit(piece, context: context) {
        let newContext = ExtendedSyntaxContext()
        scan(piece.extended, context: newContext)
      }
    }
  }
#endif
