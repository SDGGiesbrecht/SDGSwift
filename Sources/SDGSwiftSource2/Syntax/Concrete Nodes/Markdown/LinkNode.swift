/*
 LinkNode.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A link in documentation.
public struct LinkNode: StreamedViaChildren, SyntaxNode {

  // MARK: - Initialization

  internal init?(components: [SyntaxNode]) {
    var remainder = components[...]

    guard let opening = remainder.first as? Token else {
      return nil  // @exempt(from: tests) Believed to be unreachable.
    }
    remainder.removeFirst()
    let openingDelimiter = Token(kind: .linkDelimiter(opening.text))

    guard let unprocessedTarget = remainder.last as? Token else {
      return nil  // @exempt(from: tests) Believed to be unreachable.
    }
    remainder.removeLast()

    var targetRemainder = unprocessedTarget.text[...]

    guard targetRemainder.first == "]" else {
      return nil  // @exempt(from: tests) Believed to be unreachable.
    }
    self.content = LinkContent(
      openingDelimiter: openingDelimiter,
      contents: Array(remainder),
      closingDelimiter: Token(kind: .linkDelimiter(String(targetRemainder.removeFirst())))
    )

    guard targetRemainder.first == "(" else {
      return nil  // @exempt(from: tests) Believed to be unreachable.
    }
    let targetStart = Token(kind: .linkDelimiter(String(targetRemainder.removeFirst())))

    guard targetRemainder.last == ")" else {
      return nil  // @exempt(from: tests) Believed to be unreachable.
    }
    let targetEnd = Token(kind: .linkDelimiter(String(targetRemainder.removeLast())))

    self.target = LinkTarget(
      openingDelimiter: targetStart,
      target: Token(kind: .linkURL(String(targetRemainder))),
      closingDelimiter: targetEnd
    )
  }

  // MARK: - Properties

  /// The content.
  public let content: LinkContent

  /// The target.
  public let target: LinkTarget

  // MARK: - StreamedViaChildren

  internal var storedChildren: [SyntaxNode] {
    return [content, target]
  }
}
