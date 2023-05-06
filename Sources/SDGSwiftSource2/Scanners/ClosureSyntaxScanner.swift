/*
 ClosureSyntaxScanner.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

internal struct ClosureSyntaxScanner: SyntaxScanner {

  // MARK: - Initialization
  internal init(
    _ visitNode: @escaping (SyntaxNode, ScanContext) -> Bool
  ) {
    self.visitNode = visitNode
  }

  // MARK: - Properties

  private let visitNode: (SyntaxNode, ScanContext) -> Bool

  // MARK: - SyntaxScanner

  internal func visit(_ node: SyntaxNode, context: ScanContext) -> Bool {
    return visitNode(node, context)
  }

  internal var cache: ParserCache = ParserCache()
}
