/*
 ParagraphNode.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A paragraph in documentation.
public struct ParagraphNode: StreamedViaChildren, SyntaxNode {

  // MARK: - Initialization

  internal init(components: [SyntaxNode]) {
    self.contents = components
  }

  // MARK: - Properties

  /// The contents of the paragraph.
  public let contents: [SyntaxNode]

  // MARK: - StreamedViaChildren

  internal var storedChildren: [SyntaxNode] {
    return contents
  }
}
