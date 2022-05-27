/*
 PackageAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGSwift
import SDGSwiftSource

import SymbolKit
import SwiftSyntax

extension PackageAPI {

  /// Creates a package API instance from symbol graphs.
  ///
  /// - Parameters:
  ///     - symbolGraphs: The symbol graphs.
  public convenience init(
    name: String,
    symbolGraphs: [SymbolGraph]
  ) {
    let declaration = FunctionCallExprSyntax._normalizedPackageDeclaration(
      name: name
    )
    self.init(_documentation: [], declaration: declaration)
  }
}
