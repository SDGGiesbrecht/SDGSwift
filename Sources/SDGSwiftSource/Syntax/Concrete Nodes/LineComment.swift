/*
 LineComment.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A line comment.
public struct LineComment: LineCommentProtocol, SyntaxNode {

  // MARK: - Initialization

  /// Parses a line comment.
  ///
  /// - Parameters:
  ///   - source: The source.
  public init?(source: String) {
    guard
      let parsed = Self.parse(
        precedingContentContext: "",
        source: source,
        followingContentContext: ""
      )
    else {
      return nil
    }
    (self.delimiter, self.indent, self.content) = parsed
  }

  // MARK: - Properties

  /// The delimiter.
  public let delimiter: Token

  /// The indent.
  public let indent: Token?

  /// The content.
  public let content: Fragment<CommentContent>

  // MARK: - LineCommentSyntaxProtocol

  internal static var delimiter: Token.Kind {
    return .lineCommentDelimiter
  }
}
