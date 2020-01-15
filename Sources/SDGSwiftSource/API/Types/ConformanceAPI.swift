/*
 ConformanceAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SwiftSyntax

/// A protocol conformance or superclass inheritance.
public final class ConformanceAPI: SortableAPIElement,
  _UndeclaredAPIElementProtocol
{

  // MARK: - Initialization

  internal init(type: TypeSyntax) {
    _undeclaredStorage = UndeclaredAPIElementStorage(type: type)
  }

  // MARK: - Properties

  /// A weak reference to the protocol or superclass.
  public internal(set) var reference: ConformanceReference?

  // MARK: - UndeclaredAPIElementProtocol

  public var _undeclaredStorage: _UndeclaredAPIElementStorage
}
