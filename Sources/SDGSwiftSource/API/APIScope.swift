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

    internal init(documentation: DocumentationSyntax?, conformances: [ConformanceAPI], children: [APIElement]) { // @exempt(from: tests) False coverage result in Xcode 9.4.1)
        super.init(documentation: documentation)
        self.conformances = conformances
        for element in children {
            switch element { // @exempt(from: tests) False coverage in Xcode 9.4.1.
            case let `case` as CaseAPI :
                cases.append(`case`)
            case let subtype as TypeAPI :
                subtypes.append(subtype)
            case let initializer as InitializerAPI :
                initializers.append(initializer)
            case let property as VariableAPI :
                if property.typePropertyKeyword ≠ nil {
                    typeProperties.append(property)
                } else {
                    properties.append(property)
                }
            case let `subscript` as SubscriptAPI :
                subscripts.append(`subscript`)
            case let method as FunctionAPI :
                if method.typeMethodKeyword ≠ nil {
                    typeMethods.append(method)
                } else {
                    methods.append(method)
                }
            default: // @exempt(from: tests) Should never occur.
                if BuildConfiguration.current == .debug { // @exempt(from: tests)
                    print("Unidentified API element: \(Swift.type(of: element))")
                }
            }
        }
    }

    // MARK: - Properties

    private var _cases: [CaseAPI] = []
    public private(set) var cases: [CaseAPI] {
        get {
            return _cases
        }
        set {
            _cases = newValue.sorted()
        }
    }

    private var _subtypes: [TypeAPI] = []
    public private(set) var subtypes: [TypeAPI] {
        get {
            return _subtypes
        }
        set {
            _subtypes = newValue.sorted()
        }
    }

    private var _typeProperties: [VariableAPI] = []
    public private(set) var typeProperties: [VariableAPI] {
        get {
            return _typeProperties
        }
        set {
            _typeProperties = newValue.sorted()
        }
    }

    private var _typeMethods: [FunctionAPI] = []
    public private(set) var typeMethods: [FunctionAPI] {
        get {
            return _typeMethods
        }
        set {
            _typeMethods = newValue.sorted()
        }
    }

    private var _initializers: [InitializerAPI] = []
    public private(set) var initializers: [InitializerAPI] {
        get {
            return _initializers
        }
        set {
            _initializers = newValue.sorted()
        }
    }

    private var _properties: [VariableAPI] = []
    public private(set) var properties: [VariableAPI] {
        get {
            return _properties
        }
        set {
            _properties = newValue.sorted()
        }
    }

    private var _subscripts: [SubscriptAPI] = []
    public private(set) var subscripts: [SubscriptAPI] {
        get {
            return _subscripts
        }
        set {
            _subscripts = newValue.sorted()
        }
    }

    private var _methods: [FunctionAPI] = []
    public private(set) var methods: [FunctionAPI] {
        get {
            return _methods
        }
        set {
            _methods = newValue.sorted()
        }
    }

    private var _conformances: [ConformanceAPI] = []
    public private(set) var conformances: [ConformanceAPI] {
        get {
            return _conformances
        }
        set {
            _conformances = newValue.sorted()
        }
    }

    // MARK: - Merging

    internal func moveConditionsToChildren() {
        for child in children {
            child.prependCompilationCondition(compilationConditions)
            child.constraints = child.constraints.merged(with: constraints)
        }
        compilationConditions = nil
        constraints = nil
    }

    internal func merge(extension: ExtensionAPI) {
        `extension`.moveConditionsToChildren()
        subtypes.append(contentsOf: `extension`.subtypes)
        typeProperties.append(contentsOf: `extension`.typeProperties)
        typeMethods.append(contentsOf: `extension`.typeMethods)
        initializers.append(contentsOf: `extension`.initializers)
        properties.append(contentsOf: `extension`.properties)
        subscripts.append(contentsOf: `extension`.subscripts)
        methods.append(contentsOf: `extension`.methods)
        conformances.append(contentsOf: `extension`.conformances)

        methods = FunctionAPI.groupIntoOverloads(methods)
    }

    // MARK: - APIElement

    internal var scopeIdentifierList: Set<String> {
        return children.reduce(into: Set<String>()) { $0 ∪= $1.identifierList }
    }

    public override var children: AnyBidirectionalCollection<APIElement> {
        let joined = ([
            cases,
            subtypes,
            typeProperties,
            typeMethods,
            initializers,
            properties,
            subscripts,
            methods,
            conformances
            ] as [[APIElement]]).joined()
        return AnyBidirectionalCollection(joined)
    }

    internal var scopeSummary: [String] {
        return Array(children.map({ $0.summary.map({ $0.prepending(" ") }) }).joined())
    }
}
