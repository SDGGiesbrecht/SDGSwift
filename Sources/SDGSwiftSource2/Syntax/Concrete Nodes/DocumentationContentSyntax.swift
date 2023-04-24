/*
 DocumentationContentSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Markdown

/// Documentation.
public struct DocumentationContent: BlockCommentContentProtocol, LineCommentContentProtocol,
  SyntaxNode
{

  // MARK: - Properties

  /// The source of the documentation content.
  public let source: String

  // MARK: - LineCommentContentProtocol

  public init(source: String) {
    self.source = source
  }

  // MARK: - SyntaxNode

  public func children(cache: inout ParserCache) -> [SyntaxNode] {
    let parsed = cache.parse(markdown: source)
    #warning("Not implemented yet.")
    fatalError()
  }

  // MARK: - TextOutputStreamable

  public func write<Target>(to target: inout Target) where Target: TextOutputStream {
    source.write(to: &target)
  }
}
