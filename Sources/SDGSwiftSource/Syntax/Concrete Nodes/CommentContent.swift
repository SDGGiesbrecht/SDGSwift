/*
 CommentContent.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGCollections
import SDGText

/// The content of a comment.
public struct CommentContent: BlockCommentContentProtocol, StreamedViaChildren, SyntaxNode,
  LineCommentContentProtocol
{

  // MARK: - Initialization

  /// Creates a comment content syntax note by parsing its source.
  ///
  /// - Parameters:
  ///   - source: The source.
  public init(source: String) {
    var children: [SyntaxNode] = []
    for lineInfo in source.lines {
      if ¬lineInfo.line.isEmpty {
        var line = lineInfo.line[...]

        func check(forHeading heading: String) {
          if line.hasPrefix(heading.scalars.literal()) {
            line.removeFirst(heading.scalars.count)
            children.append(
              SourceHeading(
                mark: Token(kind: .mark(heading)),
                heading: Token(
                  kind: .sourceHeadingText(String(String.UnicodeScalarView(line)))
                )
              )
            )
            line = "".scalars[...]
          }
        }
        check(forHeading: SourceHeading.fullDelimiter)
        check(forHeading: SourceHeading.minimalDelimiter)

        while let `protocol` = line.firstMatch(for: "://".scalars.literal())?.range {
          let start =
            line[line.startIndex..<`protocol`.lowerBound]
            .lastMatch(for: " ".scalars.literal(for: String.ScalarView.SubSequence.self))?.range
            .upperBound ?? line.startIndex
          let end =
            line[`protocol`.upperBound..<line.endIndex]
            .firstMatch(for: " ".scalars.literal(for: String.ScalarView.SubSequence.self))?.range
            .lowerBound ?? line.endIndex

          if start ≠ line.startIndex {
            children.append(
              Token(
                kind: .commentText(String(String.UnicodeScalarView(line[..<start])))
              )
            )
          }
          children.append(
            Token(
              kind: .commentURL(String(String.UnicodeScalarView(line[start..<end])))
            )
          )
          line = lineInfo.line[end...]
        }

        if ¬line.isEmpty {
          children.append(
            Token(kind: .commentText(String(String.UnicodeScalarView(line))))
          )
        }
      }
      if ¬lineInfo.newline.isEmpty {
        children.append(
          Token(kind: .lineBreaks(String(String.UnicodeScalarView(lineInfo.newline))))
        )
      }
    }
    self.storedChildren = children
  }

  // MARK: - StreamedViaChildren

  internal let storedChildren: [SyntaxNode]
}
