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
        typeName = name
        self.keyword = keyword
        super.init(conformances: conformances, children: children)
        self.constraints = constraints
    }

    // MARK: - Properties

    private let keyword: String
    internal let typeName: TypeReferenceAPI

    // MARK: - APIElement

    public override var name: String {
        return typeName.description
    }

    public override var declaration: String {
        var result = keyword + " " + name
        if let constraints = constraintSyntax() {
            result += constraints.source()
        }
        return result
    }

    public override var summary: [String] {
        var result = name + " • " + declaration
        appendCompilationConditions(to: &result)
        return [result] + scopeSummary
    }
}
