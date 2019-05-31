/*
 APIElementProtocol.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic
import SDGCollections

/// A type‐erased element of API.
public protocol APIElementProtocol : AnyObject {

    // #documentation(SDGSwiftSource.APIElement.documentation)
    /// The element’s documentation.
    var documentation: [SymbolDocumentation] { get }

    // #documentation(SDGSwiftSource.APIElement.declaration)
    /// The element’s declaration.
    var possibleDeclaration: Syntax? { get }

    // #documentation(SDGSwiftSource.APIElement.constraints)
    /// Any generic constraints the element has.
    var constraints: GenericWhereClauseSyntax? { get }

    // #documentation(SDGSwiftSource.APIElement.compilationConditions)
    /// The compilation conditions under which the element is available.
    var compilationConditions: Syntax? { get }

    // #documentation(SDGSwiftSource.APIElement.name)
    /// The name of the element.
    var genericName: Syntax { get }

    // #documentation(SDGSwiftSource.APIElement.name)
    /// The name of the element.
    var overloads: [APIElement] { get }

    // #documentation(SDGSwiftSource.APIElement.children)
    /// Any children the element has.
    ///
    /// For example, types may have methods and properties as children.
    var children: [APIElement] { get }

    func _shallowIdentifierList() -> Set<String>
    // #documentation(SDGSwiftSource.APIElement.identifierList)
    /// A list of all identifiers made available by the element.
    func identifierList() -> Set<String>

    var _summaryName: String { get }

    // #documentation(SDGSwiftSource.APIElement.isProtocolRequirement)
    /// Whether or not the element is a protocol requirement.
    var isProtocolRequirement: Bool { get }

    // #documentation(SDGSwiftSource.APIElement.hasDefaultImplementation)
    /// Whether or not the element has a default implementation.
    var hasDefaultImplementation: Bool { get }

    func _summarySubentries() -> [String]

    // #documentation(SDGSwiftSource.APIElement.summary)
    /// A summary of the element’s API.
    func summary() -> [String]
}

extension APIElementProtocol {

    // MARK: - Identifiers

    public func identifierList() -> Set<String> {
        return children.reduce(into: _shallowIdentifierList()) { $0 ∪= $1.identifierList() }
    }

    // MARK: - Summary

    public var _summaryName: String {
        return genericName.source()
    }

    internal func appendCompilationConditions(to description: inout String) {
        if let conditions = compilationConditions {
            description += " • " + conditions.source()
        }
    }

    internal func appendConstraints(to description: inout String) {
        if let constraints = constraints {
            description += constraints.source()
        }
    }

    public func _summarySubentries() -> [String] {
        var result: [String] = []
        for overload in overloads {
            if let declaration = overload.declaration {
                var declaration = declaration.source()
                overload.elementProtocol.appendConstraints(to: &declaration)
                overload.elementProtocol.appendCompilationConditions(to: &declaration)
                result.append(declaration)
            }
        }
        result.append(contentsOf: children.lazy.map({ $0.summary() }).joined())
        return result
    }

    public func summary() -> [String] {
        var entry = ""
        if isProtocolRequirement ∧ ¬(self is TypeAPI ∨ self is ConformanceAPI) {
            if hasDefaultImplementation {
                entry += "(customizable) "
            } else {
                entry += "(required) "
            }
        }
        entry += _summaryName
        if let declaration = possibleDeclaration?.source() {
            entry += " • " + declaration
        }
        appendConstraints(to: &entry)
        appendCompilationConditions(to: &entry)
        return [entry] + _summarySubentries().lazy.map { $0.prepending(contentsOf: " ") }
    }

    // MARK: - Children

    private func filtered<T>(_ filter: (APIElement) -> T?) -> AnyBidirectionalCollection<T> {
        return AnyBidirectionalCollection(children.lazy.map(filter).compactMap({ $0 }))
    }

    // #documentation(SDGSwiftSource.APIElement.libraries)
    /// The children which are libraries.
    public var libraries: AnyBidirectionalCollection<LibraryAPI> {
        return filtered { (element) -> LibraryAPI? in
            switch element {
            case .library(let library):
                return library
            default:
                return nil
            }
        }
    }

    // #documentation(SDGSwiftSource.APIElement.modules)
    /// The children which are modules.
    public var modules: AnyBidirectionalCollection<ModuleAPI> {
        return filtered { (element) -> ModuleAPI? in
            switch element {
            case .module(let module):
                return module
            default:
                return nil
            }
        }
    }

    // #documentation(SDGSwiftSource.APIElement.types)
    /// The children which are types.
    public var types: AnyBidirectionalCollection<TypeAPI> {
        return filtered { (element) -> TypeAPI? in
            switch element {
            case .type(let type):
                return type
            default:
                return nil
            }
        }
    }

    // #documentation(SDGSwiftSource.APIElement.extensions)
    /// The children which are extensions.
    public var extensions: AnyBidirectionalCollection<ExtensionAPI> {
        return filtered { (element) -> ExtensionAPI? in
            switch element {
            case .extension(let `extension`):
                return `extension`
            default:
                return nil
            }
        }
    }

    // #documentation(SDGSwiftSource.APIElement.protocols)
    /// The children which are protocols.
    public var protocols: AnyBidirectionalCollection<ProtocolAPI> {
        return filtered { (element) -> ProtocolAPI? in
            switch element {
            case .protocol(let `protocol`):
                return `protocol`
            default:
                return nil
            }
        }
    }

    // #documentation(SDGSwiftSource.APIElement.cases)
    /// The children which are cases.
    public var cases: AnyBidirectionalCollection<CaseAPI> {
        return filtered { (element) -> CaseAPI? in
            switch element {
            case .case(let `case`):
                return `case`
            default:
                return nil
            }
        }
    }

    // #documentation(SDGSwiftSource.APIElement.typeProperties)
    /// The children which are type properties.
    public var typeProperties: AnyBidirectionalCollection<VariableAPI> {
        return filtered { (element) -> VariableAPI? in
            switch element {
            case .variable(let property):
                if property.declaration.isTypeMember() {
                    return property
                } else {
                    return nil
                }
            default:
                return nil
            }
        }
    }

    // #documentation(SDGSwiftSource.APIElement.typeMethods)
    /// The children which are type methods.
    public var typeMethods: AnyBidirectionalCollection<FunctionAPI> {
        return filtered { (element) -> FunctionAPI? in
            switch element {
            case .function(let method):
                if method.declaration.isTypeMember() {
                    return method
                } else {
                    return nil
                }
            default:
                return nil
            }
        }
    }

    // #documentation(SDGSwiftSource.APIElement.initializers)
    /// The children which are initializers.
    public var initializers: AnyBidirectionalCollection<InitializerAPI> {
        return filtered { (element) -> InitializerAPI? in
            switch element {
            case .initializer(let initializer):
                return initializer
            default:
                return nil
            }
        }
    }

    // #documentation(SDGSwiftSource.APIElement.instanceProperties)
    /// The children which are instance properties or global variables.
    public var instanceProperties: AnyBidirectionalCollection<VariableAPI> {
        return filtered { (element) -> VariableAPI? in
            switch element {
            case .variable(let property):
                if ¬property.declaration.isTypeMember() {
                    return property
                } else {
                    return nil
                }
            default:
                return nil
            }
        }
    }

    // #documentation(SDGSwiftSource.APIElement.subscripts)
    /// The children which are subscripts.
    public var subscripts: AnyBidirectionalCollection<SubscriptAPI> {
        return filtered { (element) -> SubscriptAPI? in
            switch element {
            case .subscript(let `subscript`):
                return `subscript`
            default:
                return nil
            }
        }
    }

    // #documentation(SDGSwiftSource.APIElement.instanceMethods)
    /// The children which are instance methods or global functions.
    public var instanceMethods: AnyBidirectionalCollection<FunctionAPI> {
        return filtered { (element) -> FunctionAPI? in
            switch element {
            case .function(let method):
                if ¬method.declaration.isTypeMember() {
                    return method
                } else {
                    return nil
                }
            default:
                return nil
            }
        }
    }

    // #documentation(SDGSwiftSource.APIElement.operators)
    /// The children which are operators.
    public var operators: AnyBidirectionalCollection<OperatorAPI> {
        return filtered { (element) -> OperatorAPI? in
            switch element {
            case .operator(let `operator`):
                return `operator`
            default:
                return nil
            }
        }
    }

    // #documentation(SDGSwiftSource.APIElement.precedenceGroups)
    /// The children which are operator precedence groups.
    public var precedenceGroups: AnyBidirectionalCollection<PrecedenceAPI> {
        return filtered { (element) -> PrecedenceAPI? in
            switch element {
            case .precedence(let precedence):
                return precedence
            default:
                return nil
            }
        }
    }

    // #documentation(SDGSwiftSource.APIElement.conformances)
    /// The children which are conformances or superclasses.
    public var conformances: AnyBidirectionalCollection<ConformanceAPI> {
        return filtered { (element) -> ConformanceAPI? in
            switch element {
            case .conformance(let conformance):
                return conformance
            default:
                return nil
            }
        }
    }

    // MARK: - Conformance Resolution

    internal func inherit(from conformance: ConformanceAPI, protocols: [String: ProtocolAPI], classes: [String: TypeAPI]) {
        let conformanceName = conformance.type.source()
        if let `protocol` = protocols[conformanceName] {
            conformance.reference = .protocol(Weak(`protocol`))
            inherit(from: `protocol`, otherProtocols: protocols, otherClasses: classes)
            return
        }
        if let superclass = classes[conformanceName] {
            conformance.reference = .superclass(Weak(superclass))
            inherit(from: superclass, otherProtocols: protocols, otherClasses: classes)
            return
        }
    }

    private func inherit(from parentElement: APIElementProtocol, otherProtocols:  [String: ProtocolAPI], otherClasses: [String: TypeAPI]) {
        for conformance in parentElement.conformances
            where ¬conformances.contains(where: { $0.genericName.source() == conformance.genericName.source() }) {
                let conformanceCopy = ConformanceAPI(type: conformance.type)
                (self as? _APIElementBase)?.children.append(.conformance(conformanceCopy))
                if let referee = conformance.reference?.elementProtocol {
                    conformanceCopy.reference = conformance.reference
                    inherit(from: referee, otherProtocols: otherProtocols, otherClasses: otherClasses)
                } else {
                    inherit(from: conformanceCopy, protocols: otherProtocols, classes: otherClasses)
                }
        }
        let parents = conformances.compactMap({ $0.reference?.elementProtocol })

        (self as? _APIElementBase)?.children = children.filter { child in
            switch child {
            case .package, .library, .module, .protocol, .extension, .case, .operator, .precedence, .conformance:
                return true
            case .type(let subtype):
                return ¬overload(for: subtype, existsInParents: parents)
            case .initializer(let initializer):
                return ¬overload(for: initializer, existsInParents: parents)
            case .variable(let variable):
                return ¬overload(for: variable, existsInParents: parents)
            case .subscript(let `subscript`):
                return ¬overload(for: `subscript`, existsInParents: parents)
            case .function(let function):
                return ¬overload(for: function, existsInParents: parents)
            }
        }
    }

    private func overload<E>(for element: E, existsInParents parents: [APIElementProtocol]) -> Bool where E : _OverloadableAPIElement {
        return parents.contains(where: { $0.hasChildOverload(for: element) })
    }

    private func hasChildOverload<E>(for element: E) -> Bool where E : _OverloadableAPIElement {
        return children.contains(where: { child in
            if let sameType = child.elementProtocol as? E {
                return sameType.genericOverloadPattern().source() == element.genericOverloadPattern().source()
            } else {
                return false
            }
        })
    }
}
