/*
 ArgumentAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public struct ArgumentAPI {

    // MARK: - Initialization

    internal init(label: String?, name: String, type: String) {
        self.label = label
        self.name = name
        self.type = type
    }

    private var label: String?
    private var name: String
    private var type: String

    internal var functionNameForm: String {
        return (label ?? "_") + ":"
    }

    internal var declarationForm: String {
        var result = ""
        if label == name {
            result = name
        } else {
            result = (label ?? "_") + " " + name
        }
        result += ": "
        result += type
        return result
    }
}
