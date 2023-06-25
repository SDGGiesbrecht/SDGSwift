/*
 DocumentationContentSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_MARKDOWN
  import Markdown
#endif

/// Documentation.
public struct DocumentationContent: BlockCommentContentProtocol, LineCommentContentProtocol,
  SyntaxNode
{

  // MARK: - Properties

  /// The source of the documentation content.
  public let source: String

  /// Finds and returns the description section.
  public func descriptionSection(cache: inout ParserCache) -> ParagraphNode? {
    var cache = ParserCache()
    return
      // MarkdownNode(Document)
      children(cache: &cache).lazy.compactMap({ $0 as? MarkdownNode }).first?
      // MarkdownNode(Paragraph)
      .children(cache: &cache).lazy.compactMap({ $0 as? MarkdownNode }).first?
      // ParagraphNode
      .children(cache: &cache).first as? ParagraphNode
  }

  /// Finds and returns the discussion section.
  public func discussionSections(cache: inout ParserCache) -> [SyntaxNode] {
    var cache = ParserCache()
    if let result =
      // MarkdownNode(Document)
      children(cache: &cache).lazy.compactMap({ $0 as? MarkdownNode }).first?
      // Paragraphs
      .children(cache: &cache)
      // Drop first paragraph and paragraph break.
      .dropFirst(2) {
      return Array(result)
    } else {
      return []
    }
  }

  // MARK: - LineCommentContentProtocol

  public init(source: String) {
    self.source = source
  }

  // MARK: - SyntaxNode

  public func children(cache: inout ParserCache) -> [SyntaxNode] {
    return [cache.parse(markdown: source)]
  }

  // MARK: - TextOutputStreamable

  public func write<Target>(to target: inout Target) where Target: TextOutputStream {
    source.write(to: &target)
  }
}
