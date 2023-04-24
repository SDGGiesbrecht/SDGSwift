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

  private func index(of location: SourceLocation) -> String.Index {
    let lineIndex =
      lines.index(lines.startIndex, offsetBy: location.line, limitedBy: lines.endIndex)
      ?? lines.endIndex
    let lineScalar = lineIndex.samePosition(in: scalars)
    let lineUTF8 = lineScalar.samePosition(in: utf8)!
    return utf8.index(lineUTF8, offsetBy: location.column, limitedBy: utf8.endIndex)
      ?? utf8.endIndex
  }

  internal subscript(_ sourceRange: Range<SourceLocation>) -> String {
    return String(self[index(of: sourceRange.lowerBound)..<index(of: sourceRange.upperBound)])
  }
}
