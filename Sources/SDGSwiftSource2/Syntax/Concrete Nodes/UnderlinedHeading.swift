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

/// A heading in source code using underline notation.
public struct UnderlinedHeading: StreamedViaChildren, SyntaxNode {

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
    self.lineBreak = Token(kind: .lineBreaks(String(remainder.removeFirst())))

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
  public let lineBreak: Token

  /// The underline.
  public let underline: Token

  // MARK: - StreamedViaChildren

  internal var storedChildren: [SyntaxNode] {
    return [heading, lineBreak, underline]
  }
}
