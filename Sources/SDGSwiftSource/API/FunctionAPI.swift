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

    internal init(typeMethodKeyword: String?, isMutating: Bool, name: String, arguments: [ArgumentAPI], throws: Bool, returnType: TypeReferenceAPI?, isOperator: Bool) {
        self.typeMethodKeyword = isOperator ? nil : typeMethodKeyword
        self.isMutating = isMutating
        _name = name.decomposedStringWithCanonicalMapping
        self.arguments = arguments
        self.throws = `throws`
        self.returnType = returnType
        self.isOperator = isOperator
    }

    // MARK: - Properties

    internal let typeMethodKeyword: String?
    private let isMutating: Bool
    private let _name: String
    private let arguments: [ArgumentAPI]
    private let `throws`: Bool
    private let returnType: TypeReferenceAPI?

    private let isOperator: Bool

    internal var isProtocolRequirement: Bool = false
    internal var hasDefaultImplementation: Bool = false
    private var _overloads: [FunctionAPI] = []
    internal var overloads: [FunctionAPI] {
        get {
            return _overloads
        }
        set {
            var new = newValue.sorted()
            if isProtocolRequirement {
                for index in new.indices {
                    let overload = new[index]
                    if overload.declaration == declaration {
                        hasDefaultImplementation = true
                        new.remove(at: index)
                        break
                    }
                }
            }
            _overloads = new
        }
    }

    // MARK: - Combining

    internal static func groupIntoOverloads(_ functions: [FunctionAPI]) -> [FunctionAPI] {
        var sorted: [String: [FunctionAPI]] = [:]

        for function in functions {
            sorted[(function.typeMethodKeyword ≠ nil ? "static " : "") + function.name, default: []].append(function)
        }

        var result: [FunctionAPI] = []
        for (_, group) in sorted {
            var merged: FunctionAPI?
            for function in group.sorted() {
                if let existing = merged {
                    existing.overloads.append(function)
                } else {
                    merged = function
                }
            }
            result.append(merged!)
        }

        return result
    }

    // MARK: - APIElement

    public override var name: String {
        return _name + "(" + arguments.map({ isOperator ? $0.operatorNameForm : $0.functionNameForm }).joined() + ")"
    }

    public override var declaration: String {
        var result = ""
        if let typeKeyword = typeMethodKeyword {
            result += typeKeyword + " "
        }
        if isMutating {
            result += "mutating "
        }
        result += "func " + _name + "(" + arguments.map({ isOperator ? $0.operatorDeclarationForm : $0.functionDeclarationForm }).joined(separator: ", ") + ")"
        if `throws` {
            result += " throws"
        }
        if let returnType = self.returnType?.description, returnType ≠ "Void", returnType ≠ "()" {
            result += " \u{2D}> " + returnType
        }
        appendConstraintDescriptions(to: &result)
        return result
    }

    public override var summary: [String] {
        var result = ""
        if isProtocolRequirement {
            if hasDefaultImplementation {
                result += "(customizable) "
            } else {
                result += "(required) "
            }
        }
        result += name + " • " + declaration
        appendCompilationConditions(to: &result)
        var resultSummary = [result]
        for overload in overloads {
            var declaration = overload.declaration
            overload.appendCompilationConditions(to: &declaration)
            resultSummary.append(declaration.prepending(" "))
        }
        return resultSummary
    }
}
