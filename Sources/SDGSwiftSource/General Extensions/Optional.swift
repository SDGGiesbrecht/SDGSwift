/*
 Optional.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension Optional : Mergeable where Wrapped : Mergeable {

    internal mutating func merge(with other: Wrapped?) {
        switch self {
        case .some(var instance):
            switch other {
            case .some(let otherInstance):
                instance.merge(with: otherInstance)
                self = .some(instance)
            case .none:
                break
            }
        case .none:
            self = other
        }
    }
}

extension Optional where Wrapped == Syntax {

    internal mutating func prependCompilationConditions(_ addition: Syntax?) {
        switch self {
        case .some(let instance):
            switch addition {
            case .some(let additionInstance):
                self = .some(instance.prependingCompilationConditions(additionInstance))
            case .none:
                break
            }
        case .none:
            self = addition
        }
    }
}
