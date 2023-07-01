/*
 ParentRelationship.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A relationship between a parent node and one of its child nodes.
public struct ParentRelationship {

  // MARK: - Initialization

  internal init(node: SyntaxNode, childIndex: Int) {
    if let any = node as? AnySyntaxNode {
      self.node = any.wrapped
    } else {
      self.node = node
    }
    self.childIndex = childIndex
  }

  // MARK: - Properties

  /// The parent node.
  public let node: SyntaxNode

  /// The index of the child among the parent’s children.
  public let childIndex: Int
}
