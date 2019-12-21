/*
 APIElementStorage.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SwiftSyntax

internal typealias APIElementStorage = _APIElementStorage
public struct _APIElementStorage {

  // MARK: - Initialization

  internal init(documentation: [SymbolDocumentation], constraints: GenericWhereClauseSyntax?) {
    self.documentation = documentation
    self.constraints = constraints
  }

  // MARK: - Properties

  internal let documentation: [SymbolDocumentation]

  private var _constraints: GenericWhereClauseSyntax?
  internal var constraints: GenericWhereClauseSyntax? {
    get {
      return _constraints
    }
    set {
      _constraints = newValue?.normalized()
    }
  }
}
