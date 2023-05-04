/*
 CalloutNode.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGText

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_MARKDOWN
  import Markdown
#endif

// #workaround(Can docc handle this?)

/// A documentation callout.
public struct CalloutNode: StreamedViaChildren, SyntaxNode {

  // MARK: - Initialization

  internal init?(listItem: ListItemNode, cache: inout ParserCache) {
    self.bullet = listItem.bullet
    self.indent = listItem.indent

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

    let text = textNode.text
    guard let colon = text.scalars.firstIndex(of: ":") else {
      return nil
    }
    var name = String(text[..<colon])
    if let space = name.scalars.firstIndex(of: " ") {
      defer { name = String(name[..<space]) }
      self.space = Token(kind: .whitespace(" "))
      self.parameterName = Token(
        kind: .calloutParameter(String(name.scalars[space...].dropFirst()))
      )
    } else {
      self.space = nil
      self.parameterName = nil
    }

    guard let callout = Callout(name) else {
      return nil
    }
    self.callout = callout
    self.name = Token(kind: .callout(name))
    self.colon = Token(kind: .calloutColon)

    let adjustedText = Token(kind: .documentationText(String(text[colon...].dropFirst())))
    let simpleContents = [adjustedText]
      .appending(contentsOf: paragraphChildren.dropFirst())
      .appending(contentsOf: listItem.contents.dropFirst())
    if callout ≠ .parameters {
      self.contents = simpleContents
    } else {
      self.contents = simpleContents.flatMap { content in
        guard let unordered = content as? MarkdownNode,
          unordered.markdown is UnorderedList
        else {
          return [content]
        }
        return unordered.children(cache: &cache).map { unorderedChild in
          guard let item = unorderedChild as? MarkdownNode,
            item.markdown is ListItem
          else {
            return unorderedChild
          }
          let itemChildren = item.children(cache: &cache)
          guard let parsed = itemChildren.first as? ListItemNode,
            itemChildren.count == 1
          else {
            return item  // @exempt(from: tests) Theoretically unreachable.
          }
          return ParametersEntry(listItem: parsed, cache: &cache) ?? item
        }
      }
    }
  }

  // MARK: - Properties

  /// The callout.
  let callout: Callout

  /// The delimiter.
  public let bullet: Token

  /// The indent between the bullet and the contents.
  public let indent: Token

  /// The callout name.
  public let name: Token

  /// The space before the parameter name.
  public let space: Token?

  /// The parameter name.
  public let parameterName: Token?

  /// The colon after the name.
  public let colon: Token

  /// The contents of the callout.
  public let contents: [SyntaxNode]

  // MARK: - StreamedViaChildren

  internal var storedChildren: [SyntaxNode] {
    var children: [SyntaxNode] = [bullet, indent, name]
    if let space = space {
      children.append(space)
    }
    if let parameterName = parameterName {
      children.append(parameterName)
    }
    children.append(colon)
    children.append(contentsOf: contents)
    return children
  }
}
