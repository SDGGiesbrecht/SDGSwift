/*
 LinkContent.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// The content portion of link in documentation.
public struct LinkContent: StreamedViaChildren, SyntaxNode {

  // MARK: - Properties

  /// The opening delimiter.
  public let openingDelimiter: Token

  /// The content.
  public let contents: [SyntaxNode]

  /// The closing delimiter.
  public let closingDelimiter: Token

  // MARK: - StreamedViaChildren

  internal var storedChildren: [SyntaxNode] {
    var children: [SyntaxNode] = [openingDelimiter]
    children.append(contentsOf: contents)
    children.append(closingDelimiter)
    return children
  }
}
