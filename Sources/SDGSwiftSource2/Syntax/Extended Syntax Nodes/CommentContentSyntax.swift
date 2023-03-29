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
import SDGCollections
import SDGText

/// The content of a comment.
public struct CommentContentSyntax: ExtendedSyntax, LineCommentContentProtocol {

  // MARK: - Initialization

  internal init(source: String) {  // @exempt(from: tests)  Unreachable from tvOS.
    var children: [ExtendedSyntax] = []
    for lineInfo in source.lines {
      if ¬lineInfo.line.isEmpty {
        var line = lineInfo.line[...]

        func check(forHeading heading: String) {
          if line.hasPrefix(heading.scalars.literal()) {
            line.removeFirst(heading.scalars.count)
            children.append(
              SourceHeadingSyntax(
                mark: ExtendedTokenSyntax(kind: .mark(heading)),
                heading: ExtendedTokenSyntax(
                  kind: .sourceHeadingText(String(String.UnicodeScalarView(line)))
                )
              )
            )
            line = "".scalars[...]
          }
        }
        check(forHeading: SourceHeadingSyntax.fullDelimiter)
        #warning("Crashing on Linux?")
        /*check(forHeading: SourceHeadingSyntax.minimalDelimiter)

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
            children.append(ExtendedTokenSyntax(kind: .commentText(String(String.UnicodeScalarView(line[..<start])))))
          }
          children.append(ExtendedTokenSyntax(kind: .commentURL(String(String.UnicodeScalarView(line[start..<end])))))
          line.removeSubrange(line.startIndex..<end)
        }

        if ¬line.isEmpty {
          children.append(ExtendedTokenSyntax(kind: .commentText(String(String.UnicodeScalarView(line)))))
        }*/
      }
      #warning("Crashing on Linux?")
      /*if ¬lineInfo.newline.isEmpty {
        children.append(ExtendedTokenSyntax(kind: .lineBreaks(String(String.UnicodeScalarView(lineInfo.newline)))))
      }*/
    }
    self.children = children
  }

  // MARK: - ExtendedSyntax

  public let children: [ExtendedSyntax]
}
