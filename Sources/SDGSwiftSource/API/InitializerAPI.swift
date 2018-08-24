/*
 InitializerAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public class InitializerAPI : APIElement {

    // MARK: - Initialization

    internal init(isFailable: Bool, arguments: [ParameterAPI], throws: Bool) {
        self.isFailable = isFailable
        self.arguments = arguments
        self.throws = `throws`
    }

    // MARK: - Properties

    private let isFailable: Bool
    private let arguments: [ParameterAPI]
    private let `throws`: Bool

    // MARK: - APIElement

    public override var name: String {
        return "init(" + arguments.map({ $0.functionNameForm }).joined() + ")"
    }

    public override var declaration: String {
        var result = "init" + (isFailable ? "?" : "")
        result += "(" + arguments.map({ $0.functionDeclarationForm(trailingComma: false).source() }).joined(separator: ", ") + ")"
        if `throws` {
            result += " throws"
        }
        appendConstraintDescriptions(to: &result)
        return result
    }

    public override var summary: [String] {
        var result = name + " • " + declaration
        appendCompilationConditions(to: &result)
        return [result]
    }
}
