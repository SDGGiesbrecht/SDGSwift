/*
 MarkdownHeading.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A Markdown heading.
public protocol MarkdownHeading: SyntaxNode {

  /// The heading text.
  var heading: [SyntaxNode] { get }

  /// The heading level.
  var level: Int { get }
}
