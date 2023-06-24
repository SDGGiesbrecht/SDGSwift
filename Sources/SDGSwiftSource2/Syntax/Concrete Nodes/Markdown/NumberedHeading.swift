/*
 NumberedHeading.swift

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

/// A heading in documentation using number sign notation.
public struct NumberedHeading: MarkdownHeading, StreamedViaChildren, SyntaxNode {

  // MARK: - Initialization

  /// Parses a numbered heading.
  ///
  /// - Parameters:
  ///   - source: The source.
  public init?(source: String) {
    var remainder = source[...]

    var delimiter = ""
    while remainder.unicodeScalars.first == "#" {
      delimiter.append(remainder.removeFirst())
    }
    guard ¬delimiter.isEmpty else {
      return nil
    }
    self.delimiter = Token(kind: .headingDelimiter(delimiter))

    if remainder.first == " " {
      self.indent = Token(kind: .whitespace(String(remainder.removeFirst())))
    } else {
      self.indent = nil
    }

    heading = Token(kind: .documentationText(String(remainder)))
  }

  // MARK: - Properties

  /// The delimiter.
  public let delimiter: Token

  /// Any space between the delimiter and the heading text.
  public let indent: Token?

  /// The heading text.
  public let heading: Token

  public var level: Int {
    return delimiter.text().unicodeScalars.count
  }

  // MARK: - StreamedViaChildren

  internal var storedChildren: [SyntaxNode] {
    var children: [SyntaxNode] = [delimiter]
    if let indent = indent {
      children.append(indent)
    }
    children.append(heading)
    return children
  }
}
