/*
 ExtensionAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

public final class ExtensionAPI : _UndeclaredAPIElementBase, APIElementProtocol, SortableAPIElement, UndeclaredAPIElementProtocol {

    // MARK: - Initialization

    internal init(type: TypeSyntax, constraints: GenericWhereClauseSyntax?, children: [APIElement]) {
        super.init(type: type)
        self.constraints = constraints
        self.children = children
    }

    // MARK: - Combining

    public func isExtension(of type: TypeAPI) -> Bool {
        return self.type.source() == type.genericName.source()
    }
    public func nested(in type: TypeAPI) -> ExtensionAPI? {
        guard let memberType = self.type as? MemberTypeIdentifierSyntax,
            memberType.rootType().source() == type.genericName.source() else {
            return nil
        }
        return ExtensionAPI(type: memberType.strippingRootType(), constraints: constraints, children: children)
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
                if let existing = merged {
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

    public var summaryName: String {
        return "(" + genericName.source() + ")"
    }
}
