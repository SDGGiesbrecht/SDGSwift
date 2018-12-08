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
        switch self {
        case .package(let package):
            return package.declaration
        case .library(let library):
            return library.declaration
        case .module(let module):
            return module.declaration
        case .type(let type):
            return type.declaration
        case .protocol(let `protocol`):
            return `protocol`.declaration
        case .extension(let `extension`):
            return `extension`.declaration
        case .case(let `case`):
            return `case`.declaration
        case .initializer(let initializer):
            return initializer.declaration
        case .variable(let variable):
            return variable.declaration
        case .subscript(let `subscript`):
            return `subscript`.declaration
        case .function(let function):
            return function.declaration
        case .conformance(let conformance):
            return conformance.declaration
        }
    }

    public var compilationConditions: Syntax? {
        return element.compilationConditions
    }

    public var name: Syntax {
        switch self {
        case .package(let package):
            return package.name
        case .library(let library):
            return library.name
        case .module(let module):
            return module.name
        case .type(let type):
            return type.name
        case .protocol(let `protocol`):
            return `protocol`.name
        case .extension(let `extension`):
            return `extension`.name
        case .case(let `case`):
            return `case`.name
        case .initializer(let initializer):
            return initializer.name
        case .variable(let variable):
            return variable.name
        case .subscript(let `subscript`):
            return `subscript`.name
        case .function(let function):
            return function.name
        case .conformance(let conformance):
            return conformance.name
        }
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

    internal func comparisonIdentity() -> (String, String) {
        switch self {
        case .package(let package):
            return package.comparisonIdentity()
        case .library(let library):
            return library.comparisonIdentity()
        case .module(let module):
            return module.comparisonIdentity()
        case .type(let type):
            return type.comparisonIdentity()
        case .protocol(let `protocol`):
            return `protocol`.comparisonIdentity()
        case .extension(let `extension`):
            return `extension`.comparisonIdentity()
        case .case(let `case`):
            return `case`.comparisonIdentity()
        case .initializer(let initializer):
            return initializer.comparisonIdentity()
        case .variable(let variable):
            return variable.comparisonIdentity()
        case .subscript(let `subscript`):
            return `subscript`.comparisonIdentity()
        case .function(let function):
            return function.comparisonIdentity()
        case .conformance(let conformance):
            return conformance.comparisonIdentity()
        }
    }

    public static func < (precedingValue: APIElementKind, followingValue: APIElementKind) -> Bool {
        return precedingValue.comparisonIdentity() < followingValue.comparisonIdentity()
    }

    // MARK: - Equatable

    public static func == (precedingValue: APIElementKind, followingValue: APIElementKind) -> Bool {
        return precedingValue.comparisonIdentity() == followingValue.comparisonIdentity()
    }

    // MARK: - Hashable

    public func hash(into hasher: inout Hasher) {
        hasher.combine(declaration?.source() ?? name.source())
    }
}
