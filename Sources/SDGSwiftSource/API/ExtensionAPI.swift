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
        self.type = type
        super.init()
        for element in children {
            if let property = element as? VariableAPI {
                properties.append(property)
            } else {
                if BuildConfiguration.current == .debug {
                    print("Unidentified API element: \(Swift.type(of: element))")
                }
            }
        }
    }

    private var type: String

    private var _properties: [VariableAPI] = []
    private var properties: [VariableAPI] {
        get {
            return _properties
        }
        set {
            _properties = newValue.sorted()
        }
    }

    // MARK: - Properties

    public override var name: String {
        return "(" + type + ")"
    }

    public override var summary: [String] {
        return [name]
            + properties.map({ $0.summary.map({ $0.prepending(" ") }) }).joined()
    }
}
