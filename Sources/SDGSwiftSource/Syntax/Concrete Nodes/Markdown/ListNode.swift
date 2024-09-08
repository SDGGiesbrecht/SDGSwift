/*
 ListNode.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_MARKDOWN
  import Markdown
#endif

/// A list in documentation.
public struct ListNode: StreamedViaChildren, SyntaxNode {

  // MARK: - Static Methods

  #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_MARKDOWN
  internal static func filterCallouts(
    fromUnorderedList components: [SyntaxNode],
    cache: inout ParserCache
  ) -> [SyntaxNode] {
    var result: [SyntaxNode] = []
    var listUnderConstruction: [SyntaxNode] = []
    var remainder = components[...]
    func registerList() {
      var leading: [SyntaxNode] = []
      while ¬listUnderConstruction.isEmpty,
        ¬((listUnderConstruction.first as? MarkdownNode)?.markdown is ListItem) {
        leading.append(listUnderConstruction.removeFirst())
      }
      result.append(contentsOf: leading)

      var trailing: [SyntaxNode] = []
      while ¬listUnderConstruction.isEmpty,
        ¬((listUnderConstruction.first as? MarkdownNode)?.markdown is ListItem) {
        // @exempt(from: tests) Reachability unknown.
        trailing.prepend(listUnderConstruction.removeLast())
      }
      defer { result.append(contentsOf: trailing) }

      if ¬listUnderConstruction.isEmpty {
        result.append(ListNode(components: listUnderConstruction, isOrdered: false))
        listUnderConstruction = []
      }
    }
    while ¬remainder.isEmpty {
      let next = remainder.removeFirst()
      if let markdown = next as? MarkdownNode,
        markdown.markdown is ListItem {
        let listItemChildren = markdown.children(cache: &cache)
        if listItemChildren.count == 1,
          let callout = listItemChildren.first as? CalloutNode {
          registerList()
          result.append(callout)
          continue
        }
      }
      listUnderConstruction.append(next)
    }
    registerList()
    return result
  }
  #endif

  // MARK: - Initialization

  internal init(components: [SyntaxNode], isOrdered: Bool) {
    self.contents = components
    self.isOrdered = isOrdered
  }

  // MARK: - Properties

  /// The contents of the list.
  public let contents: [SyntaxNode]

  /// Whether the list represents an ordered list or an unordered list.
  public let isOrdered: Bool

  // MARK: - StreamedViaChildren

  internal var storedChildren: [SyntaxNode] {
    return contents
  }
}
