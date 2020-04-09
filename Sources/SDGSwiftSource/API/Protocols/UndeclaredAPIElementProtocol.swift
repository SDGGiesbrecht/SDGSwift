/*
 UndeclaredAPIElementProtocol.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(workspace version 0.32.0, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(WASI) || os(Android))
  import SwiftSyntax

  // Must be public so that `type` is accessible.
  public protocol _UndeclaredAPIElementProtocol: _NonOverloadableAPIElement, SortableAPIElement {
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
      return Syntax(type)
    }

    // MARK: - APIElementProtocol

    public func _shallowIdentifierList() -> Set<String> {
      return []
    }
  }
#endif
