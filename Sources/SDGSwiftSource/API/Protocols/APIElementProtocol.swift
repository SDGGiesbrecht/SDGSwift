/*
 APIElementProtocol.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGCollections

public protocol APIElementProtocol : class {
    var documentation: DocumentationSyntax? { get }
    var possibleDeclaration: Syntax? { get }
    var constraints: GenericWhereClauseSyntax? { get }
    var compilationConditions: Syntax? { get }
    var genericName: Syntax { get }
    var overloads: [APIElement] { get }
    var children: [APIElement] { get }
    func shallowIdentifierList() -> Set<String>
    func identifierList() -> Set<String>
    var summaryName: String { get }
    var isProtocolRequirement: Bool { get }
    var hasDefaultImplementation: Bool { get }
    func summarySubentries() -> [String]
    func summary() -> [String]
}

extension APIElementProtocol {

    // MARK: - Identifiers

    public func identifierList() -> Set<String> {
        return children.reduce(into: shallowIdentifierList()) { $0 ∪= $1.identifierList() }
    }

    // MARK: - Summary

    public var summaryName: String {
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

    public func summarySubentries() -> [String] {
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
        entry += summaryName
        if let declaration = possibleDeclaration?.source() {
            entry += " • " + declaration
        }
        appendConstraints(to: &entry)
        appendCompilationConditions(to: &entry)
        return [entry] + summarySubentries().lazy.map { $0.prepending(contentsOf: " ") }
    }

    // MARK: - Children

    private func filtered<T>(_ filter: (APIElement) -> T?) -> AnyBidirectionalCollection<T> {
        return AnyBidirectionalCollection(children.lazy.map(filter).compactMap({ $0 }))
    }

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

    internal func inherit(from parentElement: APIElementProtocol, otherProtocols: FlattenCollection<[[ProtocolAPI]]>, otherClasses: FlattenCollection<[[TypeAPI]]>) {
        for conformance in parentElement.conformances
            where ¬conformances.contains(where: { $0.genericName.source() == conformance.genericName.source() }) {
                (self as? _APIElementBase)?.children.append(.conformance(ConformanceAPI(type: conformance.type)))
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

    private func overload<E>(for element: E, existsInParents parents: [APIElementProtocol]) -> Bool where E : OverloadableAPIElement {
        return parents.contains(where: { $0.hasChildOverload(for: element) })
    }

    private func hasChildOverload<E>(for element: E) -> Bool where E : OverloadableAPIElement {
        return children.contains(where: { child in
            if let sameType = child.elementProtocol as? E {
                return sameType.genericOverloadPattern().source() == element.genericOverloadPattern().source()
            } else {
                return false
            }
        })
    }
}
