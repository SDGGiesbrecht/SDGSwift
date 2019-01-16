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
            for type in types where type.mergeIfExtended(by: `extension`) {
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

        let result = _APIElementBase.groupIntoOverloads(other)
        resolveConformances(elements: result)
        return result
    }

    internal static func resolveConformances(elements: [APIElement]) {

        var cache: (FlattenCollection<[[ProtocolAPI]]>, FlattenCollection<[[TypeAPI]]>)?

        for element in elements {
            for nestedElement in element.nestedList(of: APIElementProtocol.self) {
                conformanceIteration: for conformance in nestedElement.conformances where conformance.reference == nil {

                    let conformanceName = conformance.type.source()

                    let (protocols, superclasses) = cached(in: &cache) {
                        return (
                            elements.map({ $0.nestedList(of: ProtocolAPI.self) }).joined(),
                            elements.map({ $0.nestedList(of: TypeAPI.self) }).joined()
                        )
                    }

                    for `protocol` in protocols where `protocol`.name.source() == conformanceName {
                        conformance.reference = .protocol(Weak(`protocol`))
                        nestedElement.inherit(from: `protocol`)
                        continue conformanceIteration
                    }
                    for superclass in superclasses where superclass.genericName.source() == conformanceName {
                        conformance.reference = .superclass(Weak(superclass))
                        nestedElement.inherit(from: superclass)
                        continue conformanceIteration
                    }
                }
            }
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
    case `operator`(OperatorAPI)
    case precedence(PrecedenceAPI)
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
        case .operator(let `operator`):
            return `operator`
        case .precedence(let precedence):
            return precedence
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
        case .operator(let `operator`):
            return `operator`
        case .precedence(let precedence):
            return precedence
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

    public var operators: AnyBidirectionalCollection<OperatorAPI> {
        return elementProtocol.operators
    }

    public var precedenceGroups: AnyBidirectionalCollection<PrecedenceAPI> {
        return elementProtocol.precedenceGroups
    }

    public var conformances: AnyBidirectionalCollection<ConformanceAPI> {
        return elementProtocol.conformances
    }

    private func nestedList<T>(of type: T.Type) -> [T] {
        var result: [T] = []
        if let element = elementProtocol as? T {
            result.append(element)
        }
        for child in children {
            result.append(contentsOf: child.nestedList(of: T.self))
        }
        return result
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
        case `operator`
        case precedence
        case conformance
    }

    private func comparisonIdentity() -> (Group, String, String, String) {
        func flatten(_ group: Group, _ properties: (name: String, declaration: String, constraints: String)) -> (Group, String, String, String) {
            return (group, properties.name, properties.declaration, properties.constraints)
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
        case .operator(let `operator`):
            return flatten(.operator, `operator`.comparisonIdentity())
        case .precedence(let precedence):
            return flatten(.precedence, precedence.comparisonIdentity())
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
