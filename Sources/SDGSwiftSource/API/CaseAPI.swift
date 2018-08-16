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

    internal init(name: String, associatedValues: [ArgumentAPI]) {
        _name = name.decomposedStringWithCanonicalMapping
        self.associatedValues = associatedValues
    }

    // MARK: - Properties

    private let _name: String
    private let associatedValues: [ArgumentAPI]

    // MARK: - APIElement

    public override var name: String {
        return _name
    }

    public override var declaration: String {
        var result = "case " + name
        if ¬associatedValues.isEmpty {
            result += "("
            for value in associatedValues {
                result += value.functionDeclarationForm
            }
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
