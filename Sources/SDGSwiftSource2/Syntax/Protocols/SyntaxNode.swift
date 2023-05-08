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

  // @documentation(SyntaxNode.text())
  /// Returns the node’s source text.
  func text() -> String
}

extension SyntaxNode {

  // MARK: - Source

  // #documentation(SyntaxNode.text())
  /// Returns the node’s source text.
  public func text() -> String {
    var result = ""
    write(to: &result)
    return result
  }

  // MARK: - Scanning

  /// Scans the syntax tree by passing each node through a closure.
  ///
  /// This method is a streamlined use of the protocol `SyntaxScanner` for simpler use cases where a custom scanner type is not necessary. The provided closure will be called in the manner of `SyntaxScanner`’s `visit(_:context:)`. See that protocol for more details.
  ///
  /// - Parameters:
  ///     - visitNode: A closure which visits a syntax node.
  public func scanSyntaxTree(_ visitNode: @escaping (SyntaxNode, ScanContext) -> Bool) {
    var scanner = ClosureSyntaxScanner(visitNode)
    scanner.scan(self)
  }
}
