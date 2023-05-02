/*
 ListEntry.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// An entry in a Markdown list.
public struct ListEntry: StreamedViaChildren, SyntaxNode {

  // MARK: - Initialization

  internal init?(components: [SyntaxNode]) {
    var remainder = components[...]
    guard let bullet = remainder.first as? Token else {
      return nil  // @exempt(from: tests) Believed to be unreachable.
    }
    remainder.removeFirst()
    self.bullet = Token(kind: .bullet(bullet.text))

    guard let indent = remainder.first as? Token,
      case .whitespace = indent.kind
    else {
      return nil  // @exempt(from: tests) Believed to be unreachable.
    }
    self.indent = indent

    self.contents = Array(remainder)
  }

  // MARK: - Properties

  /// The delimiter.
  public let bullet: Token

  /// The indent between the bullet and the contents.
  public let indent: Token

  /// The contents of the list entry.
  public let contents: [SyntaxNode]

  // MARK: - StreamedViaChildren

  internal var storedChildren: [SyntaxNode] {
    var children: [SyntaxNode] = [bullet, indent]
    children.append(contentsOf: contents)
    return children
  }
}
