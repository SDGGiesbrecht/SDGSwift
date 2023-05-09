/*
 Fragment.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics
import SDGCollections
import SDGText

/// A smaller fragment of a larger syntax node.
public struct Fragment<Context>: FragmentProtocol, SyntaxNode where Context: SyntaxNode {

  // MARK: - Initialization

  /// Creates a syntax node representing one section of a fragmented context, such as a single line of mark‐up in documentation spread across a series of single‐line delimiters.
  ///
  /// - Parameters:
  ///   - scalarOffsets: The range the fragment describes within its context.
  ///   - context: The syntax node into which the fragment node provides a view.
  public init(scalarOffsets: CountableRange<Int>, in context: Context) {
    self.context = context
    self.scalarOffsets = scalarOffsets
    self.localAncestors = [context]
  }

  private init(
    scalarOffsets: CountableRange<Int>,
    in context: Context,
    inheritedLocalAncestors: [SyntaxNode]
  ) {
    self.context = context
    self.scalarOffsets = scalarOffsets
    self.localAncestors = inheritedLocalAncestors.appending(context)
  }

  // MARK: - Properties

  internal let context: Context
  internal let scalarOffsets: CountableRange<Int>

  internal let localAncestors: [SyntaxNode]

  // MARK: - SyntaxNode

  public func children(cache: inout ParserCache) -> [SyntaxNode] {
    var cropped: [SyntaxNode] = []
    var index = 0
    for child in context.children(cache: &cache) {
      let childText = child.text()
      let childLength = childText.scalars.count
      let start = index
      let end = start + childLength
      defer { index = end }

      if scalarOffsets ⊇ start..<end {
        cropped.append(child)
      } else if scalarOffsets.overlaps(start..<end) {
        var lower = scalarOffsets.lowerBound − start
        var upper = scalarOffsets.upperBound − start
        upper.decrease(to: childLength)
        lower.increase(to: 0)
        let childOffsets = lower..<upper

        if child is Token {
          var childText = childText
          if childLength > upper {
            childText.truncate(at: childText.scalars.index(childText.startIndex, offsetBy: upper))
          }
          childText.removeFirst(lower)
          cropped.append(Token(kind: .fragment(childText)))
        } else {
          cropped.append(
            Fragment<AnySyntaxNode>(
              scalarOffsets: childOffsets,
              in: AnySyntaxNode(child),
              inheritedLocalAncestors: localAncestors
            )
          )
        }
      } else if start > scalarOffsets.upperBound {
        break
      }
    }
    return cropped
  }

  // MARK: - TextOutputStreamable

  public func write<Target>(to target: inout Target) where Target: TextOutputStream {
    let scalars = context.text().scalars
      .dropFirst(scalarOffsets.lowerBound)
      .prefix(scalarOffsets.count)
    String(String.UnicodeScalarView(scalars)).write(to: &target)
  }
}
