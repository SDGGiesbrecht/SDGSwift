/*
 PackageAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGSwiftPackageManager

import SymbolKit

/// The API of a package.
public struct PackageAPI {

  /// Creates a package API.
  ///
  /// - Parameters:
  ///   - libraries: The library names.
  ///   - symbolGraphs: The symbol graphs.
  public init(
    libraries: [String],
    symbolGraphs: [SymbolGraph]
  ) {
    self.init(
      libraries: libraries.map({ LibraryAPI(name: $0) }),
      symbolGraphs: symbolGraphs
    )
  }

  /// Creates a package API.
  ///
  /// - Parameters:
  ///   - libraries: The libraries.
  ///   - symbolGraphs: The symbol graphs.
  public init(
    libraries: [LibraryAPI],
    symbolGraphs: [SymbolGraph]
  ) {
    self.libraries = libraries
    self.symbolGraphs = symbolGraphs
  }

  // MARK: - Properties

  /// The library products vended by the package.
  public var libraries: [LibraryAPI]

  /// The package’s symbol graphs.
  public var symbolGraphs: [SymbolGraph]
}
