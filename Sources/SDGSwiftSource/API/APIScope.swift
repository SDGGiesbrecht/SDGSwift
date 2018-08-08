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

public class APIScope : APIElement {

    // MARK: - Initialization

    internal init(conformances: [ConformanceAPI], children: [APIElement]) { // @exempt(from: tests) False coverage result in Xcode 9.4.1)
        super.init()
        self.conformances = conformances
        for element in children {
            switch element { // @exempt(from: tests) False coverage in Xcode 9.4.1.
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
                methods.append(method)
            default: // @exempt(from: tests) Should never occur.
                if BuildConfiguration.current == .debug {
                    print("Unidentified API element: \(Swift.type(of: element))")
                }
            }
        }
    }

    // MARK: - Properties

    private var _subtypes: [TypeAPI] = []
    private var subtypes: [TypeAPI] {
        get {
            return _subtypes
        }
        set {
            _subtypes = newValue.sorted()
        }
    }

    private var _typeProperties: [VariableAPI] = []
    private var typeProperties: [VariableAPI] {
        get {
            return _typeProperties
        }
        set {
            _typeProperties = newValue.sorted()
        }
    }

    private var _initializers: [InitializerAPI] = []
    private var initializers: [InitializerAPI] {
        get {
            return _initializers
        }
        set {
            _initializers = newValue.sorted()
        }
    }

    private var _properties: [VariableAPI] = []
    private var properties: [VariableAPI] {
        get {
            return _properties
        }
        set {
            _properties = newValue.sorted()
        }
    }

    private var _subscripts: [SubscriptAPI] = []
    private var subscripts: [SubscriptAPI] {
        get {
            return _subscripts
        }
        set {
            _subscripts = newValue.sorted()
        }
    }

    private var _methods: [FunctionAPI] = []
    private var methods: [FunctionAPI] {
        get {
            return _methods
        }
        set {
            _methods = newValue.sorted()
        }
    }

    private var _conformances: [ConformanceAPI] = []
    private var conformances: [ConformanceAPI] {
        get {
            return _conformances
        }
        set {
            _conformances = newValue.sorted()
        }
    }

    // MARK: - Merging

    internal func merge(extension: ExtensionAPI) {
        subtypes.append(contentsOf: `extension`.subtypes)
        typeProperties.append(contentsOf: `extension`.typeProperties)
        initializers.append(contentsOf: `extension`.initializers)
        properties.append(contentsOf: `extension`.properties)
        subscripts.append(contentsOf: `extension`.subscripts)
        methods.append(contentsOf: `extension`.methods)
        conformances.append(contentsOf: `extension`.conformances)
    }

    // MARK: - APIElement

    internal var scopeSummary: [String] {
        var result: [String] = []
        result += subtypes.map({ $0.summary.map({ $0.prepending(" ") }) }).joined()
        result += typeProperties.map({ $0.summary.map({ $0.prepending(" ") }) }).joined()
        result += initializers.map({ $0.summary.map({ $0.prepending(" ") }) }).joined()
        result += properties.map({ $0.summary.map({ $0.prepending(" ") }) }).joined()
        result += subscripts.map({ $0.summary.map({ $0.prepending(" ") }) }).joined()
        result += methods.map({ $0.summary.map({ $0.prepending(" ") }) }).joined()
        result += conformances.map({ $0.summary.map({ $0.prepending(" ") }) }).joined()
        return result
    }
}
