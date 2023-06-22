/*
 ListNode.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A list in documentation.
public struct ListNode: StreamedViaChildren, SyntaxNode {

  // MARK: - Initialization

  internal init(components: [SyntaxNode], isOrdered: Bool) {
    self.contents = components
    self.isOrdered = isOrdered
  }

  // MARK: - Properties

  /// The contents of the list.
  public let contents: [SyntaxNode]

  public let isOrdered: Bool

  // MARK: - StreamedViaChildren

  internal var storedChildren: [SyntaxNode] {
    return contents
  }
}
