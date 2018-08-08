/*
 TypeAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic

public class TypeAPI : APIScope {

    // MARK: - Initialization

    internal init(keyword: String, name: TypeReferenceAPI, conformances: [ConformanceAPI], constraints: [ConstraintAPI], children: [APIElement]) {
        _name = name
        self.keyword = keyword
        super.init(conformances: conformances, children: children)
        self.constraints = constraints.map({ $0.normalized() })
    }

    // MARK: - Properties

    private let keyword: String
    private let _name: TypeReferenceAPI
    private var _constraints: [ConstraintAPI] = []
    private var constraints: [ConstraintAPI] {
        get {
            return _constraints
        }
        set {
            _constraints = newValue.map({ $0.normalized() }).sorted()
        }
    }

    // MARK: - APIElement

    public override var name: String {
        return _name.description
    }

    public override var declaration: String {
        var result = keyword + " " + name
        if ¬constraints.isEmpty {
            result += " where " + constraints.map({ $0.description }).joined(separator: ", ")
        }
        return result
    }

    public override var summary: [String] {
        var result = name + " • " + declaration
        if let conditions = compilationConditions {
            result += " • " + conditions
        }
        return [result] + scopeSummary
    }
}
