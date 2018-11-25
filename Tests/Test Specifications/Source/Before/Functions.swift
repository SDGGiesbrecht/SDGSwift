/*
 Functions.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public func doSomething(_ unnamedParameter: String) {

    var localVariable = 0
    localVariable += 1

    _ = 1 ..< 2

    performFunction(argument)
    performFunction(with: argument)
}

// Overload
public func doSomething(_ unnamedParameter: Int) {}

public func functionWith(defaultParameterOne: Bool = true, defaultParameterTwo: Bool = false) {}

public func function(withInOutParameter: inout Bool) {}

open class TypeScope : Superclass {
    open override class static mutating func allModifiers() {}
}

public func nonstandardGenerics<T : Equatable>(_ parameter: T) {}
