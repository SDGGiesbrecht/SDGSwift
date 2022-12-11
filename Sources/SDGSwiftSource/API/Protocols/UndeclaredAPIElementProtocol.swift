/*
 UndeclaredAPIElementProtocol.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SwiftSyntax

  // Must be public so that `type` is accessible.
  public protocol _UndeclaredAPIElementProtocol: _NonOverloadableAPIElement {
    var _undeclaredStorage: _UndeclaredAPIElementStorage { get set }
  }

  extension _UndeclaredAPIElementProtocol {

    internal var undeclaredStorage: UndeclaredAPIElementStorage {
      get {
        return _undeclaredStorage
      }
      set {
        _undeclaredStorage = newValue
      }
    }

    public var type: TypeSyntax {
      return undeclaredStorage.type
    }

    public var possibleDeclaration: Syntax? {
      return nil
    }

    public var genericName: Syntax {
      return Syntax(type)
    }

    // MARK: - APIElementProtocol

    public func _shallowIdentifierList() -> Set<String> {
      return []
    }
  }
#endif
