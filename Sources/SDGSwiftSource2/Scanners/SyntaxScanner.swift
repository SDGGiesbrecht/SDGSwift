/*
 SyntaxScanner.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A scanner for read‐only handling of a syntax tree.
public protocol SyntaxScanner {

  // @documentation(SDGSwiftSource.SyntaxScanner.visit)
  /// Visits a syntax node.
  ///
  /// Provide a custom implementation of this to read information from a particular node.
  ///
  /// - Parameters:
  ///     - node: The current node.
  ///
  /// - Returns: Whether or not the scanner should visit the node’s children. Types can speed up the scan by returning `false` if it is already known that nothing relevant could be nested within the node. For example, a scanner concerned with the exposed API does not care about function bodies, and can skip scanning them entirely by returning `false` whenever they appear.
  mutating func visit(_ node: SyntaxNode) -> Bool

  /// A cache for the syntax scanner.
  var cache: ParserCache { get set }
}

extension SyntaxScanner {

  // MARK: - Default Implementations

  // #workaround(workspace version 0.42.0, Redundant documentation, but inheritance is broken.)
  // #documentation(SDGSwiftSource.SyntaxScanner.visit)
  /// Visits a syntax node.
  ///
  /// Provide a custom implementation of this to read information from a particular node.
  ///
  /// - Parameters:
  ///     - node: The current node.
  ///
  /// - Returns: Whether or not the scanner should visit the node’s children. Types can speed up the scan by returning `false` if it is already known that nothing relevant could be nested within the node. For example, a scanner concerned with the exposed API does not care about function bodies, and can skip scanning them entirely by returning `false` whenever they appear.
  public mutating func visit(_ node: SyntaxNode) -> Bool {
    return true
  }

  // MARK: - Scanning

  // @documentation(SDGSwiftSource.SyntaxScanner.scan)
  /// Scans the node and its children.
  ///
  /// - Parameters:
  ///     - node: The node to scan.
  public mutating func scan(_ node: SyntaxNode) {
    if visit(node) {
      for child in node.children(cache: &cache) {
        scan(child)
      }
    }
  }
}
