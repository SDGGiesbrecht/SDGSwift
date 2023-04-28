/*
 SyntaxNode.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A syntax node.
public protocol SyntaxNode: TextOutputStreamable {

  /// Returns the children of the node, parsing into more detail if necessary.
  func children(cache: inout ParserCache) -> [SyntaxNode]

  /// The node’s source text.
  var text: String { get }
}

extension SyntaxNode {

  /// The node’s source text.
  public var text: String {
    var result = ""
    write(to: &result)
    return result
  }
}
