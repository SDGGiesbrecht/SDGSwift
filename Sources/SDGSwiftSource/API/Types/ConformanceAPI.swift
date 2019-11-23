/*
 ConformanceAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A protocol conformance or superclass inheritance.
public final class ConformanceAPI: _UndeclaredAPIElementBase, SortableAPIElement,
  _UndeclaredAPIElementProtocol
{
  /// A weak reference to the protocol or superclass.
  public internal(set) var reference: ConformanceReference?
}
