/*
 UndeclaredAPIElementStorage.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SwiftSyntax

internal struct UndeclaredAPIElementStorage {

  // MARK: - Initialization

  internal init(type: TypeSyntax) {
    self.type = type.normalized()
    self.storage = APIElementStorage(documentation: [])
  }

  // MARK: - Properties

  internal let type: TypeSyntax
  internal var storage: APIElementStorage
}
