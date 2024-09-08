/*
 EmphasisNode.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// The application of an emphatic font to documentation text.
public struct EmphasisNode: FontNodeWithInternals {

  // MARK: - Properties

  public let openingDelimiter: Token
  public let contents: [SyntaxNode]
  public let closingDelimiter: Token

  // MARK: - FontNodeWithInternals

  internal static func makeDelimiterKind(_ source: String) -> Token.Kind {
    return .emphasisDelimiter(source)
  }
}
