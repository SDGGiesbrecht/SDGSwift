/*
 ParametersEntry.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_MARKDOWN
  import Markdown
#endif

/// An entry in the `Parameters` documentation callout.
public struct ParametersEntry: StreamedViaChildren, SyntaxNode {

  // MARK: - Initialization

  internal init?(listItem: ListItemNode, cache: inout ParserCache) {
    self.bullet = listItem.bullet
    self.indent = listItem.indent

    #if PLATFORM_NOT_SUPPORTED_BY_SWIFT_MARKDOWN
      return nil
    #else
      guard let markdownParagraph = listItem.contents.first as? MarkdownNode,
        markdownParagraph.markdown is Paragraph,
        let paragraph = markdownParagraph.children(cache: &cache).first as? ParagraphNode
      else {
        return nil
      }
      let paragraphChildren = paragraph.children(cache: &cache)
      guard let textNode = paragraphChildren.first as? MarkdownNode,
        textNode.markdown is Text
      else {
        return nil
      }

      let text = textNode.text()
      guard let colon = text.scalars.firstIndex(of: ":") else {
        return nil
      }
      let name = String(text[..<colon])
      self.parameterName = Token(kind: .calloutParameter(name))
      self.colon = Token(kind: .calloutColon)

      var remainder = String(text[colon...].dropFirst())
      var indentString = ""
      while remainder.first == " " {
        indentString.append(remainder.removeFirst())
      }
      self.contentIndent = Token(kind: .whitespace(indentString))

      let adjustedText = Token(kind: .documentationText(remainder))
      let reconstructedParagraph = ParagraphNode(components: [adjustedText]
        .appending(contentsOf: paragraphChildren.dropFirst()))
      self.contents = [reconstructedParagraph]
        .appending(contentsOf: listItem.contents.dropFirst())
    #endif
  }

  // MARK: - Properties

  /// The delimiter.
  public let bullet: Token

  /// The indent between the bullet and the contents.
  public let indent: Token

  /// The parameter name.
  public let parameterName: Token

  /// The colon after the name.
  public let colon: Token

  /// The  indent between the colon and the content.
  public let contentIndent: Token

  /// The contents of the entry.
  public let contents: [SyntaxNode]

  // MARK: - StreamedViaChildren

  internal var storedChildren: [SyntaxNode] {
    var children: [SyntaxNode] = [bullet, indent, parameterName, colon, contentIndent]
    children.append(contentsOf: contents)
    return children
  }
}
