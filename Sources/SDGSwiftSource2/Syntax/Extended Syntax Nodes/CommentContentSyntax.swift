/*
 CommentContentSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGText

/// The content of a comment.
public struct CommentContentSyntax: ExtendedSyntax {
  
  // MARK: - Initialization

  internal init(source: String) {  // @exempt(from: tests)  Unreachable from tvOS.
    var children: [ExtendedSyntax] = []

    for lineInfo in source.lines {
      if ¬lineInfo.line.isEmpty {
        var line = lineInfo.line[...]

        func check(forHeading heading: String) {
          if line.hasPrefix(heading.scalars.literal()) {
            line.removeFirst(heading.scalars.count)
            children.append(SourceHeadingSyntax(mark: ExtendedTokenSyntax(kind: .mark(heading)), heading: ExtendedTokenSyntax(kind: .sourceHeadingText(String(String.UnicodeScalarView(line))))))
            line = "".scalars[...]
          }
        }
        check(forHeading: SourceHeadingSyntax.fullDelimiter)
        check(forHeading: SourceHeadingSyntax.minimalDelimiter)

        while let `protocol` = line.scalars.firstMatch(for: "://".scalars)?.range {
          let start =
            line.scalars[line.startIndex..<`protocol`.lowerBound]
            .lastMatch(for: " ".scalars.literal(for: String.ScalarView.SubSequence.self))?.range
            .upperBound ?? line.startIndex
          let end =
            line.scalars[`protocol`.upperBound..<line.scalars.endIndex]
            .firstMatch(for: " ".scalars.literal(for: String.ScalarView.SubSequence.self))?.range
            .lowerBound ?? line.endIndex

          if start ≠ line.startIndex {
            children.append(ExtendedTokenSyntax(text: String(line[..<start]), kind: .commentText))
          }
          children.append(ExtendedTokenSyntax(text: String(line[start..<end]), kind: .commentURL))
          line.scalars.removeSubrange(line.scalars.startIndex..<end)
        }

        if ¬line.isEmpty {
          children.append(ExtendedTokenSyntax(text: line, kind: .commentText))
        }
      }
      if ¬lineInfo.newline.isEmpty {
        children.append(ExtendedTokenSyntax(text: String(lineInfo.newline), kind: .newlines))
      }
    }

    self.children = children
  }

  // MARK: - ExtendedSyntax

  public let children: [ExtendedSyntax]
}
