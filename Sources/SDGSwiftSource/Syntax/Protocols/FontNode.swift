/*
 FontNode.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A section of documentation text with font modifications.
public protocol FontNode: SyntaxNode {

  // MARK: - Properties

  /// The opening delimiter.
  var openingDelimiter: Token { get }

  /// The contents.
  var contents: [SyntaxNode] { get }

  /// The closing delimiter.
  var closingDelimiter: Token { get }
}

internal protocol FontNodeWithInternals: FontNode, StreamedViaChildren {
  static func makeDelimiterKind(_ source: String) -> Token.Kind
  init(openingDelimiter: Token, contents: [SyntaxNode], closingDelimiter: Token)
}

extension FontNodeWithInternals {

  // MARK: - Initialization

  internal init?(components: [SyntaxNode]) {
    var remainder = components[...]

    guard let opening = remainder.first as? Token else {
      return nil  // @exempt(from: tests) Believed to be unreachable.
    }
    remainder.removeFirst()
    let openingDelimiter = Token(kind: Self.makeDelimiterKind(opening.text()))

    guard let closing = remainder.last as? Token else {
      return nil  // @exempt(from: tests) Believed to be unreachable.
    }
    remainder.removeLast()
    let closingDelimiter = Token(kind: Self.makeDelimiterKind(closing.text()))

    self.init(
      openingDelimiter: openingDelimiter,
      contents: Array(remainder),
      closingDelimiter: closingDelimiter
    )
  }

  // MARK: - StreamedViaChildren

  internal var storedChildren: [SyntaxNode] {
    var children: [SyntaxNode] = [openingDelimiter]
    children.append(contentsOf: contents)
    children.append(closingDelimiter)
    return children
  }
}
