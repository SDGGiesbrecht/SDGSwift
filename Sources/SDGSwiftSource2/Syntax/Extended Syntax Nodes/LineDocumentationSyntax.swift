/*
 LineDocumentationSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A line documentation comment.
public struct LineDocumentationSyntax: ExtendedSyntax, LineCommentSyntaxProtocol {

  // MARK: - Initialization

  public init(
    precedingContentContext: String? = nil,
    source: String,
    followingContentContext: String? = nil
  ) {
    (delimiter, indent, content) = Self.parse(
      precedingContentContext: precedingContentContext ?? "",
      source: source,
      followingContentContext: followingContentContext ?? ""
    )
  }

  // MARK: - LineCommentSyntaxProtocol

  internal typealias Content = DocumentationContentSyntax

  internal static var delimiter: ExtendedTokenKind {
    return .lineDocumentationDelimiter
  }

  /// The delimiter.
  public var delimiter: ExtendedTokenSyntax

  /// The indent.
  public var indent: ExtendedTokenSyntax?

  /// The content of the line documentation comment.
  public var content: FragmentSyntax<DocumentationContentSyntax>
}
