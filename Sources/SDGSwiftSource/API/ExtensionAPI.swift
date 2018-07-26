/*
 ExtensionAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

public class ExtensionAPI : APIElement {

    // MARK: - Initialization

    internal init(type: String, children: [APIElement]) {
        self.type = type.decomposedStringWithCanonicalMapping
        super.init()
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

    private let type: String

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
        return "(" + type + ")"
    }

    public override var declaration: String? {
        return nil
    }

    public override var summary: [String] {
        return [name]
            + properties.map({ $0.summary.map({ $0.prepending(" ") }) }).joined()
            + methods.map({ $0.summary.map({ $0.prepending(" ") }) }).joined()
    }
}
