/*
 String.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics
import SDGText

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_MARKDOWN
  import Markdown
#endif

extension String {

  #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_MARKDOWN
    private func scalarIndex(of location: SourceLocation) -> String.UnicodeScalarView.Index {
      let lineIndex =
        lines.index(lines.startIndex, offsetBy: location.line − 1, limitedBy: lines.endIndex)
        ?? lines.endIndex  // @exempt(from: tests)
      let lineScalar = lineIndex.samePosition(in: scalars)
      let lineUTF8 = lineScalar.samePosition(in: utf8)!
      let columnUTF8 =
        utf8.index(lineUTF8, offsetBy: location.column − 1, limitedBy: utf8.endIndex)
        ?? utf8.endIndex  // @exempt(from: tests)
      return columnUTF8.scalar(in: scalars)
    }

    internal func scalarRange(
      of sourceRange: Range<SourceLocation>
    ) -> Range<String.UnicodeScalarView.Index> {
      return scalarIndex(of: sourceRange.lowerBound)..<scalarIndex(of: sourceRange.upperBound)
    }
  #endif
}
