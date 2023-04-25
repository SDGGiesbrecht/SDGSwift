/*
 MarkdownNode.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Markdown

/// A syntax node from the Markdown library.
public struct MarkdownNode: SyntaxNode, TextOutputStreamable {

  // MARK: - Initialization

  /// Creates a Markdown node by parsing source.
  ///
  /// - Parameters:
  ///   - source: The Markdown source.
  public init(source: String) {
    self.init(
      unsafeMarkdown: Document(parsing: source),
      rootSource: source,
      range: source.scalars.bounds
    )
  }

  /// This must remain private to ensure only *parsed* nodes are accepted, so that they have the requisite range information. See `children`.
  private init(
    unsafeMarkdown markdown: Markup,
    rootSource: String,
    range: Range<String.UnicodeScalarView.Index>
  ) {
    self.markdown = markdown
    self.rootSource = rootSource
    self.range = range
  }

  // MARK: - Properties

  /// The Markdown node.
  public let markdown: Markup
  private let rootSource: String
  private let range: Range<String.UnicodeScalarView.Index>

  // MARK: - SyntaxNode

  public func children(cache: inout ParserCache) -> [SyntaxNode] {
    switch markdown {
    case is SoftBreak:
      return [Token(kind: .lineBreaks(text))]
    case is Text:
      return [Token(kind: .documentationText(text))]
    default:
      var lastAccountedForIndex: String.UnicodeScalarView.Index = self.range.lowerBound
      return markdown.children.map { child in
        let childRange: Range<String.UnicodeScalarView.Index>
        defer { lastAccountedForIndex = childRange.upperBound }
        if let knownRange = child.range {
          childRange = rootSource.scalarRange(of: knownRange)
        } else {
          childRange = lastAccountedForIndex..<lastAccountedForIndex
        }
        return MarkdownNode(
          unsafeMarkdown: child,
          rootSource: rootSource,
          range: childRange
        )
      }
    }
  }

  // MARK: - TextOutputStreamable

  public func write<Target>(to target: inout Target) where Target: TextOutputStream {
    String(String.UnicodeScalarView(rootSource.scalars[range])).write(to: &target)
  }
}
