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

    internal init(type: TypeSyntax, conformances: [ConformanceAPI], constraints: GenericWhereClauseSyntax?, children: [APIElement]) {
        self.type = type.normalized()
        super.init(documentation: nil, conformances: conformances, children: children)
        self.constraints = constraints?.normalized()
    }

    // MARK: - Properties

    internal let type: TypeSyntax

    // MARK: - Combining

    public func isExtension(of type: TypeAPI) -> Bool {
        return self.type.source() == type.name
    }
    public func isExtension(of protocol: ProtocolAPI) -> Bool {
        return self.type.source() == `protocol`.name
    }
    public func extendsSameType(as other: ExtensionAPI) -> Bool {
        return type.source() == other.type.source()
    }

    internal static func combine(extensions: [ExtensionAPI]) -> [ExtensionAPI] {
        var sorted: [String: [ExtensionAPI]] = [:]

        for `extension` in extensions {
            sorted[`extension`.type.source(), default: []].append(`extension`)
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
        return type.source()
    }

    public override var declaration: Syntax? { // @exempt(from: tests) Should never occur.
        return nil
    }

    public override var identifierList: Set<String> {
        return scopeIdentifierList
    }

    public override var summary: [String] {
        var result = "(" + name + ")"
        if let constraints = self.constraints {
            result += constraints.source() // @exempt(from: tests) Theoretically unreachable; constraints should have been passed on to children.
        }
        appendCompilationConditions(to: &result)
        return [result] + scopeSummary
    }
}
