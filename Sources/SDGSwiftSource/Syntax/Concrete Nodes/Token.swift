/*
 Token.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A syntax node representing a single token.
public struct Token: SyntaxNode {

  internal static func unknown(_ source: String) -> Token {
    return Token(kind: .swiftSyntax(.unknown(source)))
  }

  // MARK: - Initialization

  /// Creates a token.
  ///
  /// - Parameters:
  ///   - kind: The kind of token.
  public init(kind: Kind) {
    self.kind = kind
  }

  // MARK: - Properties

  /// The kind of token.
  public let kind: Kind

  // MARK: - SyntaxNode

  public func children(cache: inout ParserCache) -> [SyntaxNode] {
    return []
  }

  // MARK: - TextOutputStreamable

  public func write<Target>(
    to target: inout Target
  ) where Target: TextOutputStream {
    kind.text.write(to: &target)
  }
}
