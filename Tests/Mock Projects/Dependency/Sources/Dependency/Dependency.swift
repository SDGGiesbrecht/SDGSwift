/*
 Dependency.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public protocol SubDependencyProtocol {}
extension SubDependencyProtocol {
  public func inherited() {}
}

public protocol DependencyProtocol: SubDependencyProtocol {
  func requirement()
}
extension DependencyProtocol {
  public func provision() {}
}
