/*
 BlockCommentContentProtocol.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// Functionality shared by line comment content and documentation comment content.
internal protocol BlockCommentContentProtocol: SyntaxNode {

  /// Parses block comment content from source.
  init(source: String)
}
