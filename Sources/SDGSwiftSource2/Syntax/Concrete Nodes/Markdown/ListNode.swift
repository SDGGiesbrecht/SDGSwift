/*
 ListNode.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

/// A list in documentation.
public struct ListNode: StreamedViaChildren, SyntaxNode {

  // MARK: - Static Methods

  internal static func filterCallouts(fromUnorderedList components: [SyntaxNode]) -> [SyntaxNode] {
    var result: [SyntaxNode] = []
    var listUnderConstruction: [SyntaxNode] = []
    var remainder = components[...]
    func registerList() {

      var leading: [SyntaxNode] = []
      while ¬listUnderConstruction.isEmpty,
        ¬(listUnderConstruction.first is ListItemNode) {
        leading.append(listUnderConstruction.removeFirst())
      }
      result.append(contentsOf: leading)

      var trailing: [SyntaxNode] = []
      while ¬listUnderConstruction.isEmpty,
        ¬(listUnderConstruction.last is ListItemNode) {
        trailing.prepend(listUnderConstruction.removeLast())
      }
      defer { result.append(contentsOf: trailing) }

      if ¬listUnderConstruction.isEmpty {
        result.append(ListNode(components: listUnderConstruction, isOrdered: false))
      }
    }
    while ¬remainder.isEmpty {
      let next = remainder.removeFirst()
      if next is CalloutNode {
        registerList()
        result.append(next)
      } else {
        listUnderConstruction.append(next)
      }
    }
    registerList()
    return result
  }

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
