/*
 Optional.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension Optional : List where Wrapped : List {

    typealias Element = Wrapped.Element

    init(elementsOrEmpty elements: [Wrapped.Element]) {
        self = Wrapped(elementsOrEmpty: elements)
    }

    func adding(_ addition: Wrapped.Element) -> Wrapped? {
        switch self {
        case .some(let instance):
            return instance.adding(addition)
        case .none:
            return Wrapped(elementsOrNil: [addition])
        }
    }
}

extension Optional : Mergeable where Wrapped : Mergeable {

    internal func merged(with other: Wrapped?) -> Wrapped? {
        switch self {
        case .some(let instance):
            switch other {
            case .some(let otherInstance):
                return instance.merged(with: otherInstance)
            case .none:
                return instance
            }
        case .none:
            return other
        }
    }
}
