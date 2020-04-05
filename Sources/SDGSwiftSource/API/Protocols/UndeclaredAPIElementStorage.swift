/*
 UndeclaredAPIElementStorage.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(workspace version 0.32.0, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(Android))
  import SwiftSyntax

  internal typealias UndeclaredAPIElementStorage = _UndeclaredAPIElementStorage
  public struct _UndeclaredAPIElementStorage {

    // MARK: - Initialization

    internal init<Syntax>(type: Syntax) where Syntax: TypeSyntaxProtocol {
      self.type = TypeSyntax(type).normalized()
      self.storage = APIElementStorage(documentation: [])
    }

    // MARK: - Properties

    internal let type: TypeSyntax
    internal var storage: APIElementStorage
  }
#endif
