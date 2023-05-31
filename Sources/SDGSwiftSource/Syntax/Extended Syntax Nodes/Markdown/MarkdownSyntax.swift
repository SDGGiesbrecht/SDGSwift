/*
 MarkdownSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

  import Foundation

  import SDGControlFlow
  import SDGLogic
  import SDGCollections

  import cmark_gfm

  /// A Markdown node in documentation.
  public class MarkdownSyntax: ExtendedSyntax {  // @exempt(from: classFinality)

    // MARK: - Initialization

    internal init(
      node: UnsafeMutablePointer<cmark_node>,
      in documentation: String,
      precedingChildren: [ExtendedSyntax] = [],
      followingChildren: [ExtendedSyntax] = []
    ) {

      var children: [ExtendedSyntax] = []

      func assimilate(trivia: String) {
        var trivia = trivia

        while let first = trivia.scalars.first {
          if first ∈ CharacterSet.whitespaces {
            var whitespace = String(first)
            trivia.scalars.removeFirst()
            while let another = trivia.scalars.first,
              another ∈ CharacterSet.whitespaces
            {
              whitespace.scalars.append(trivia.scalars.removeFirst())
            }
            children.append(ExtendedTokenSyntax(text: whitespace, kind: .whitespace))
          } else if first ∈ CharacterSet.newlines {
            var newlines = String(first)
            trivia.scalars.removeFirst()
            while let another = trivia.scalars.first,
              another ∈ CharacterSet.newlines
            {
              newlines.scalars.append(trivia.scalars.removeFirst())
            }
            children.append(ExtendedTokenSyntax(text: newlines, kind: .newlines))
          } else {
            break
          }
        }
      }

      if var child = cmark_node_first_child(node) {
        children.append(contentsOf: child.syntax(in: documentation))
        var end = child.upperBound(in: documentation)
        while let next = cmark_node_next(child) {
          defer {
            child = next
            end = child.upperBound(in: documentation)
          }
          let start = next.lowerBound(in: documentation)
          if start > end {
            assimilate(trivia: String(documentation.scalars[end..<start]))
          }
          children.append(contentsOf: next.syntax(in: documentation))
        }
        let endIndex = node.upperBound(in: documentation)
        if endIndex > end {
          assimilate(trivia: String(documentation.scalars[end..<endIndex]))
        }
      }
      super.init(children: precedingChildren + children + followingChildren)
    }

    internal override init(children: [ExtendedSyntax]) {
      super.init(children: children)
    }
  }
