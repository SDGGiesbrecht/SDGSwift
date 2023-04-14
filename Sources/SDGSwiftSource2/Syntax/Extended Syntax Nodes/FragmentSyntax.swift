/*
 FragmentSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics
import SDGCollections

/// A smaller fragment of a larger syntax node.
public struct FragmentSyntax<Context>: ExtendedSyntax where Context: ExtendedSyntax {

  // MARK: - Initialization

  /// Creates a syntax node representing one section of a fragmented context, such as a single line of markup in documentation spread across a series of single‐line delimiters.
  ///
  /// - Parameters:
  ///   - scalarOffsets: The range the fragment describes within its context.
  ///   - context: The syntax node into which the fragment node provides a view.
  public init(scalarOffsets: CountableRange<Int>, in context: Context) {
    var cropped: [ExtendedSyntax] = []
    var index = 0
    for child in context.children {
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

        // #workaround(Skipping CodeFragmentsyntax.)
        if child is ExtendedTokenSyntax {
          var childText = childText
          if childLength > upper {
            childText.truncate(at: childText.scalars.index(childText.startIndex, offsetBy: upper))
          }
          childText.removeFirst(lower)
          cropped.append(ExtendedTokenSyntax(kind: .fragment(childText)))
        } else {
          cropped.append(
            FragmentSyntax<AnyExtendedSyntax>(
              scalarOffsets: childOffsets,
              in: AnyExtendedSyntax(child)
            )
          )
        }
      } else if start > scalarOffsets.upperBound {
        break
      }
    }
    self.children = cropped
  }

  // MARK: - ExtendedSyntax

  public let children: [ExtendedSyntax]
}
