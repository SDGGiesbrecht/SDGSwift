/*
 FragmentSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics
  import SDGCollections

  /// A smaller fragment of a larger syntax node.
  public final class FragmentSyntax: ExtendedSyntax {

    // MARK: - Initialization

    internal init(scalarOffsets: CountableRange<Int>, in syntax: ExtendedSyntax) {
      context = syntax

      var cropped: [ExtendedSyntax] = []
      var index = 0
      for child in syntax.children {
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

          if let code = child as? CodeFragmentSyntax {
            let newStart = code.range.lowerBound + childOffsets.lowerBound
            let newEnd = code.range.lowerBound + childOffsets.upperBound
            cropped.append(
              CodeFragmentSyntax(range: newStart..<newEnd, in: code.context, isSwift: code.isSwift)
            )
          } else if let token = child as? ExtendedTokenSyntax {
            var childText = childText
            if childLength > upper {
              childText.truncate(at: childText.scalars.index(childText.startIndex, offsetBy: upper))
            }
            childText.removeFirst(lower)
            cropped.append(ExtendedTokenSyntax(text: childText, kind: token.kind))
          } else {
            cropped.append(FragmentSyntax(scalarOffsets: childOffsets, in: child))
          }
        } else if start > scalarOffsets.upperBound {
          break
        }
      }
      super.init(children: cropped)
    }

    // MARK: - Properties

    internal let context: ExtendedSyntax

    // MARK: - ExtendedSyntax

    internal override func setTreeRelationships() {
      super.setTreeRelationships()
      context.setTreeRelationships()
    }
  }
