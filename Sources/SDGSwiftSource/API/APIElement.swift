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

    public var declaration: Syntax? {
        switch self {
        case .package(let package):
            return package.declaration
        case .library(let library):
            return library.declaration
        case .module(let module):
            return module.declaration
        case .type(let type):
            return type.genericDeclaration
        case .protocol(let `protocol`):
            return `protocol`.declaration
        case .extension(let `extension`):
            return `extension`.possibleDeclaration
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
            return conformance.possibleDeclaration
        }
    }

    public var constraints: GenericWhereClauseSyntax? {
        get {
            switch self {
            case .package(let package):
                return package.constraints
            case .library(let library):
                return library.constraints
            case .module(let module):
                return module.constraints
            case .type(let type):
                return type.constraints
            case .protocol(let `protocol`):
                return `protocol`.constraints
            case .extension(let `extension`):
                return `extension`.constraints
            case .case(let `case`):
                return `case`.constraints
            case .initializer(let initializer):
                return initializer.constraints
            case .variable(let variable):
                return variable.constraints
            case .subscript(let `subscript`):
                return `subscript`.constraints
            case .function(let function):
                return function.constraints
            case .conformance(let conformance):
                return conformance.constraints
            }
        }
        set {
            switch self {
            case .package(var package):
                package.constraints = newValue
                self = APIElement.package(package)
            case .library(var library):
                library.constraints = newValue
                self = APIElement.library(library)
            case .module(var module):
                module.constraints = newValue
                self = APIElement.module(module)
            case .type(var type):
                type.constraints = newValue
                self = APIElement.type(type)
            case .protocol(var `protocol`):
                `protocol`.constraints = newValue
                self = APIElement.protocol(`protocol`)
            case .extension(var `extension`):
                `extension`.constraints = newValue
                self = APIElement.extension(`extension`)
            case .case(var `case`):
                `case`.constraints = newValue
                self = APIElement.case(`case`)
            case .initializer(var initializer):
                initializer.constraints = newValue
                self = APIElement.initializer(initializer)
            case .variable(var variable):
                variable.constraints = newValue
                self = APIElement.variable(variable)
            case .subscript(var `subscript`):
                `subscript`.constraints = newValue
                self = APIElement.subscript(`subscript`)
            case .function(var function):
                function.constraints = newValue
                self = APIElement.function(function)
            case .conformance(var conformance):
                conformance.constraints = newValue
                self = APIElement.conformance(conformance)
            }
        }
    }

    public var compilationConditions: Syntax? {
        get {
            switch self {
            case .package(let package):
                return package.compilationConditions
            case .library(let library):
                return library.compilationConditions
            case .module(let module):
                return module.compilationConditions
            case .type(let type):
                return type.compilationConditions
            case .protocol(let `protocol`):
                return `protocol`.compilationConditions
            case .extension(let `extension`):
                return `extension`.compilationConditions
            case .case(let `case`):
                return `case`.compilationConditions
            case .initializer(let initializer):
                return initializer.compilationConditions
            case .variable(let variable):
                return variable.compilationConditions
            case .subscript(let `subscript`):
                return `subscript`.compilationConditions
            case .function(let function):
                return function.compilationConditions
            case .conformance(let conformance):
                return conformance.compilationConditions
            }
        }
        set {
            switch self {
            case .package(var package):
                package.compilationConditions = newValue
                self = APIElement.package(package)
            case .library(var library):
                library.compilationConditions = newValue
                self = APIElement.library(library)
            case .module(var module):
                module.compilationConditions = newValue
                self = APIElement.module(module)
            case .type(var type):
                type.compilationConditions = newValue
                self = APIElement.type(type)
            case .protocol(var `protocol`):
                `protocol`.compilationConditions = newValue
                self = APIElement.protocol(`protocol`)
            case .extension(var `extension`):
                `extension`.compilationConditions = newValue
                self = APIElement.extension(`extension`)
            case .case(var `case`):
                `case`.compilationConditions = newValue
                self = APIElement.case(`case`)
            case .initializer(var initializer):
                initializer.compilationConditions = newValue
                self = APIElement.initializer(initializer)
            case .variable(var variable):
                variable.compilationConditions = newValue
                self = APIElement.variable(variable)
            case .subscript(var `subscript`):
                `subscript`.compilationConditions = newValue
                self = APIElement.subscript(`subscript`)
            case .function(var function):
                function.compilationConditions = newValue
                self = APIElement.function(function)
            case .conformance(var conformance):
                conformance.compilationConditions = newValue
                self = APIElement.conformance(conformance)
            }
        }
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
            return type.genericName
        case .protocol(let `protocol`):
            return `protocol`.name
        case .extension(let `extension`):
            return `extension`.genericName
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
            return conformance.genericName
        }
    }

    public var children: [APIElement] {
        switch self {
        case .package, .library, .case, .initializer, .variable, .subscript, .function, .conformance:
            return []
        case .module(let module):
            return module.children
        case .type(let type):
            return type.children
        case .protocol(let `protocol`):
            return `protocol`.children
        case .extension(let `extension`):
            return `extension`.children
        }
    }

    public func summary() -> [String] {
        switch self {
        case .package(let package):
            return package.summary()
        case .library(let library):
            return library.summary()
        case .module(let module):
            return module.summary()
        case .type(let type):
            return type.summary()
        case .protocol(let `protocol`):
            return `protocol`.summary()
        case .extension(let `extension`):
            return `extension`.summary()
        case .case(let `case`):
            return `case`.summary()
        case .initializer(let initializer):
            return initializer.summary()
        case .variable(let variable):
            return variable.summary()
        case .subscript(let `subscript`):
            return `subscript`.summary()
        case .function(let function):
            return function.summary()
        case .conformance(let conformance):
            return conformance.summary()
        }
    }

    public func identifierList() -> Set<String> {
        switch self {
        case .package(let package):
            return package.identifierList()
        case .library(let library):
            return library.identifierList()
        case .module(let module):
            return module.identifierList()
        case .type(let type):
            return type.identifierList()
        case .protocol(let `protocol`):
            return `protocol`.identifierList()
        case .extension(let `extension`):
            return `extension`.identifierList()
        case .case(let `case`):
            return `case`.identifierList()
        case .initializer(let initializer):
            return initializer.identifierList()
        case .variable(let variable):
            return variable.identifierList()
        case .subscript(let `subscript`):
            return `subscript`.identifierList()
        case .function(let function):
            return function.identifierList()
        case .conformance(let conformance):
            return conformance.identifierList()
        }
    }

    internal mutating func prependCompilationCondition(_ addition: Syntax?) {
        switch self {
        case .package(var package):
            package.prependCompilationCondition(addition)
            self = APIElement.package(package)
        case .library(var library):
            library.prependCompilationCondition(addition)
            self = APIElement.library(library)
        case .module(var module):
            module.prependCompilationCondition(addition)
            self = APIElement.module(module)
        case .type(var type):
            type.prependCompilationCondition(addition)
            self = APIElement.type(type)
        case .protocol(var `protocol`):
            `protocol`.prependCompilationCondition(addition)
            self = APIElement.protocol(`protocol`)
        case .extension(var `extension`):
            `extension`.prependCompilationCondition(addition)
            self = APIElement.extension(`extension`)
        case .case(var `case`):
            `case`.prependCompilationCondition(addition)
            self = APIElement.case(`case`)
        case .initializer(var initializer):
            initializer.prependCompilationCondition(addition)
            self = APIElement.initializer(initializer)
        case .variable(var variable):
            variable.prependCompilationCondition(addition)
            self = APIElement.variable(variable)
        case .subscript(var `subscript`):
            `subscript`.prependCompilationCondition(addition)
            self = APIElement.subscript(`subscript`)
        case .function(var function):
            function.prependCompilationCondition(addition)
            self = APIElement.function(function)
        case .conformance(var conformance):
            conformance.prependCompilationCondition(addition)
            self = APIElement.conformance(conformance)
        }
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
