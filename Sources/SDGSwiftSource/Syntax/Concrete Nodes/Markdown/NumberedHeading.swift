/*
 NumberedHeading.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

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

  internal init?(components: [SyntaxNode]) {
    var remainder = components[...]

    guard let delimiterToken = remainder.first as? Token,
          delimiterToken.text().unicodeScalars.allSatisfy({ $0 == "#" }) else {
      return nil
    }
    remainder.removeFirst()
    self.delimiter = Token(kind: .headingDelimiter(delimiterToken.text()))

    if let indent = remainder.first as? Token,
      case .whitespace = indent.kind {
      remainder.removeFirst()
      self.indent = indent
    } else {
      self.indent = nil  // @exempt(from: tests) Seems unreachable.
    }

    self.heading = Array(remainder)
  }

  // MARK: - Properties

  /// The delimiter.
  public let delimiter: Token

  /// Any space between the delimiter and the heading text.
  public let indent: Token?

  /// The heading text.
  public let heading: [SyntaxNode]

  public var level: Int {
    return delimiter.text().unicodeScalars.count
  }

  // MARK: - StreamedViaChildren

  internal var storedChildren: [SyntaxNode] {
    var children: [SyntaxNode] = [delimiter]
    if let indent = indent {
      children.append(indent)
    }
    children.append(contentsOf: heading)
    return children
  }
}
