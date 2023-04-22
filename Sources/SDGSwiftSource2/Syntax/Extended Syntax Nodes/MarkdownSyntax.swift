/*
 MarkdownSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Markdown

public struct MarkdownSyntax: ExtendedSyntax {

  // MARK: - Initialization

  public init(_ markUp: Markup) {
    self.markUp = markUp
  }

  // MARK: - Properties

  public var markUp: Markup

  // MARK: - ExtendedSyntax

  public var children: [ExtendedSyntax] {
    return markUp.children.map { MarkdownSyntax($0) }
  }
}
