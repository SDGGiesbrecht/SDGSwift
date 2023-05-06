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
  /// - Parameters:
  ///   - node: The node.
  ///   - context: The context of the node.
  ///
  /// - Returns: Whether or not the scanner should visit the node’s children. Conforming types can speed up the scan by returning `false` if it is already known that nothing relevant could be nested within the node. For example, a scanner concerned with the exposed API does not care about function bodies, and can skip scanning them entirely by returning `false` whenever they appear.
  mutating func visit(_ node: SyntaxNode, context: ScanContext) -> Bool

  /// A cache for the syntax scanner.
  var cache: ParserCache { get set }
}

extension SyntaxScanner {

  // MARK: - Scanning

  // @documentation(SDGSwiftSource.SyntaxScanner.scan)
  /// Scans the node and its children.
  ///
  /// - Parameters:
  ///     - node: The node to scan.
  public mutating func scan(_ node: SyntaxNode) {
    scan(node, context: ScanContext(globalAncestors: []))
  }

  private mutating func scan(_ node: SyntaxNode, context: ScanContext) {
    if visit(node, context: context) {
      for child in node.children(cache: &cache) {
        scan(child, context: ScanContext(globalAncestors: context.globalAncestors.appending(node)))
      }
    }
  }
}
