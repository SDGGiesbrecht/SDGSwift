/*
 SymbolGraph.Symbol.Location.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SymbolKit

extension SymbolGraph.Symbol.Location {

  /// Creates a location.
  ///
  /// - Parameters:
  ///   - url: The URL of the file.
  ///   - position: The position within the file.
  public init(url: String, position: SymbolGraph.LineList.SourceRange.Position) {
    struct Proxy: Encodable {
      let url: String
      let position: SymbolGraph.LineList.SourceRange.Position
    }
    self = try! initialize(Self.self, by: Proxy(url: url, position: position))
  }
}
