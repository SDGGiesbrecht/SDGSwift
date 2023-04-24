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

  public init(_ markdown: Markup) {
    self.markdown = markdown
  }

  // MARK: - Properties

  public var markdown: Markup

  // MARK: - SyntaxNode

  public func children(cache: inout ParserCache) -> [SyntaxNode] {
    switch markdown {
    case let text as Text:
      return [Token(kind: .documentationText(text.string))]
    default:
      return markdown.children.map { MarkdownNode($0) }
    }
  }

  // MARK: - TextOutputStreamable

  public func write<Target>(to target: inout Target) where Target: TextOutputStream {
    markdown.format().write(to: &target)
  }
}
