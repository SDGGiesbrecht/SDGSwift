/*
 APIElementKind.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLocalization

public enum APIElementKind : Comparable, Hashable {

    // MARK: - Initialization

    internal init(element: APIElement) {
        switch element {
        case let package as PackageAPI :
            self = .package(package)
        case let library as LibraryAPI :
            self = .library(library)
        case let module as ModuleAPI :
            self = .module(module)
        case let type as TypeAPI :
            self = .type(type)
        case let `protocol` as ProtocolAPI :
            self = .protocol(`protocol`)
        case let `extension` as ExtensionAPI :
            self = .extension(`extension`)
        case let `case` as CaseAPI :
            self = .case(`case`)
        case let initializer as InitializerAPI :
            self = .initializer(initializer)
        case let variable as VariableAPI :
            self = .variable(variable)
        case let `subscript` as SubscriptAPI :
            self = .subscript(`subscript`)
        case let function as FunctionAPI :
            self = .function(function)
        case let conformance as ConformanceAPI :
            self = .conformance(conformance)
        default:
            unreachable()
        }
    }

    // MARK: - Cases

    case package(PackageAPI)
    case library(LibraryAPI)
    case module(ModuleAPI)
    case type(TypeAPI)
    case `protocol`(ProtocolAPI)
    case `extension`(ExtensionAPI)
    case `case`(CaseAPI)
    case initializer(InitializerAPI)
    case variable(VariableAPI)
    case `subscript`(SubscriptAPI)
    case function(FunctionAPI)
    case conformance(ConformanceAPI)

    // MARK: - Properties

    private var element: APIElement {
        switch self {
        case .package(let package):
            return package
        case .library(let library):
            return library
        case .module(let module):
            return module
        case .type(let type):
            return type
        case .protocol(let `protocol`):
            return `protocol`
        case .extension(let `extension`):
            return `extension`
        case .case(let `case`):
            return `case`
        case .initializer(let initializer):
            return initializer
        case .variable(let variable):
            return variable
        case .subscript(let `subscript`):
            return `subscript`
        case .function(let function):
            return function
        case .conformance(let conformance):
            return conformance
        }
    }

    // MARK: - Methods

    public var declaration: Syntax? {
        return element.declaration
    }

    public var compilationConditions: Syntax? {
        return element.compilationConditions
    }

    public var children: AnyBidirectionalCollection<APIElementKind> {
        return AnyBidirectionalCollection(element.children.map({ APIElementKind(element: $0) }))
    }

    public func identifierList() -> Set<String> {
        return element.identifierList
    }

    public func summary() -> [String] {
        return element.summary
    }

    internal func prependCompilationCondition(_ addition: Syntax?) {
        element.prependCompilationCondition(addition)
    }

    // MARK: - Comparable

    public static func < (precedingValue: APIElementKind, followingValue: APIElementKind) -> Bool {
        return precedingValue.element < followingValue.element
    }
}
