/*
 SwiftSyntaxNode.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SwiftSyntax

/// A syntax node from the SwiftSyntax library.
public struct SwiftSyntaxNode: SyntaxNode {

  // MARK: - Initialization

  /// Creates a node from a `Syntax` instance.
  ///
  /// - Parameters:
  ///   - swiftSyntaxNode: The SwiftSyntax node.
  public init(_ swiftSyntaxNode: Syntax) {
    self.swiftSyntaxNode = swiftSyntaxNode
  }

  // MARK: - Properties

  /// The SwiftSyntax node.
  public let swiftSyntaxNode: Syntax

  // MARK: - SyntaxNode

  public func children(cache: inout ParserCache) -> [SyntaxNode] {
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
  }

  // MARK: - TextOutputStreamable

  public func write<Target>(
    to target: inout Target
  ) where Target: TextOutputStream {
    swiftSyntaxNode.write(to: &target)
  }
}
