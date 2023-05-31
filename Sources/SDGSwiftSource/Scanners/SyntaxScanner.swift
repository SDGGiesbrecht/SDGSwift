/*
 SyntaxScanner.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

  import SwiftSyntax

  /// A scanner for read‐only handling of a syntax tree.
  public protocol SyntaxScanner {

    // @documentation(SDGSwiftSource.SyntaxScanner.visit(_:context:))
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
    func visit(_ node: Syntax, context: SyntaxContext) -> Bool

    // #documentation(SDGSwiftSource.SyntaxScanner.visit(_:context:))
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
    func visit(_ node: ExtendedSyntax, context: ExtendedSyntaxContext) -> Bool

    // #documentation(SDGSwiftSource.SyntaxScanner.visit(_:context:))
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
    func visit(_ node: Trivia, context: TriviaContext) -> Bool

    // #documentation(SDGSwiftSource.SyntaxScanner.visit(_:context:))
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
    func visit(_ node: TriviaPiece, context: TriviaPieceContext) -> Bool

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

    // @documentation(SDGSwiftSource.SyntaxScanner.shouldExtend(CodeFragmentSyntax))
    /// Checks whether a node should be scanned in its extended form.
    ///
    /// Subclass this to skip extended parsing for particular tokens.
    ///
    /// - Parameters:
    ///     - node: A `CodeFragmentSyntax` instance.
    ///
    /// - Returns: Whether extended parsing should be applied to a node. Return `true` to try to have the token visited as `Syntax` subclasses; return `false` to skip extended parsing and have the token visited as a `CodeFragmentSyntax` instance.
    func shouldExtend(_ node: CodeFragmentSyntax) -> Bool
  }

  extension SyntaxScanner {

    // MARK: - Default Implementations

    // #workaround(workspace version 0.42.0, Redundant documentation, but inheritance is broken.)
    // #documentation(SDGSwiftSource.SyntaxScanner.visit(_:context:))
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
    public func visit(_ node: Syntax, context: SyntaxContext) -> Bool {
      return true
    }

    // #workaround(workspace version 0.42.0, Redundant documentation, but inheritance is broken.)
    // #documentation(SDGSwiftSource.SyntaxScanner.visit(_:context:))
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
    public func visit(_ node: ExtendedSyntax, context: ExtendedSyntaxContext) -> Bool {
      return true
    }

    // #workaround(workspace version 0.42.0, Redundant documentation, but inheritance is broken.)
    // #documentation(SDGSwiftSource.SyntaxScanner.visit(_:context:))
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
    public func visit(_ node: Trivia, context: TriviaContext) -> Bool {
      return true
    }

    // #workaround(workspace version 0.42.0, Redundant documentation, but inheritance is broken.)
    // #documentation(SDGSwiftSource.SyntaxScanner.visit(_:context:))
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
    public func visit(_ node: TriviaPiece, context: TriviaPieceContext) -> Bool {
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

    // #workaround(workspace version 0.42.0, Redundant documentation, but inheritance is broken.)
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
      return true
    }

    // MARK: - Scanning

    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
      // @documentation(SDGSwiftSource.SyntaxScanner.scan)
      /// Scans the node and its children.
      ///
      /// - Parameters:
      ///     - node: The node to scan.
      public func scan(_ node: SourceFileSyntax) throws {
        let nodeSource = node.source()
        try scan(
          Syntax(node),
          context: SyntaxContext(
            fragmentContext: nodeSource,
            fragmentOffset: nodeSource.offset(of: nodeSource.scalars.startIndex),
            parentContext: nil
          )
        )
      }
      private func scan(_ node: Syntax, context: SyntaxContext) throws {
        if let token = node.as(TokenSyntax.self) {
          let leadingTriviaContext = TriviaContext(
            token: token,
            tokenContext: context,
            leading: true
          )
          try scan(token.leadingTrivia, context: leadingTriviaContext)
          if shouldExtend(token),
            let extended = token.extended
          {
            let newContext = ExtendedSyntaxContext._token(token, context: context)
            if visit(extended, context: newContext) {
              for child in extended.children {
                try scan(child, context: newContext)
              }
            }
          } else {
            _ = visit(Syntax(token), context: context)
          }
          let trailingTriviaContext = TriviaContext(
            token: token,
            tokenContext: context,
            leading: false
          )
          try scan(token.trailingTrivia, context: trailingTriviaContext)
        } else {
          if visit(node, context: context) {
            for child in node.children(viewMode: .sourceAccurate) {
              try scan(child, context: context)
            }
          }
        }
      }

      private func scan(_ node: ExtendedSyntax, context: ExtendedSyntaxContext) throws {
        if let code = node as? CodeFragmentSyntax,
          shouldExtend(code),
          let children = try code.syntax()
        {
          var offset = 0
          for child in children {
            switch child {
            case .syntax(let node):
              let newContext = SyntaxContext(
                fragmentContext: code.context,
                fragmentOffset: code.range.lowerBound,
                parentContext: (code, context)
              )
              try scan(node, context: newContext)
              offset += node.source().scalars.count
            case .extendedSyntax(let node):
              try scan(node, context: ._fragment(code, context: context, offset: offset))
              offset += node.text.scalars.count
            case .trivia(let node, let siblings, let index):
              try scan(
                node,
                siblings: siblings,
                index: index,
                context: ._fragment(code, context: context, offset: offset)
              )
              offset += node.text.scalars.count
            }
          }
        } else {
          if visit(node, context: context) {
            for child in node.children {
              try scan(child, context: context)
            }
          }
        }
      }

      private func scan(_ trivia: Trivia, context: TriviaContext) throws {
        if visit(trivia, context: context) {
          for index in trivia.indices {
            let newContext = TriviaPieceContext._trivia(trivia, index: index, parent: context)
            let piece = trivia[index]
            try scan(piece, siblings: trivia, index: index, context: newContext)
          }
        }
      }

      private func scan(
        _ piece: TriviaPiece,
        siblings: Trivia,
        index: Trivia.Index,
        context: TriviaPieceContext
      ) throws {
        if visit(piece, context: context) {
          let newContext = ExtendedSyntaxContext._trivia(piece, context: context)
          try scan(piece.syntax(siblings: siblings, index: index), context: newContext)
        }
      }
    #endif
  }
