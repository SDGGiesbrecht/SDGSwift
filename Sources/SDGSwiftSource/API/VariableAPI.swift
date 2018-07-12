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

    internal init(name: String, type: String?, isSettable: Bool) {
        _name = name
        self.type = type
        self.isSettable = isSettable
    }

    private var _name: String
    private var type: String?
    private var isSettable: Bool

    // MARK: - Properties

    public override var name: String {
        return _name
    }

    public override var declaration: String {
        return "var " + _name + ": " + (type ?? "Any") + " { get " + (isSettable ? "set " : "") + "}"
    }

    public override var summary: [String] {
        return [name + " • " + declaration]
    }
}
