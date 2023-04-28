/*
 LineFragment.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A line fragment.
public struct LineFragment<Content>: StreamedViaChildren, SyntaxNode where Content: SyntaxNode {

  // MARK: - Initialization

  /// Creates a line fragment node.
  ///
  /// - Parameters:
  ///   - indent: The indent.
  ///   - content: The content.
  ///   - lineBreak: The trailing line break.
  public init(indent: Token?, content: Content, lineBreak: Token?) {
    self.indent = indent
    self.content = content
    self.lineBreak = lineBreak
  }

  // MARK: - Properties

  /// The indent.
  public let indent: Token?

  /// The content.
  public let content: Content

  /// The trailing lineBreak
  public let lineBreak: Token?

  // MARK: - StreamedViaChildren

  internal var storedChildren: [SyntaxNode] {
    var result: [SyntaxNode] = []
    if let indent = indent {
      result.append(indent)
    }
    result.append(content)
    if let lineBreak = lineBreak {
      result.append(lineBreak)
    }
    return result
  }
}
