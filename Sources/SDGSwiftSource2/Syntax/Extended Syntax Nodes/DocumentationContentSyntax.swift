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
public struct DocumentationContentSyntax: BlockCommentContentProtocol, ExtendedSyntax,
  LineCommentContentProtocol
{

  // MARK: - Properties

  public let source: ExtendedTokenSyntax

  // MARK: - ExtendedSyntax

  public var children: [ExtendedSyntax] {
    return [source]
  }

  // MARK: - LineCommentContentProtocol

  public init(source: String) {
    self.source = ExtendedTokenSyntax(kind: .source(source))
    // #warning(Haven’t done anything with this yet.)
    let markdown = Document(parsing: source)
  }
}
