/*
 LineDeveloperCommentSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SwiftSyntax

  /// A line developer comment.
  public final class LineDeveloperCommentSyntax: LineCommentSyntax {

    // MARK: - Class Properties

    internal override class var delimiter: ExtendedTokenSyntax {
      return ExtendedTokenSyntax(text: "//", kind: .lineCommentDelimiter)
    }

    internal override class func parse(
      contents: String,
      siblings: Trivia,
      index: Trivia.Index
    ) -> ExtendedSyntax {
      return CommentContentSyntax(source: contents)
    }

    // MARK: - Properties

    /// The content of the comment.
    public var content: CommentContentSyntax {
      return _content as! CommentContentSyntax
    }
  }
