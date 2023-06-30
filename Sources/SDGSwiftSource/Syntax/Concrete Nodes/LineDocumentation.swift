/*
 LineDocumentation.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A line documentation comment.
public struct LineDocumentation: SyntaxNode, LineCommentProtocol {

  // MARK: - Initialization

  /// Parses a line documentation comment.
  public init?(
    source: String,
    precedingContentContext: String? = nil,
    followingContentContext: String? = nil
  ) {
    guard
      let parsed = Self.parse(
        precedingContentContext: precedingContentContext ?? "",
        source: source,
        followingContentContext: followingContentContext ?? ""
      )
    else {
      return nil
    }
    (delimiter, indent, content) = parsed
  }

  // MARK: - LineCommentSyntaxProtocol

  internal typealias Content = DocumentationContent

  internal static var delimiter: Token.Kind {
    return .lineDocumentationDelimiter
  }

  /// The delimiter.
  public let delimiter: Token

  /// The indent.
  public let indent: Token?

  /// The content of the line documentation comment.
  public let content: Fragment<DocumentationContent>
}
