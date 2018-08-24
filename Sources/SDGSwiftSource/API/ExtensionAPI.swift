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

    internal init(type: TypeReferenceAPI, conformances: [ConformanceAPI], constraints: [ConstraintAPI], children: [APIElement]) {
        self.type = type
        super.init(conformances: conformances, children: children)
        self.constraints = constraints
    }

    // MARK: - Properties

    internal let type: TypeReferenceAPI

    // MARK: - Combining

    internal static func combine(extensions: [ExtensionAPI]) -> [ExtensionAPI] {
        var sorted: [TypeReferenceAPI: [ExtensionAPI]] = [:]

        for `extension` in extensions {
            sorted[`extension`.type, default: []].append(`extension`)
        }

        var result: [ExtensionAPI] = []
        for (_, group) in sorted {
            var merged: ExtensionAPI?
            for `extension` in group {
                if let existing = merged {
                    existing.merge(extension: `extension`)
                } else {
                    merged = `extension`
                }
            }
            result.append(merged!)
        }

        return result
    }

    // MARK: - APIElement

    public override var name: String {
        return type.declaration.source()
    }

    public override var declaration: Syntax? { // @exempt(from: tests) Should never occur.
        return nil
    }

    public override var summary: [String] {
        var result = "(" + name + ")"
        if let constraints = constraintSyntax() {
            result += constraints.source()
        }
        appendCompilationConditions(to: &result)
        return [result] + scopeSummary
    }
}
