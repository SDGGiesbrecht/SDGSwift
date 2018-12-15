/*
 APIScope.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic
import SDGCollections

public class APIScope : APIElement {

    // MARK: - Initialization

    internal init(conformances: [ConformanceAPI], children: [APIElementKind]) {
        super.init()
        self.children = children.appending(contentsOf: conformances.lazy.map({ APIElementKind($0) }))
    }

    // MARK: - Properties

    public internal(set) var constraints: GenericWhereClauseSyntax?
    public internal(set) var compilationConditions: Syntax?

    private func filtered<T>(_ filter: (APIElementKind) -> T?) -> AnyBidirectionalCollection<T> {
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

    // MARK: - Merging

    internal func moveConditionsToChildren() {
        var result: [APIElementKind] = []
        for child in children {
            var mutable = child
            mutable.prependCompilationCondition(APIElementKind(self).compilationConditions)
            mutable.constraints = child.constraints.merged(with: constraints)
            result.append(mutable)
        }
        compilationConditions = nil
        constraints = nil
        children = result
    }

    internal func merge(extension: ExtensionAPI) {
        `extension`.moveConditionsToChildren()
        children.append(contentsOf: `extension`.children)
        children = FunctionAPI.groupIntoOverloads(children)
    }

    // MARK: - APIElement

    internal func scopeIdentifierList() -> Set<String> {
        return children.reduce(into: Set<String>()) { $0 ∪= $1.identifierList() }
    }

    private var _children: [APIElementKind] = []
    public var children: [APIElementKind] {
        get {
            return _children
        }
        set {
            _children = newValue.sorted()
        }
    }

    internal var scopeSummary: [String] {
        return Array(children.map({ $0.summary().map({ $0.prepending(" ") }) }).joined())
    }
}
