/*
 LineDocumentationSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
  import SDGMathematics

  import SwiftSyntax

  /// A line documentation comment.
  public final class LineDocumentationSyntax: LineCommentSyntax {

    // MARK: - Class Properties

    internal override class var delimiter: ExtendedTokenSyntax {
      return ExtendedTokenSyntax(text: "///", kind: .lineDocumentationDelimiter)
    }

    internal override class func parse(contents: String, siblings: Trivia, index: Trivia.Index)
      -> ExtendedSyntax
    {
      func process(sibling: TriviaPiece) -> String {
        var siblingText = String(sibling.text.scalars.dropFirst(3))
        if siblingText.scalars.first == " " {
          siblingText.scalars.removeFirst()
        }
        return siblingText
      }

      var preceding: [String] = []
      var interveningNewlines = 0
      search: for searchIndex in (siblings.startIndex..<index).reversed() {
        let sibling = siblings[searchIndex]
        switch sibling {
        case .spaces, .tabs:
          continue
        case .verticalTabs(let number), .formfeeds(let number), .newlines(let number),
          .carriageReturns(let number), .carriageReturnLineFeeds(let number):
          interveningNewlines += number
          if interveningNewlines > 1 {
            break search
          }
        case .docLineComment:
          preceding.prepend(process(sibling: sibling))
          interveningNewlines = 0
        case .lineComment, .blockComment, .docBlockComment, .unexpectedText, .shebang:
          break search
        }
      }

      var following: [String] = []
      interveningNewlines = 0
      search: for searchIndex in siblings.index(after: index)..<siblings.endIndex {
        let sibling = siblings[searchIndex]
        switch sibling {
        case .spaces, .tabs:
          continue
        case .verticalTabs(let number), .formfeeds(let number), .newlines(let number),
          .carriageReturns(let number), .carriageReturnLineFeeds(let number):
          interveningNewlines += number
          if interveningNewlines > 1 {
            break search
          }
        case .docLineComment:
          following.append(process(sibling: sibling))
          interveningNewlines = 0
        case .lineComment, .blockComment, .docBlockComment, .unexpectedText, .shebang:
          break search
        }
      }

      let group = preceding + [contents] + following
      let togetherSource = group.joined(separator: "\n")
      let togetherSyntax = DocumentationSyntax.parse(source: togetherSource)

      var precedingLength: Int = 0
      for line in preceding {
        precedingLength += line.scalars.count + 1
      }
      return FragmentSyntax(
        scalarOffsets: precedingLength..<precedingLength + contents.count,
        in: togetherSyntax
      )
    }

    // MARK: - Properties

    /// The content of the line documentation comment.
    public var content: FragmentSyntax {
      return _content as! FragmentSyntax
    }
  }
