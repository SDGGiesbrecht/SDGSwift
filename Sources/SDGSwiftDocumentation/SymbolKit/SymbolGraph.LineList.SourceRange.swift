/*
 SymbolGraph.LineList.SourceRange.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SymbolKit

extension SymbolGraph.LineList.SourceRange {

  /// Creates a location.
  ///
  /// - Parameters:
  ///   - start: The lower bound.
  ///   - end: The upper bound.
  public init(start: Position, end: Position) {
    struct Proxy: Encodable {
      let start: Position
      let end: Position
    }
    self = try! initialize(Self.self, by: Proxy(start: start, end: end))
  }
}
