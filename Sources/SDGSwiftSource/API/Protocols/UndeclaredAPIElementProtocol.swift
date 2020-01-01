/*
 UndeclaredAPIElementProtocol.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SwiftSyntax

internal protocol _UndeclaredAPIElementProtocol: _NonOverloadableAPIElement, SortableAPIElement {
  var undeclaredStorage: UndeclaredAPIElementStorage { get set }
}

extension _UndeclaredAPIElementProtocol {

  public var _storage: _APIElementStorage {
    get {
      undeclaredStorage.storage
    }
    set {
      undeclaredStorage.storage = newValue
    }
  }

  public var type: TypeSyntax {
    return undeclaredStorage.type
  }

  public var possibleDeclaration: Syntax? {
    return nil
  }

  public var genericName: Syntax {
    return type
  }

  // MARK: - APIElementProtocol

  public func _shallowIdentifierList() -> Set<String> {
    return []
  }
}
