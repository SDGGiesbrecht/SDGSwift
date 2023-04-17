/*
 DocumentationContentSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// Documentation.
public struct DocumentationContentSyntax: BlockCommentContentProtocol, ExtendedSyntax,
  LineCommentContentProtocol
{

  // #workaround(Not parsed yet.)
  public var source: ExtendedTokenSyntax

  // MARK: - ExtendedSyntax

  public var children: [ExtendedSyntax] {
    return [source]
  }

  // MARK: - LineCommentContentProtocol

  public init(source: String) {
    // #workaround(Not parsed yet, nor has context been channelled here.)
    self.source = ExtendedTokenSyntax(kind: .source(source))
  }
}
