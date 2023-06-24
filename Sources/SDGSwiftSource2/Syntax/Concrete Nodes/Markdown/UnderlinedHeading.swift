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

  /// Parses an underlined heading.
  ///
  /// - Parameters:
  ///   - source: The source.
  public init?(source: String) {
    var remainder = source[...]

    var heading = ""
    while remainder.first?.isNewline == false {
      heading.append(remainder.removeFirst())
    }
    self.heading = Token(kind: .documentationText(heading))

    guard remainder.first?.isNewline == true else {
      return nil
    }
    self.medialLineBreak = Token(kind: .lineBreaks(String(remainder.removeFirst())))

    if remainder.last?.isNewline == true {
      self.trailingLineBreak = Token(kind: .lineBreaks(String(remainder.removeLast())))
    } else {
      self.trailingLineBreak = nil
    }

    guard
      remainder.allSatisfy({ $0 == "=" })
        ∨ remainder.allSatisfy({ $0 == "\u{2D}" })
    else {
      return nil
    }
    self.underline = Token(kind: .headingDelimiter(String(remainder)))
  }

  // MARK: - Properties

  /// The heading text.
  public let heading: Token

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
    var children: [SyntaxNode] = [heading, medialLineBreak, underline]
    if let trailing = trailingLineBreak {
      children.append(trailing)
    }
    return children
  }
}
