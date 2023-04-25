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
public struct Fragment<Context>: SyntaxNode where Context: SyntaxNode {

  // MARK: - Initialization

  /// Creates a fragment node representing the entirety of another syntax node.
  ///
  /// - Parameters:
  ///   - node: The base node.
  public init(entiretyOf node: Context) {
    self.context = node
    self.scalarOffsets = 0..<node.text.scalars.count
  }

  /// Creates a syntax node representing one section of a fragmented context, such as a single line of mark‐up in documentation spread across a series of single‐line delimiters.
  ///
  /// - Parameters:
  ///   - scalarOffsets: The range the fragment describes within its context.
  ///   - context: The syntax node into which the fragment node provides a view.
  public init(scalarOffsets: CountableRange<Int>, in context: Context) {
    self.context = context
    self.scalarOffsets = scalarOffsets
  }

  // MARK: - Properties

  internal let context: Context
  internal let scalarOffsets: CountableRange<Int>

  // MARK: - SyntaxNode

  public func children(cache: inout ParserCache) -> [SyntaxNode] {
    var cropped: [SyntaxNode] = []
    var index = 0
    for child in context.children(cache: &cache) {
      let childText = child.text
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
              in: AnySyntaxNode(child)
            )
          )
        }
      } else if start > scalarOffsets.upperBound {
        break
      }
    }
    #warning("Debugging...")
    if false {
      print("Context: \(context.text)")
      print("Fragment: \(scalarOffsets)")
      let mapped = cropped.map({ $0.text })
      print(mapped)
      if mapped == ["."] {
        fatalError("Tripped.")
      }
    }
    return cropped
  }

  // MARK: - TextOutputStreamable

  public func write<Target>(to target: inout Target) where Target: TextOutputStream {
    let scalars = context.text.scalars.dropFirst(scalarOffsets.lowerBound).prefix(
      scalarOffsets.count
    )
    String(String.UnicodeScalarView(scalars)).write(to: &target)
  }
}
