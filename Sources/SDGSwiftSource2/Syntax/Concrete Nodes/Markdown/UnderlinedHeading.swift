/*
 UnderlinedHeading.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_MARKDOWN
  import Markdown
#endif

/// A heading in documentation using underline notation.
public struct UnderlinedHeading: MarkdownHeading, StreamedViaChildren, SyntaxNode {

  // MARK: - Initialization

  internal init?(components: [SyntaxNode]) {
    var remainder = components[...]

    var heading: [SyntaxNode] = []
    lineBreakScan: while let first = remainder.first {
      if case .lineBreaks = (first as? Token)?.kind {
        break lineBreakScan
      } else {
        heading.append(remainder.removeFirst())
      }
    }
    self.heading = heading

    guard let lineBreakToken = (remainder.first as? Token),
      case .lineBreaks = lineBreakToken.kind else {
      return nil
    }
    self.medialLineBreak = lineBreakToken
    remainder.removeFirst()

    if let trailingLineBreakToken = remainder.last as? Token,
      case .lineBreaks = trailingLineBreakToken.kind {
      self.trailingLineBreak = trailingLineBreakToken
      remainder.removeLast()
    } else {
      self.trailingLineBreak = nil
    }

    guard remainder.count == 1,
      let underlineToken = remainder.first as? Token,
        underlineToken.text().unicodeScalars.allSatisfy({ $0 == "=" })
          ∨ underlineToken.text().unicodeScalars.allSatisfy({ $0 == "\u{2D}" })
    else {
      return nil
    }
    self.underline = Token(kind: .headingDelimiter(underlineToken.text()))
  }

  // MARK: - Properties

  /// The heading text.
  public let heading: [SyntaxNode]

  /// The line break between the heading and its underline.
  public let medialLineBreak: Token

  /// The underline.
  public let underline: Token

  /// The line break after the underline.
  public let trailingLineBreak: Token?

  public var level: Int {
    if underline.text().unicodeScalars.first == "=" {
      return 1
    } else {
      return 2
    }
  }

  // MARK: - StreamedViaChildren

  internal var storedChildren: [SyntaxNode] {
    var children: [SyntaxNode] = heading.appending(contentsOf: [medialLineBreak, underline])
    if let trailing = trailingLineBreak {
      children.append(trailing)
    }
    return children
  }
}
