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
    self.init(unsafeMarkdown: Document(parsing: source), source: source)
  }

  /// This must remain private to ensure only *parsed* nodes are accepted, so that they have the requisite range information. See `children`.
  private init(unsafeMarkdown markdown: Markup, source: String) {
    self.markdown = markdown
    self.source = source
  }

  // MARK: - Properties

  /// The Markdown node.
  public let markdown: Markup
  private let source: String

  // MARK: - SyntaxNode

  public func children(cache: inout ParserCache) -> [SyntaxNode] {
    switch markdown {
    case let text as Text:
      return [Token(kind: .documentationText(text.string))]
    case let lineBreak as LineBreak:
      return [Token(kind: .lineBreaks(lineBreak.plainText))]
    default:
      return markdown.children.map { node in
        #warning("Debugging...")
        assert(node.range != nil, "Node does not know its range: \(node)")
        
        let range = node.range!  // If a node knows its range; so will its children.
        return MarkdownNode(unsafeMarkdown: node, source: source[range])
      }
    }
  }

  // MARK: - TextOutputStreamable

  public func write<Target>(to target: inout Target) where Target: TextOutputStream {
    source.write(to: &target)
  }
}
