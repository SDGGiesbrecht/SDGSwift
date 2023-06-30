/*
 CodeContent.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

/// The content of code used in documentation.
public struct CodeContent: SyntaxNode {

  // MARK: - Initialization

  /// Parses code.
  ///
  /// - Parameters:
  ///   - source: The source.
  ///   - isSwift: `true` if the source is known to be Swift, `false` if it is known not to be Swift, or `nil` if the language is unknown.
  public init(source: String, isSwift: Bool?) {
    self.source = source
    self.isSwift = isSwift
  }

  // MARK: - Properties

  private let source: String
  private let isSwift: Bool?

  // MARK: - SyntaxNode

  public func children(cache: inout ParserCache) -> [SyntaxNode] {
    if isSwift ≠ false,
      let parsed = cache.parse(swift: source)
    {
      return [parsed]  // @exempt(from: tests) Unreachable without SwiftSyntax.
    } else {
      return [Token(kind: .source(source))]
    }
  }

  // MARK: - TextOutputStreamable

  public func write<Target>(to target: inout Target) where Target: TextOutputStream {
    source.write(to: &target)
  }
}
