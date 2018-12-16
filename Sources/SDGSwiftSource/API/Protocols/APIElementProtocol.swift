/*
 APIElementProtocol.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

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

    internal func scopeSummary() -> [String] {
        // #warning(Move this.)
        return Array(children.lazy.map({ $0.summary().lazy.map({ $0.prepending(" ") }) }).joined())
    }

    internal func appendCompilationConditions(to description: inout String) {
        // #warning(Move this.)
        if let conditions = compilationConditions {
            description += " • " + conditions.source()
        }
    }

    public func summary() -> [String] {
        var entry = ""
        if isProtocolRequirement {
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
        appendCompilationConditions(to: &entry)
        var result = [entry]
        for overload in overloads {
            if let declaration = overload.declaration {
                var declaration = declaration.source()
                overload.elementProtocol.appendCompilationConditions(to: &declaration)
                result.append(declaration.prepending(" "))
            }
        }
        result += scopeSummary()
        return result
    }

    // MARK: - Children

    private func filtered<T>(_ filter: (APIElement) -> T?) -> AnyBidirectionalCollection<T> {
        return AnyBidirectionalCollection(children.lazy.map(filter).compactMap({ $0 }))
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

    public var subtypes: AnyBidirectionalCollection<TypeAPI> {
        return filtered { (element) -> TypeAPI? in
            switch element {
            case .type(let type):
                return type
            default:
                return nil
            }
        }
    }

    public var typeProperties: AnyBidirectionalCollection<VariableAPI> {
        return filtered { (element) -> VariableAPI? in
            switch element {
            case .variable(let property):
                if property.declaration.typeMemberKeyword ≠ nil {
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
                if method.declaration.typeMemberKeyword ≠ nil {
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

    public var properties: AnyBidirectionalCollection<VariableAPI> {
        return filtered { (element) -> VariableAPI? in
            switch element {
            case .variable(let property):
                if property.declaration.typeMemberKeyword == nil {
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

    public var methods: AnyBidirectionalCollection<FunctionAPI> {
        return filtered { (element) -> FunctionAPI? in
            switch element {
            case .function(let method):
                if method.declaration.typeMemberKeyword == nil {
                    return method
                } else {
                    return nil
                }
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
}
