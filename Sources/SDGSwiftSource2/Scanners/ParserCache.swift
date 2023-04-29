/*
 ParserCache.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_MARKDOWN
  import Markdown
#endif

public struct ParserCache {

  // MARK: - Initialization

  /// Creates a parser cache.
  public init() {}

  // MARK: - Properties

  public var parsedSwift: [String: SwiftSyntaxNode?] = [:]
  public var parsedMarkdown: [String: MarkdownNode] = [:]

  // MARK: - Parsing

  internal mutating func parse(swift: String) -> SwiftSyntaxNode? {
    return cached(in: &parsedSwift[swift]) {
      #if PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
        return nil
      #else
        return try? SwiftSyntaxNode(source: swift)
      #endif
    }
  }

  internal mutating func parse(markdown: String) -> MarkdownNode {
    return cached(in: &parsedMarkdown[markdown]) {
      return MarkdownNode(source: markdown)
    }
  }
}
