/*
 ExtensionAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

public class ExtensionAPI : APIScope {

    // MARK: - Initialization

    internal init(type: TypeReferenceAPI, conformances: [ConformanceAPI], children: [APIElement]) {
        self.type = type
        super.init(conformances: conformances, children: children)
    }

    // MARK: - Properties

    internal let type: TypeReferenceAPI

    // MARK: - APIElement

    public override var name: String {
        return "(" + type.description + ")"
    }

    public override var declaration: String? { // @exempt(from: tests) Should never occur.
        return nil
    }

    public override var summary: [String] {
        var result = name
        appendConstraintDescriptions(to: &result)
        appendCompilationConditions(to: &result)
        return [result] + scopeSummary
    }
}
