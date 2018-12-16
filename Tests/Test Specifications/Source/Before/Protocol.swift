/*
 Protocol.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public protocol Protocol {
    associatedtype AssociatedType
    func requiredFunction()
    func possiblyRequiredFunction()
    func overrideableFunction()
    func _hiddenFunction()
    var getOnlyProperty: Bool { get }
    var getSetProperty: Bool { get set }
}

extension Protocol {
    public func overrideableFunction() {}
    public func providedFunction() {}
}

extension Protocol where Self : OtherProtocol {
    public func possiblyRequiredFunction()
    public func functionWithNestedGenerics<T>(_ parameter: T) where T : Equatable
}

protocol InternalProtocol {}

extension Protocol where Self.AssociatedType == Int {
    public func conditionallyProvidedFunction() {}
}

public protocol ProtocolWithInheritanceAndConstraints : InheritedOne, InheritedTwo
where AssociatedType : OtherProtocol {

}
