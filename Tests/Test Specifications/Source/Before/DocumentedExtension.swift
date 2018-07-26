/*
 DocumentedExtension.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension Bool {

    /// A read‐only computed property.
    public var readOnlyComputedProperty: Bool {
        return self
    }

    /// A read‐only computed property with an internal setter.
    public internal(set) var readOnlyWithInternalSetter: Bool {
        get {
            return self
        }
        set {
            self = newValue
        }
    }

    /// A read‐write computed property.
    public var readWriteComputedProperty: Bool {
        get {
            return self
        }
        set {
            self = newValue
        }
    }
}

// Nothing surfaced to the API.
extension AnySequence {

    var notPublic: Bool
}
