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

    internal init(label: String?, name: String, type: TypeReferenceAPI) {
        self.label = label?.decomposedStringWithCanonicalMapping
        self.name = name.decomposedStringWithCanonicalMapping
        self.type = type
    }

    internal var label: String?
    private var name: String
    private var type: TypeReferenceAPI

    internal var functionNameForm: String {
        return (label ?? "_") + ":"
    }

    internal var subscriptNameForm: String {
        return functionNameForm
    }

    internal var functionDeclarationForm: String {
        var result = ""
        if label == name {
            result = name
        } else {
            result = (label ?? "_") + " " + name
        }
        result += ": "
        result += type.description
        return result
    }

    internal var subscriptDeclarationForm: String {
        var result = ""
        if let theLabel = label {
            result += theLabel + " "
        }
        result += name
        result += ": "
        result += type.description
        return result
    }
}
