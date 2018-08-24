/*
 SubscriptAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public class SubscriptAPI : APIElement {

    // MARK: - Initialization

    internal init(arguments: [ParameterAPI], returnType: TypeReferenceAPI, isSettable: Bool) {
        self.arguments = arguments
        self.returnType = returnType
        self.isSettable = isSettable
    }

    // MARK: - Properties

    private let arguments: [ParameterAPI]
    private let returnType: TypeReferenceAPI
    private var isSettable: Bool

    // MARK: - APIElement

    public override var name: String {
        return "[" + arguments.map({ $0.subscriptNameForm }).joined() + "]"
    }

    public override var declaration: String {
        var result = "subscript(" + arguments.map({ $0.subscriptDeclarationForm }).joined(separator: ", ") + ")"
        result += " \u{2D}> " + returnType.description
        if let constraints = constraintSyntax() {
            result += constraints.source()
        }
        result += " { get " + (isSettable ? "set " : "") + "}"
        return result
    }

    public override var summary: [String] {
        var result = name + " • " + declaration
        appendCompilationConditions(to: &result)
        return [result]
    }
}
