/*
 TriviaNode.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SwiftSyntax
#endif

/// A trivia node from the SwiftSyntax library.
public struct TriviaNode: SyntaxNode {

  // MARK: - Initialization

  #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
    /// Creates a node from a `Trivia` instance.
    ///
    /// - Parameters:
    ///   - trivia: The trivia.
    public init(_ trivia: Trivia) {
      self.trivia = trivia
    }
  #endif

  // MARK: - Properties

  #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
    /// The trivia.
    public let trivia: Trivia
  #endif

  // MARK: - Parsing

  #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
    private func lineDocumentationSourceGroups() -> [[String]] {
      var result: [[String]] = []
      var interveningLineBreaks = 0
      var interrupted = false
      for piece in trivia.pieces {
        switch piece {
        case .spaces, .tabs:
          continue
        case .verticalTabs, .formfeeds, .newlines, .carriageReturns, .carriageReturnLineFeeds:
          interveningLineBreaks += 1
        case .lineComment, .blockComment, .docBlockComment, .unexpectedText, .shebang:
          interrupted = true
        case .docLineComment(let line):
          defer {
            interveningLineBreaks = 0
            interrupted = false
          }
          var sourceFragment = line.scalars.dropFirst(3)
          if sourceFragment.first == " " {
            sourceFragment.removeFirst()
          }
          if result.isEmpty ∨ interveningLineBreaks > 1 ∨ interrupted {
            result.append([])
          }
          result[result.indices.last!].append(String(sourceFragment))
        }
      }
      return result
    }
  #endif

  // MARK: - SyntaxNode

  public func children(cache: inout ParserCache) -> [SyntaxNode] {  // @exempt(from: tests)
    // Unreachable without SwiftSyntax because initialization is impossible.
    #if PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
      return []
    #else
      var handledDocumentation: [[String]] = [[]]
      var pendingDocumentation: [[String]] = lineDocumentationSourceGroups()
      return trivia.pieces.map { piece in
        var currentSource: String?
        if case .docLineComment = piece,
          let groupIndex = pendingDocumentation.indices.first,
          ¬pendingDocumentation[groupIndex].isEmpty
        {
          currentSource = pendingDocumentation[groupIndex].removeFirst()
        }
        defer {
          if let current = currentSource,
            let groupIndex = handledDocumentation.indices.last
          {
            handledDocumentation[groupIndex].append(current)
          }
          if pendingDocumentation.first?.isEmpty == true {
            handledDocumentation.append(pendingDocumentation.removeFirst())
          }
        }

        return TriviaPieceNode(
          piece,
          precedingDocumentationContext: handledDocumentation.last?.appending("").joined(
            separator: "\n"
          ),
          followingDocumentationContext: pendingDocumentation.first?.prepending("").joined(
            separator: "\n"
          )
        )
      }
    #endif
  }

  // MARK: - TextOutputStreamable

  public func write<Target>(
    to target: inout Target
  ) where Target: TextOutputStream {  // @exempt(from: tests)
    // Unreachable without SwiftSyntax because initialization is impossible.
    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
      trivia.write(to: &target)
    #endif
  }
}
