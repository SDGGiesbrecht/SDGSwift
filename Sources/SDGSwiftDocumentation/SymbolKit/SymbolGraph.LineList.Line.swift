/*
 SymbolGraph.LineList.Line.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SymbolKit

extension SymbolGraph.LineList.Line {

  /// Creates a line.
  ///
  /// - Parameters:
  ///   - text: The text.
  ///   - range: The range.
  public init(text: String, range: SymbolGraph.LineList.SourceRange?) {
    struct Proxy: Encodable {
      let text: String
      let range: SymbolGraph.LineList.SourceRange?
    }
    self = try! initialize(Self.self, by: Proxy(text: text, range: range))
  }

  internal init(lineSource: String) {
    #warning("Not implemented yet.")
    fatalError()
  }
}
