/*
 APIElement.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

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
        var types: [TypeAPI] = []
        var protocols: [ProtocolAPI] = []
        var other: [APIElement] = []
        for element in elements {
            switch element {
            case .extension(let `extension`):
                extensions.append(`extension`)
            case .type(let type):
                types.append(type)
            case .protocol(let `protocol`):
                protocols.append(`protocol`)
            default:
                other.append(element)
            }
        }

        var unmergedExtensions: [ExtensionAPI] = []
        extensionIteration: for `extension` in extensions {
            for type in types where `extension`.isExtension(of: type) {
                type.merge(extension: `extension`)
                continue extensionIteration
            }
            for `protocol` in protocols where `extension`.isExtension(of: `protocol`) {
                `protocol`.merge(extension: `extension`)
                continue extensionIteration
            }
            `extension`.moveConditionsToChildren()
            unmergedExtensions.append(`extension`)
        }
        other.append(contentsOf: ExtensionAPI.combine(extensions: unmergedExtensions).lazy.map({ APIElement.extension($0) }))

        other.append(contentsOf: types.lazy.map({ APIElement.type($0) }))
        other.append(contentsOf: protocols.lazy.map({ APIElement.protocol($0) }))

        return _APIElementBase.groupIntoOverloads(other)
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

    internal var elementBase: _APIElementBase {
        switch self {
        case .package(let package):
            return package
        case .library(let library):
            return library
        case .module(let module):
            return module
        case .type(let type):
            return type
        case .extension(let `extension`):
            return `extension`
        case .protocol(let `protocol`):
            return `protocol`
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

    internal var elementProtocol: APIElementProtocol {
        switch self {
        case .package(let package):
            return package
        case .library(let library):
            return library
        case .module(let module):
            return module
        case .type(let type):
            return type
        case .extension(let `extension`):
            return `extension`
        case .protocol(let `protocol`):
            return `protocol`
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

    public var declaration: Syntax? {
        return elementProtocol.possibleDeclaration
    }

    public var constraints: GenericWhereClauseSyntax? {
        return elementProtocol.constraints
    }

    public var documentation: DocumentationSyntax? {
        return elementProtocol.documentation
    }

    public var compilationConditions: Syntax? {
        return elementProtocol.compilationConditions
    }

    public var name: Syntax {
        return elementProtocol.genericName
    }

    public var children: [APIElement] {
        return elementProtocol.children
    }

    public var libraries: AnyBidirectionalCollection<LibraryAPI> {
        return elementProtocol.libraries
    }

    public var modules: AnyBidirectionalCollection<ModuleAPI> {
        return elementProtocol.modules
    }

    public var types: AnyBidirectionalCollection<TypeAPI> {
        return elementProtocol.types
    }

    public var extensions: AnyBidirectionalCollection<ExtensionAPI> {
        return elementProtocol.extensions
    }

    public var protocols: AnyBidirectionalCollection<ProtocolAPI> {
        return elementProtocol.protocols
    }

    public var cases: AnyBidirectionalCollection<CaseAPI> {
        return elementProtocol.cases
    }

    public var typeProperties: AnyBidirectionalCollection<VariableAPI> {
        return elementProtocol.typeProperties
    }

    public var typeMethods: AnyBidirectionalCollection<FunctionAPI> {
        return elementProtocol.typeMethods
    }

    public var initializers: AnyBidirectionalCollection<InitializerAPI> {
        return elementProtocol.initializers
    }

    public var instanceProperties: AnyBidirectionalCollection<VariableAPI> {
        return elementProtocol.instanceProperties
    }

    public var subscripts: AnyBidirectionalCollection<SubscriptAPI> {
        return elementProtocol.subscripts
    }

    public var instanceMethods: AnyBidirectionalCollection<FunctionAPI> {
        return elementProtocol.instanceMethods
    }

    public var conformances: AnyBidirectionalCollection<ConformanceAPI> {
        return elementProtocol.conformances
    }

    public func summary() -> [String] {
        return elementProtocol.summary()
    }

    public func identifierList() -> Set<String> {
        return elementProtocol.identifierList()
    }

    // #documentation(SDGSwiftSource.APIElement.userInformation)
    /// Arbitrary storage for use by client modules which need to associate other values to APIElement instances.
    ///
    /// This property is never used by anything in `SDGSwift` and will always be `nil` unless a client module sets it to something else.
    public var userInformation: Any? {
        get {
            return elementBase.userInformation
        }
        nonmutating set {
            elementBase.userInformation = newValue
        }
    }

    // MARK: - Comparable

    private enum Group : OrderedEnumeration {
        case package
        case library
        case module
        case type
        case `extension`
        case `protocol`
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
        case .extension(let `extension`):
            return flatten(.extension, `extension`.comparisonIdentity())
        case .protocol(let `protocol`):
            return flatten(.protocol, `protocol`.comparisonIdentity())
        case .case(let `case`):
            return flatten(.case, `case`.comparisonIdentity())
        case .initializer(let initializer):
            return flatten(.initializer, initializer.comparisonIdentity())
        case .variable(let variable):
            if variable.declaration.isTypeMember() {
                return flatten(.typeProperty, variable.comparisonIdentity())
            } else {
                return flatten(.variable, variable.comparisonIdentity())
            }
        case .subscript(let `subscript`):
            return flatten(.subscript, `subscript`.comparisonIdentity())
        case .function(let function):
            if function.declaration.isTypeMember() {
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
