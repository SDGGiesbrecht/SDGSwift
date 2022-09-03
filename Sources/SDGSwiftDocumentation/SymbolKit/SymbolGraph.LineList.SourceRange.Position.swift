/*
 SymbolGraph.LineList.SourceRange.Position.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SymbolKit

extension SymbolGraph.LineList.SourceRange.Position {

  /// Creates a location.
  ///
  /// - Parameters:
  ///   - line: The zero‐based line number in the document.
  ///   - position: The zero‐based *byte offset* into the line.
  public init(line: Int, character: Int) {
    struct Proxy: Encodable {
      let line: Int
      let character: Int
    }
    self = try! initialize(Self.self, by: Proxy(line: line, character: character))
  }
}
