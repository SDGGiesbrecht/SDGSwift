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
    open class static mutating func allModifiers() {}
}

public func nonstandardGenerics<T : Equatable>(_ parameter: T) {}

public func nonstandardVoidReturn() -> Void {}
public func withVoid(_ closure: () -> ()) {}

public func tupleReturn() -> (String, Int) {
    return ("", 0)
}

public func arrayReturn() -> [Bool] {
    return []
}
public func nonstandardArrayReturn() -> Array<Bool> {
    return []
}

public func dictionaryReturn() -> [Bool: Bool] {
    return []
}
public func nonstandardDictionaryReturn() -> Dictionary<Bool, Bool> {
    return []
}

public func withType<T>(_ type: T.Type) {}
public func withComposedProtocol(_ composed: TextOutputStream & TextOutputStreamable) {}
