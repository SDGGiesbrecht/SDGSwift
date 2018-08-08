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

    internal init(isMutating: Bool, name: String, arguments: [ArgumentAPI], throws: Bool, returnType: TypeReferenceAPI?) {
        self.isMutating = isMutating
        _name = name.decomposedStringWithCanonicalMapping
        self.arguments = arguments
        self.throws = `throws`
        self.returnType = returnType
    }

    // MARK: - Properties

    private let isMutating: Bool
    private let _name: String
    private let arguments: [ArgumentAPI]
    private let `throws`: Bool
    private let returnType: TypeReferenceAPI?

    // MARK: - APIElement

    public override var name: String {
        return _name + "(" + arguments.map({ $0.functionNameForm }).joined() + ")"
    }

    public override var declaration: String {
        var result = ""
        if isMutating {
            result += "mutating "
        }
        result += "func " + _name + "(" + arguments.map({ $0.functionDeclarationForm }).joined(separator: ", ") + ")"
        if `throws` {
            result += " throws"
        }
        if let returnType = self.returnType?.description, returnType ≠ "Void", returnType ≠ "()" {
            result += " \u{2D}> " + returnType
        }
        return result
    }

    public override var summary: [String] {
        var result = name + " • " + declaration
        if let conditions = compilationConditions {
            result += " • " + conditions
        }
        return [result]
    }
}
