/*
 SwiftSyntaxNode.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SwiftSyntax
#endif
#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
  import SwiftSyntaxParser
#endif

/// A syntax node from the SwiftSyntax library.
public struct SwiftSyntaxNode: SyntaxNode {

  // MARK: - Initialization

  #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
    /// Creates a node from a `Syntax` instance.
    ///
    /// - Parameters:
    ///   - swiftSyntaxNode: The SwiftSyntax node.
    public init(_ swiftSyntaxNode: Syntax) {
      self.swiftSyntaxNode = swiftSyntaxNode
    }
  #endif

  #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
    /// Creates a node by parsing source.
    ///
    /// - Parameters:
    ///   - source: The source.
    public init(source: String) throws {
      let swiftSyntax = try SyntaxParser.parse(source: source)
      self.init(Syntax(swiftSyntax))
    }

    /// Creates a node by parsing a source file.
    ///
    /// - Parameters:
    ///   - file: The URL of the source file.
    public init(file: URL) throws {
      let swiftSyntax = try SyntaxParser.parse(file)
      self.init(Syntax(swiftSyntax))
    }
  #endif

  // MARK: - Properties

  #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
    /// The SwiftSyntax node.
    public let swiftSyntaxNode: Syntax
  #endif

  // MARK: - Local Context

  // @documentation(SDGSwiftSource.Syntax.localAncestors())
  /// All the node’s ancestors in order from its immediate parent to the root node of the local syntax context.
  ///
  /// The local syntax context is the contiguous syntax tree accessible without escaping through fragmentation into parent contexts. That is, the root node of code in a documentation comment is the unified code block itself, not the source file containing the documentation comment, and any intervening documentation delimiters or indentation beloninging to them do not participate in the local tree.
  public func localAncestors() -> AnySequence<Syntax> {
    if let parent = swiftSyntaxNode.parent {
      return AnySequence(sequence(first: parent, next: { $0.parent }))
    } else {
      return AnySequence([])
    }
  }

  internal func isInLocalIfConfigurationCondition() -> Bool {
    var previousAncestor: Syntax = Syntax(swiftSyntaxNode)
    for ancestor in localAncestors() {
      defer { previousAncestor = ancestor }
      if let ifConfigurationClause = ancestor.as(IfConfigClauseSyntax.self),
        let condition = Syntax(ifConfigurationClause.condition),
        condition == previousAncestor
      {
        return true
      }
    }
    return false
  }

  // MARK: - SyntaxNode

  public func children(cache: inout ParserCache) -> [SyntaxNode] {  // @exempt(from: tests)
    // Unreachable without SwiftSyntax because initialization is impossible.
    #if PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
      return []
    #else
      if let token = swiftSyntaxNode.as(TokenSyntax.self) {
        var children: [SyntaxNode] = [TriviaNode(token.leadingTrivia)]
        if case .stringLiteral(let source) = token.tokenKind,
          let literal = StringLiteral(source: source)
        {
          children.append(literal)
        } else {
          children.append(Token(kind: .swiftSyntax(token.tokenKind)))
        }
        children.append(TriviaNode(token.trailingTrivia))
        return children
      } else {
        return swiftSyntaxNode.children(viewMode: .sourceAccurate).map { node in
          return SwiftSyntaxNode(node)
        }
      }
    #endif  // @exempt(from: tests)
  }

  // MARK: - TextOutputStreamable

  public func write<Target>(
    to target: inout Target
  ) where Target: TextOutputStream {  // @exempt(from: tests)
    // Unreachable without SwiftSyntax because initialization is impossible.
    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
      swiftSyntaxNode.write(to: &target)
    #endif
  }
}
