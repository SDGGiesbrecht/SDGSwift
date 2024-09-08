/*
 LinkTarget.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// The target portion of link in documentation.
public struct LinkTarget: StreamedViaChildren, SyntaxNode {

  // MARK: - Properties

  /// The opening delimiter.
  public let openingDelimiter: Token

  /// The target URL.
  public let target: Token

  /// The closing delimiter.
  public let closingDelimiter: Token

  // MARK: - StreamedViaChildren

  internal var storedChildren: [SyntaxNode] {
    return [openingDelimiter, target, closingDelimiter]
  }
}
