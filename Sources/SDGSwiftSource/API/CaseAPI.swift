/*
 CaseAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

public class CaseAPI : APIElement {

    // MARK: - Initialization

    internal init(name: String, associatedValues: [TypeReferenceAPI]) {
        _name = name.decomposedStringWithCanonicalMapping
        self.associatedValues = associatedValues
    }

    // MARK: - Properties

    private let _name: String
    private let associatedValues: [TypeReferenceAPI]

    // MARK: - APIElement

    public override var name: String {
        var result = _name
        if ¬associatedValues.isEmpty {
            result += "("
            result += associatedValues.map({ _ in "_" }).joined(separator: ", ")
            result += ")"
        }
        return result
    }

    public override var declaration: String {
        var result = "case " + _name
        if ¬associatedValues.isEmpty {
            result += "("
            result += associatedValues.map({ $0.description }).joined(separator: ", ")
            result += ")"
        }
        return result
    }

    public override var summary: [String] {
        var result = name + " • " + declaration
        appendCompilationConditions(to: &result)
        return [result]
    }
}
