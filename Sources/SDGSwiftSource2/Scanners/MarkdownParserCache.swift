/*
 MarkdownParserCache.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

import Markdown

public struct MarkdownParserCache {

  // MARK: - Initialization

  /// Creates a Markdown parser cache.
  public init() {}

  // MARK: - Properties

  internal var parsed: [String: Markdown.Document] = [:]

  // MARK: - Parsing

  internal mutating func parse(source: String) -> Markdown.Document {
    return cached(in: &parsed[source]) {
      return Document(parsing: source)
    }
  }
}
