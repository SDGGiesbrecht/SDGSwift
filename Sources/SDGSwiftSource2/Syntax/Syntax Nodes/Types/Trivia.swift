/*
 Trivia.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SDGLogic

  import SwiftSyntax

  extension Trivia {

    internal func lineDocumentationSourceGroups() -> [[String]] {
      var result: [[String]] = []
      var interveningLineBreaks = 0
      var interrupted = false
      for piece in pieces {
        switch piece {
        case .spaces, .tabs:
          continue
        case .verticalTabs, .formfeeds, .newlines, .carriageReturns, .carriageReturnLineFeeds(_):
          interveningLineBreaks += 1
        case .lineComment, .blockComment, .docBlockComment, .unexpectedText, .shebang:
          interrupted = true
        case .docLineComment(let line):
          var sourceFragment = line.scalars.dropFirst(3)
          if sourceFragment.first == " " {
            sourceFragment.removeFirst()
          }
          if result.isEmpty ∨ interveningLineBreaks > 1 ∨ interrupted {
            result.append([])
            interveningLineBreaks = 0
            interrupted = false
          }
          result[result.indices.last!].append(String(sourceFragment))
        }
      }
      return result
    }
  }
#endif
