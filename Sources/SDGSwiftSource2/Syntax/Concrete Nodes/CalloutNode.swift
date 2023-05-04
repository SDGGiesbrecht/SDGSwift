/*
 CalloutNode.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Can docc handle this?)

import SDGText

import Markdown

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
    self.contents = [adjustedText]
      .appending(contentsOf: paragraphChildren.dropFirst())
      .appending(contentsOf: listItem.contents.dropFirst())
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
