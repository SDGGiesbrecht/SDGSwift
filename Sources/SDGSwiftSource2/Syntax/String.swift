/*
 String.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText

import Markdown

extension String {

  private func scalarIndex(of location: SourceLocation) -> String.UnicodeScalarView.Index {
    let lineIndex =
      lines.index(lines.startIndex, offsetBy: location.line, limitedBy: lines.endIndex)
      ?? lines.endIndex
    let lineScalar = lineIndex.samePosition(in: scalars)
    let lineUTF8 = lineScalar.samePosition(in: utf8)!
    let columnUTF8 =
      utf8.index(lineUTF8, offsetBy: location.column, limitedBy: utf8.endIndex)
      ?? utf8.endIndex
    return columnUTF8.scalar(in: scalars)
  }

  internal func scalarRange(of sourceRange: Range<SourceLocation>) -> Range<
    String.UnicodeScalarView.Index
  > {
    return scalarIndex(of: sourceRange.lowerBound)..<scalarIndex(of: sourceRange.upperBound)
  }
}
