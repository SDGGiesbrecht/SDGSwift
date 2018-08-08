/*
 TypeReference.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

public struct TypeReference {

    // MARK: - Initialization

    internal init(name: String, genericArguments: [TypeReference]) {
        self.name = name.decomposedStringWithCanonicalMapping
        self.genericArguments = genericArguments
    }

    // MARK: - Properties

    private var name: String
    private var genericArguments: [TypeReference]

    // MARK: - Output

    internal var description: String {
        var result = name
        if ¬genericArguments.isEmpty {
            result += "<" + genericArguments.map({ $0.description }).joined(separator: ", ") + ">"
        }
        return result
    }
}
