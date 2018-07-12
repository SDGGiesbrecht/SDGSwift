/*
 ExtensionAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public class ExtensionAPI : APIElement {

    // MARK: - Initialization

    internal init(type: String) {
        self.type = type
    }

    private var type: String

    // MARK: - Properties

    public override var name: String {
        return "(" + type + ")"
    }

    public override var summary: [String] {
        return [name]
    }
}
