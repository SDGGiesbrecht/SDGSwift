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
  import SDGLogic

  import SwiftSyntax
  import Markdown

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
    mutating func visit(_ node: Markup, context: MarkupContext) -> Bool

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

    // @documentation(SDGSwiftSource.SyntaxScanner.shouldExtend(FragmentSyntax<DocumentationContentSyntax>))
    /// Checks whether a node should be scanned in its extended form.
    ///
    /// Implement this to skip extended parsing for particular nodes.
    ///
    /// - Parameters:
    ///     - node: A fragment of documentation syntax.
    ///
    /// - Returns: Whether extended parsing should be applied to a documentation node. Return `true` to try to have the node visited as a markdown syntax tree; return `false` to skip extended parsing and have the token visited as an `ExtendedSyntax` instance. If the node does not support extended parsing, the result will be ignored and an `ExtendedSyntax` instance will be visited regardless.
    func shouldExtend(_ node: FragmentSyntax<DocumentationContentSyntax>) -> Bool

    /// A cache for the syntax scanner.
    var cache: SyntaxScannerCache { get set }
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

    // #workaround(workspace version 0.42.0, Redundant documentation, but inheritance is broken.)
    // #documentation(SDGSwiftSource.SyntaxScanner.shouldExtend(FragmentSyntax<DocumentationContentSyntax>))
    /// Checks whether a node should be scanned in its extended form.
    ///
    /// Implement this to skip extended parsing for particular nodes.
    ///
    /// - Parameters:
    ///     - node: A fragment of documentation syntax.
    ///
    /// - Returns: Whether extended parsing should be applied to a documentation node. Return `true` to try to have the node visited as a markdown syntax tree; return `false` to skip extended parsing and have the token visited as an `ExtendedSyntax` instance. If the node does not support extended parsing, the result will be ignored and an `ExtendedSyntax` instance will be visited regardless.
    public func shouldExtend(_ node: FragmentSyntax<DocumentationContentSyntax>) -> Bool {
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
        scan(token.leadingTrivia, context: TriviaContext())
        if shouldExtend(token),
          let extended = token.extended
        {
          scan(extended, context: ExtendedSyntaxContext())
        } else {
          _ = visit(Syntax(token), context: context)
        }
        scan(token.trailingTrivia, context: TriviaContext())
      } else {
        if visit(node, context: context) {
          for child in node.children(viewMode: .sourceAccurate) {
            scan(child, context: SyntaxContext())
          }
        }
      }
    }

    private mutating func scan(_ node: ExtendedSyntax, context: ExtendedSyntaxContext) {
      if let documentationFragment = node as? FragmentSyntax<DocumentationContentSyntax>,
        shouldExtend(documentationFragment)
      {
        let markdown = documentationFragment.markdownSyntax(cache: &self.cache.markdownParserCache)
        scan(markdown, context: ExtendedSyntaxContext())
      } else {
        if visit(node, context: context) {
          for child in node.children {
            scan(child, context: ExtendedSyntaxContext())
          }
        }
      }
    }

    private mutating func scan(_ trivia: Trivia, context: TriviaContext) {
      if visit(trivia, context: context) {
        var handledDocumentation: [[String]] = [[]]
        var pendingDocumentation: [[String]] = trivia.lineDocumentationSourceGroups()
        for piece in trivia.pieces {
          var currentSource: String?
          if case .docLineComment = piece,
            let groupIndex = pendingDocumentation.indices.first,
            ¬pendingDocumentation[groupIndex].isEmpty
          {
            currentSource = pendingDocumentation[groupIndex].removeFirst()
          }
          defer {
            if let current = currentSource,
              let groupIndex = handledDocumentation.indices.last
            {
              handledDocumentation[groupIndex].append(current)
            }
            if pendingDocumentation.first?.isEmpty == true {
              handledDocumentation.append(pendingDocumentation.removeFirst())
            }
          }

          let triviaContext = TriviaPieceContext(
            precedingDocumentationContext: handledDocumentation.last?.appending("").joined(
              separator: "\n"
            ),
            followingDocumentationContext: pendingDocumentation.first?.prepending("").joined(
              separator: "\n"
            )
          )
          scan(piece, context: triviaContext)
        }
      }
    }

    private mutating func scan(_ piece: TriviaPiece, context: TriviaPieceContext) {
      if visit(piece, context: context) {
        scan(piece.extended(context: context), context: ExtendedSyntaxContext())
      }
    }
  }
#endif
