/*
 VariableAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public class VariableAPI : APIElement {

    // MARK: - Initialization

    internal init(name: String, type: TypeReference?, isSettable: Bool) {
        _name = name.decomposedStringWithCanonicalMapping
        self.type = type
        self.isSettable = isSettable
    }

    // MARK: - Properties

    private var _name: String
    private var type: TypeReference?
    private var isSettable: Bool

    // MARK: - APIElement

    public override var name: String {
        return _name
    }

    public override var declaration: String {
        var result = "var " + _name
        if let type = self.type {
            result += ": " + type.description
        }
        result += " { get "
        if isSettable {
            result += "set "
        }
        result += "}"
        return result
    }

    public override var summary: [String] {
        return [name + " • " + declaration]
    }
}
