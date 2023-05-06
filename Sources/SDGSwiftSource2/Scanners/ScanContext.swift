/*
 ScanContext.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// The context of a node to be visited by a syntax scanner.
public struct ScanContext {

  /// The node’s ancestors in the global syntax context.
  ///
  /// The global syntax context is the syntax tree accessible by traversing fragmentation into parent contexts. That is, the root node of code in a documentation comment is the file containing the documentation comment, and if the code is in a fragmented code block, the node representing the code block itself will not participate in the graph, but rather each fragment will be individually related to the documentation node.
  public let globalAncestors: [SyntaxNode]
}
