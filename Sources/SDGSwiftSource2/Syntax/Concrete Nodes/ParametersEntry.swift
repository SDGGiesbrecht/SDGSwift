/*
 ParametersEntry.swift

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

/// An entry in the `Parameters` documentation callout.
public struct ParametersEntry: StreamedViaChildren, SyntaxNode {

  // MARK: - Initialization

  internal init?(listItem: ListItemNode, cache: inout ParserCache) {
    self.bullet = listItem.bullet
    self.indent = listItem.indent

    #if PLATFORM_NOT_SUPPORTED_BY_SWIFT_MARKDOWN
      return nil
    #else
      guard let paragraph = listItem.contents.first as? MarkdownNode,
        paragraph.markdown is Paragraph
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

      let adjustedText = Token(kind: .documentationText(String(text[colon...].dropFirst())))
      self.contents = [adjustedText]
        .appending(contentsOf: paragraphChildren.dropFirst())
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

  /// The contents of the entry.
  public let contents: [SyntaxNode]

  // MARK: - StreamedViaChildren

  internal var storedChildren: [SyntaxNode] {
    var children: [SyntaxNode] = [bullet, indent, parameterName, colon]
    children.append(contentsOf: contents)
    return children
  }
}
