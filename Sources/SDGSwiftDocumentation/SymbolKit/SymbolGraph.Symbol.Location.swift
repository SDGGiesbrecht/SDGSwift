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
  ///   - uri: The URI of the file.
  ///   - position: The position within the file.
  public init(uri: String, position: SymbolGraph.LineList.SourceRange.Position) {
    struct Proxy: Encodable {
      let uri: String
      let position: SymbolGraph.LineList.SourceRange.Position
    }
    self = try! initialize(Self.self, by: Proxy(uri: uri, position: position))
  }
}
