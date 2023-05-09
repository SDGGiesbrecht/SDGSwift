/*
 ScanContext.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

import SDGSwift

/// The context of a node to be visited by a syntax scanner.
public struct ScanContext {

  // MARK: - Stored Properties

  /// The location of the node within the scan, as a Unicode scalar offset.
  ///
  /// This is an offset into whatever node is at the root of the scan. It will only correspond to an offset into a file if the scan was started from a file node.
  public let location: Range<String.ScalarOffset>

  /// The node’s ancestors in the global syntax context.
  ///
  /// The global syntax context is the syntax tree accessible by traversing fragmentation into parent contexts. That is, the root node of code in a documentation comment is the file containing the documentation comment, and if the code is in a fragmented code block, the node representing the code block itself will not participate in the graph, but rather each fragment will be individually related to the documentation node.
  public let globalAncestors: [ParentRelationship]

  /// The node’s ancestors in the local syntax context.
  ///
  /// The local syntax context is the syntax tree accessible without traversing fragmentation into parent contexts. That is, the root node of code in a documentation comment is the node representing the code block’s contents and its tree ignores any intervening documentation delimiters or indentation belonging to the outer file context.
  public let localAncestors: [ParentRelationship]

  // MARK: - Computed Properties

  /// Returns whether the context is relevant to compilation.
  ///
  /// Nodes within trivia are not compiled. Most notably, this method can be used to differentiate Swift code that is part of the main file (which is compiled) and Swift code provided as an example inside a documentation comment (which is not compiled).
  public func isCompiled() -> Bool {
    return ¬globalAncestors.contains(where: { $0.node is TriviaNode })
  }
}
