/*
 APIElementBase.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

public class _APIElementBase {

    // MARK: - Initialization

    internal init(documentation: DocumentationSyntax?, constraints: GenericWhereClauseSyntax? = nil, compilationConditions: Syntax? = nil, children: [APIElement] = []) {
        self.documentation = documentation
        self.compilationConditions = compilationConditions
        self.constraints = constraints
        self.children = children
    }

    // MARK: - Properties

    // #documentation(SDGSwiftSource.APIElement.documentation)
    /// The element’s documentation.
    public let documentation: DocumentationSyntax?

    private var _constraints: GenericWhereClauseSyntax?
    // #documentation(SDGSwiftSource.APIElement.constraints)
    /// Any generic constraints the element has.
    public internal(set) var constraints: GenericWhereClauseSyntax? {
        get {
            return _constraints
        } set {
            _constraints = newValue?.normalized()
        }
    }

    // #documentation(SDGSwiftSource.APIElement.compilationConditions)
    /// The compilation conditions under which the element is available.
    public internal(set) var compilationConditions: Syntax?

    private var _children: [APIElement] = []
    // #documentation(SDGSwiftSource.APIElement.children)
    /// Any children the element has.
    ///
    /// For example, types may have methods and properties as children.
    public internal(set) var children: [APIElement] {
        get {
            return _children
        } set {
            _children = newValue.sorted()
        }
    }

    // #documentation(SDGSwiftSource.APIElement.isProtocolRequirement)
    /// Whether or not the element is a protocol requirement.
    public internal(set) var isProtocolRequirement: Bool = false
    // #documentation(SDGSwiftSource.APIElement.hasDefaultImplementation)
    /// Whether or not the element has a default implementation.
    public internal(set) var hasDefaultImplementation: Bool = false
    internal var _overloads: [APIElement] = []

    // @documentation(SDGSwiftSource.APIElement.userInformation)
    /// Arbitrary storage for use by client modules which need to associate other values to APIElement instances.
    ///
    /// This property is never used by anything in `SDGSwift` and will always be `nil` unless a client module sets it to something else.
    public var userInformation: Any?

    // MARK: - Merging

    internal func moveConditionsToChildren() {
        for child in children {
            child.elementBase.compilationConditions.prependCompilationConditions(compilationConditions)
            // #workaround(SwiftSyntax 0.40200.0, Prevents invalid index use by SwiftSyntax.)
            if constraints?.source().isEmpty == false {
                if child.constraints?.source().isEmpty == false {
                    child.elementBase.constraints.merge(with: constraints)
                } else {
                    child.elementBase.constraints = constraints
                }
            }
        }
        compilationConditions = nil
        constraints = nil
    }

    internal func merge(extension: ExtensionAPI) {
        `extension`.moveConditionsToChildren()
        children.append(contentsOf: `extension`.children)
        children = FunctionAPI.groupIntoOverloads(children)
    }

    // MARK: - Overloads

    internal static func groupIntoOverloads<E>(_ elements: [E], convert: (E) -> APIElement) -> [E] where E : OverloadableAPIElement {
        var grouped: [String: [E]] = [:]

        for element in elements {
            grouped[element.genericOverloadPattern().source(), default: []].append(element)
        }

        var result: [E] = []
        for (_, group) in grouped {
            var merged: [E] = []
            for element in group.sorted() {
                var shouldAppendNew = true
                partnerSearch: for index in merged.indices {
                    let existing = merged[index]

                    if let existingDocumenation = existing.documentation {
                        if let elementDocumentation = element.documentation {
                            if existingDocumenation.text == elementDocumentation.text {
                                // Same documentation.
                                existing.overloads.append(convert(element))
                                shouldAppendNew = false
                                break partnerSearch
                            } else {
                                // Differing documentation.
                                continue partnerSearch
                            }
                        } else {
                            // Only the existing element has documentation.
                            existing.overloads.append(convert(element))
                            shouldAppendNew = false
                            break partnerSearch
                        }
                    } else if element.documentation ≠ nil {
                        // Only the new element has documentation.
                        element.overloads.append(convert(merged.remove(at: index)))
                        break partnerSearch
                    } else {
                        // Neither has documentation.
                        existing.overloads.append(convert(element))
                        shouldAppendNew = false
                        break partnerSearch
                    }
                }
                if shouldAppendNew {
                    merged.append(element)
                }
            }
            result.append(contentsOf: merged)
        }

        return result
    }

    internal static func groupIntoOverloads(_ elements: [APIElement]) -> [APIElement] {
        var types: [TypeAPI] = []
        var initializers: [InitializerAPI] = []
        var variables: [VariableAPI] = []
        var subscripts: [SubscriptAPI] = []
        var functions: [FunctionAPI] = []

        var result: [APIElement] = []

        for element in elements {
            switch element {
            case .package, .library, .module, .extension, .protocol, .case, .operator, .precedence, .conformance:
                result.append(element)
            case .type(let type):
                types.append(type)
            case .initializer(let initializer):
                initializers.append(initializer)
            case .variable(let variable):
                variables.append(variable)
            case .subscript(let `subscript`):
                subscripts.append(`subscript`)
            case .function(let function):
                functions.append(function)
            }
        }

        types = _APIElementBase.groupIntoOverloads(types) { .type($0) }
        initializers = _APIElementBase.groupIntoOverloads(initializers) { .initializer($0) }
        variables = _APIElementBase.groupIntoOverloads(variables) { .variable($0) }
        subscripts = _APIElementBase.groupIntoOverloads(subscripts) { .subscript($0) }
        functions = _APIElementBase.groupIntoOverloads(functions) { .function($0) }

        result.append(contentsOf: types.lazy.map({ APIElement.type($0) }))
        result.append(contentsOf: initializers.lazy.map({ APIElement.initializer($0) }))
        result.append(contentsOf: variables.lazy.map({ APIElement.variable($0) }))
        result.append(contentsOf: subscripts.lazy.map({ APIElement.subscript($0) }))
        result.append(contentsOf: functions.lazy.map({ APIElement.function($0) }))

        return result
    }
}
