/*
 SymbolGraph.LineList.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SymbolKit

extension SymbolGraph.LineList {

  /// Creates a line list.
  ///
  /// - Parameters:
  ///   - lines: The lines.
  public init(lines: [Line]) {
    struct Proxy: Encodable {
      let lines: [Line]
    }
    self = try! initialize(Self.self, by: Proxy(lines: lines))
  }

  internal init(blockSource: String) {
    #warning("Not implemented yet.")
    fatalError()
  }
}
