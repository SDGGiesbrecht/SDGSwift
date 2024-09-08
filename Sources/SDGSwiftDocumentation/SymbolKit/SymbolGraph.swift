/*
 SymbolGraph.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGPersistence

import SymbolKit

extension SymbolGraph: FileConvertible {

  // MARK: - FileConvertible

  public init(
    file: Data,
    origin: URL?
  ) throws {  // @exempt(from: tests) Nothing to load on tvOS.
    self = try JSONDecoder().decode(Self.self, from: file)
  }

  public var file: Data {  // @exempt(from: tests) Upstream encoding conformance broken.
    return try! JSONEncoder().encode(self)
  }
}
