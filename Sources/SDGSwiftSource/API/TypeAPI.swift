/*
 TypeAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic

public class TypeAPI : APIElement {

    // MARK: - Initialization

    internal init(keyword: String, name: String, conformances: [ConformanceAPI], children: [APIElement]) {
        _name = name.decomposedStringWithCanonicalMapping
        self.keyword = keyword
        super.init()
        self.conformances = conformances
        for element in children {
            switch element { // @exempt(from: tests) False coverage in Xcode 9.4.1.
            case let property as VariableAPI :
                properties.append(property)
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

    private let keyword: String
    private let _name: String

    private var _conformances: [ConformanceAPI] = []
    private var conformances: [ConformanceAPI] {
        get {
            return _conformances
        }
        set {
            _conformances = newValue.sorted()
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
    private var _methods: [FunctionAPI] = []
    private var methods: [FunctionAPI] {
        get {
            return _methods
        }
        set {
            _methods = newValue.sorted()
        }
    }

    // MARK: - APIElement

    public override var name: String {
        return _name
    }

    public override var declaration: String? {
        return keyword + " " + name
    }

    public override var summary: [String] {
        return [name]
            + properties.map({ $0.summary.map({ $0.prepending(" ") }) }).joined()
            + methods.map({ $0.summary.map({ $0.prepending(" ") }) }).joined()
            + conformances.map({ $0.summary.map({ $0.prepending(" ") }) }).joined()
    }
}
