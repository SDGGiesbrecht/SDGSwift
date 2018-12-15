/*
 APIElement.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic
import SDGMathematics
import SDGLocalization

public enum APIElement : Comparable, Hashable {

    // MARK: - Static Methods

    internal static func merge(elements: [APIElement]) -> [APIElement] {

        var extensions: [ExtensionAPI] = []
        var functions: [FunctionAPI] = []
        var types: [TypeAPI] = []
        var protocols: [ProtocolAPI] = []
        var other: [APIElement] = []
        for element in elements {
            switch element {
            case .extension(let `extension`):
                extensions.append(`extension`)
            case .type(let type) :
                types.append(type)
            case .protocol(let `protocol`):
                protocols.append(`protocol`)
            case .function(let function):
                functions.append(function)
            default:
                other.append(element)
            }
        }

        var unmergedExtensions: [ExtensionAPI] = []
        extensionIteration: for `extension` in extensions {
            var `extension` = `extension`

            for index in types.indices {
                let type = types[index]
                if `extension`.isExtension(of: type) {
                    types[index] = type.merging(extension: `extension`)
                    continue extensionIteration
                }
            }
            for index in protocols.indices {
                let `protocol` = protocols[index]
                if `extension`.isExtension(of: `protocol`) {
                    protocols[index] = `protocol`.merging(extension: `extension`)
                    continue extensionIteration
                }
            }
            `extension`.moveConditionsToChildren()
            unmergedExtensions.append(`extension`)
        }
        other.append(contentsOf: ExtensionAPI.combine(extensions: unmergedExtensions).lazy.map({ APIElement.extension($0) }))

        functions = FunctionAPI.groupIntoOverloads(functions)

        other.append(contentsOf: types.lazy.map({ APIElement.type($0) }))
        other.append(contentsOf: protocols.lazy.map({ APIElement.protocol($0) }))
        other.append(contentsOf: functions.lazy.map({ APIElement.function($0) }))
        return other
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

    // MARK: - Methods

    private var element: MutableAPIElement {
        get {
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
        set {
            switch newValue {
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
            default: // @exempt(from: tests) Should never occur.
                if BuildConfiguration.current == .debug { // @exempt(from: tests)
                    print("Unidentified API class: \(Swift.type(of: newValue))")
                }
            }
        }
    }

    public var declaration: Syntax? {
        return element.possibleDeclaration
    }

    public internal(set) var constraints: GenericWhereClauseSyntax? {
        get {
            return element.constraints
        }
        set {
            element.constraints = newValue
        }
    }

    public internal(set) var compilationConditions: Syntax? {
        get {
            return element.compilationConditions
        }
        set {
            element.compilationConditions = newValue
        }
    }

    public var name: Syntax {
        return element.genericName
    }

    public var children: [APIElement] {
        if let scope = element as? APIScope {
            return scope.children
        } else {
            return []
        }
    }

    public func summary() -> [String] {
        return element.summary()
    }

    public func identifierList() -> Set<String> {
        return element.identifierList()
    }

    internal mutating func prependCompilationCondition(_ addition: Syntax?) {
        element.prependCompilationCondition(addition)
    }
    internal func prependingCompilationCondition(_ addition: Syntax?) -> APIElement {
        return nonmutatingVariant(of: { $0.prependCompilationCondition($1) }, on: self, with: addition)
    }

    // MARK: - Comparable

    private enum Group : OrderedEnumeration {
        case package
        case library
        case module
        case type
        case `protocol`
        case `extension`
        case `case`
        case typeProperty
        case typeMethod
        case initializer
        case variable
        case `subscript`
        case function
        case conformance
    }

    private func comparisonIdentity() -> (Group, String, String) {
        func flatten(_ group: Group, _ properties: (name: String, declaration: String)) -> (Group, String, String) {
            return (group, properties.name, properties.declaration)
        }
        switch self {
        case .package(let package):
            return flatten(.package, package.comparisonIdentity())
        case .library(let library):
            return flatten(.library, library.comparisonIdentity())
        case .module(let module):
            return flatten(.module, module.comparisonIdentity())
        case .type(let type):
            return flatten(.type, type.comparisonIdentity())
        case .protocol(let `protocol`):
            return flatten(.protocol, `protocol`.comparisonIdentity())
        case .extension(let `extension`):
            return flatten(.extension, `extension`.comparisonIdentity())
        case .case(let `case`):
            return flatten(.case, `case`.comparisonIdentity())
        case .initializer(let initializer):
            return flatten(.initializer, initializer.comparisonIdentity())
        case .variable(let variable):
            if variable.declaration.typeMemberKeyword ≠ nil {
                return flatten(.typeProperty, variable.comparisonIdentity())
            } else {
                return flatten(.variable, variable.comparisonIdentity())
            }
        case .subscript(let `subscript`):
            return flatten(.subscript, `subscript`.comparisonIdentity())
        case .function(let function):
            if function.declaration.typeMemberKeyword ≠ nil {
                return flatten(.typeMethod, function.comparisonIdentity())
            } else {
                return flatten(.function, function.comparisonIdentity())
            }
        case .conformance(let conformance):
            return flatten(.conformance, conformance.comparisonIdentity())
        }
    }

    public static func < (precedingValue: APIElement, followingValue: APIElement) -> Bool {
        return precedingValue.comparisonIdentity() < followingValue.comparisonIdentity()
    }

    // MARK: - Equatable

    public static func == (precedingValue: APIElement, followingValue: APIElement) -> Bool {
        return precedingValue.comparisonIdentity() == followingValue.comparisonIdentity()
    }

    // MARK: - Hashable

    public func hash(into hasher: inout Hasher) {
        hasher.combine(declaration?.source() ?? name.source())
    }
}
