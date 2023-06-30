/*
 AnySyntaxNode.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A type‐erased syntax node.
public struct AnySyntaxNode: SyntaxNode {

  // MARK: - Initialization

  /// Creates a type‐erased syntax node.
  ///
  /// - Parameters:
  ///   - wrapped: The syntax node to type‐erase.
  public init(_ wrapped: SyntaxNode) {
    self.wrapped = wrapped
  }

  // MARK: - Properties

  public let wrapped: SyntaxNode

  // MARK: - SyntaxNode

  public func children(cache: inout ParserCache) -> [SyntaxNode] {
    return wrapped.children(cache: &cache)
  }

  // MARK: - TextOutputStreamable

  public func write<Target>(to target: inout Target) where Target: TextOutputStream {
    wrapped.write(to: &target)
  }
}
