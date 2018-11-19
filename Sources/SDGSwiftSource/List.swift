/*
 List.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

internal protocol List : Mergeable {
    associatedtype Element
    init(elementsOrEmpty elements: [Element])
    func adding(_ addition: Element) -> Self
}

extension List {

    internal init?(elementsOrNil elements: [Element]) {
        if elements.isEmpty {
            return nil
        } else {
            self = Self(elementsOrEmpty: elements)
        }
    }
}
