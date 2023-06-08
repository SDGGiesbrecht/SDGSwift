/*
 ListSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

  import cmark_gfm

  /// A list in documentation.
  public final class ListSyntax: MarkdownSyntax {

    // MARK: - Initialization

    internal init(node: UnsafeMutablePointer<cmark_node>, in documentation: String) {
      super.init(node: node, in: documentation)

      if children.contains(where: { $0 is CalloutSyntax }) {
        var handlingCallouts: [ExtendedSyntax] = []
        var currentList: [ExtendedSyntax] = []
        for child in children {
          if child is CalloutSyntax {
            if ¬currentList.isEmpty {
              handlingCallouts.append(ListSyntax(children: currentList))
              currentList = []
            }

            handlingCallouts.append(child)
          } else {
            currentList.append(child)
          }
        }

        if ¬currentList.isEmpty {
          handlingCallouts.append(ListSyntax(children: currentList))
        }
        self.handlingCallouts = handlingCallouts
      }
    }

    internal override init(children: [ExtendedSyntax]) {
      super.init(children: children)
    }

    // Storage if it is really a callout instead.
    internal var handlingCallouts: [ExtendedSyntax]?

    // MARK: - ExtendedSyntax

    internal override var renderedHtmlElement: String? {
      return "ul"
    }
  }
