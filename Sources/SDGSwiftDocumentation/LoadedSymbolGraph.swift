/*
 LoadedSymbolGraph.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SymbolKit

/// A symbol graph loaded from a file system.
public struct LoadedSymbolGraph {

  // MARK: - Initialization

  /// Creates a loaded symbol graph.
  ///
  /// - Parameters:
  ///   - graph: The graph.
  ///   - origin: The URL from which the graph was loaded.
  public init(graph: SymbolGraph, origin: URL) {
    self.graph = graph
    self.origin = origin
  }

  // MARK: - Properties

  /// The symbol graph.
  public let graph: SymbolGraph
  /// The URL from which the graph originated.
  public let origin: URL
}
