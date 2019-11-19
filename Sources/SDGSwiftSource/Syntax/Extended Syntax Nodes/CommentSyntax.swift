/*
 CommentSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGLocalization

/// The content of a comment.
public class CommentContentSyntax: ExtendedSyntax {

  // MARK: - Initialization

  internal init(source: String) {
    var source = source
    var children: [ExtendedSyntax] = []

    for lineInfo in source.lines {
      if ¬lineInfo.line.isEmpty {
        var line = String(lineInfo.line)

        func check(forHeading heading: String) {
          if line.hasPrefix(heading) {
            line.removeFirst(heading.count)
            children.append(SourceHeadingSyntax(mark: heading, heading: line))
            line = ""
          }
        }
        check(forHeading: "MARK: \u{2D} ")
        check(forHeading: "MARK:")

        while let `protocol` = line.scalars.firstMatch(for: "://".scalars)?.range {
          let start =
            line.scalars[line.startIndex..<`protocol`.lowerBound].lastMatch(for: " ".scalars)?.range
              .upperBound ?? line.startIndex
          let end =
            line.scalars[`protocol`.upperBound..<line.scalars.endIndex].firstMatch(
              for: " ".scalars
            )?.range.lowerBound ?? line.endIndex

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

    super.init(children: children)
  }
}
