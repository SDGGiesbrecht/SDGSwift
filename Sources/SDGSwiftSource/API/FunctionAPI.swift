/*
 FunctionAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

public class FunctionAPI : APIElement {

    // MARK: - Initialization

    internal init(name: String, arguments: [ArgumentAPI], throws: Bool, returnType: String?) {
        _name = name.decomposedStringWithCanonicalMapping
        self.arguments = arguments
        self.throws = `throws`
        self.returnType = returnType?.decomposedStringWithCanonicalMapping
    }

    // MARK: - Properties

    private let _name: String
    private let arguments: [ArgumentAPI]
    private let `throws`: Bool
    private let returnType: String?

    // MARK: - APIElement

    public override var name: String {
        return _name + "(" + arguments.map({ $0.functionNameForm }).joined() + ")"
    }

    public override var declaration: String {
        var result = "func " + _name + "(" + arguments.map({ $0.declarationForm }).joined(separator: ", ") + ")"
        if `throws` {
            result += " throws"
        }
        if let returnType = self.returnType, returnType ≠ "Void", returnType ≠ "()" {
            result += " \u{2D}> " + returnType
        }
        return result
    }

    public override var summary: [String] {
        return [name + " • " + declaration]
    }
}
