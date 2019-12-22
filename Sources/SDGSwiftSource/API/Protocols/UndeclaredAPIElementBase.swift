/*
 UndeclaredAPIElementBase.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SwiftSyntax

public class _UndeclaredAPIElementBase {

  // MARK: - Initialization

  init(type: TypeSyntax) {
    self.type = type.normalized()
    _storage = APIElementStorage(documentation: [])
    undeclaredStorage = UndeclaredAPIElementStorage()
  }

  // MARK: - Properties

  public let type: TypeSyntax

  // MARK: - APIElementProtocol

  public var _storage: _APIElementStorage

  // MARK: - UndeclaredAPIElementProtocol

  internal var undeclaredStorage: UndeclaredAPIElementStorage
}
