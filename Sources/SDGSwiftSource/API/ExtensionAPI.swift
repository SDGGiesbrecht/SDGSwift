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

public struct ExtensionAPI : MutableAPIScope, UndeclaredAPIElement {

    // MARK: - Initialization

    internal init(type: TypeSyntax, constraints: GenericWhereClauseSyntax?, children: [APIElement]) {
        self.type = type.normalized()
        _children = ExtensionAPI.normalize(children: children)
        self.constraints = constraints?.normalized()
    }

    // MARK: - Properties

    internal let type: TypeSyntax

    // MARK: - Combining

    public func isExtension(of type: TypeAPI) -> Bool {
        return self.type.source() == type.genericName.source()
    }
    public func isExtension(of protocol: ProtocolAPI) -> Bool {
        return self.type.source() == `protocol`.name.source()
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
                if var existing = merged {
                    existing.merge(extension: `extension`)
                    merged = existing
                } else {
                    merged = `extension`
                }
            }
            result.append(merged!)
        }

        return result
    }

    // MARK: - APIElementProtocol

    public internal(set) var constraints: GenericWhereClauseSyntax?
    public internal(set) var compilationConditions: Syntax?

    public func identifierList() -> Set<String> {
        return scopeIdentifierList()
    }

    public func summary() -> [String] {
        var result = "(" + genericName.source() + ")"
        if let constraints = self.constraints {
            result += constraints.source() // @exempt(from: tests) Theoretically unreachable; constraints should have been passed on to children.
        }
        appendCompilationConditions(to: &result)
        return [result] + scopeSummary
    }

    // MARK: - MutableAPIScope

    internal var _children: [APIElement] = []
}
