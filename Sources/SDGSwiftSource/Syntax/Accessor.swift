/*
 Accessor.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

internal protocol Accessor : AccessControlled {
    var keyword: TokenSyntax { get }
    var accessors: AccessorBlockSyntax? { get }
}

extension Accessor {

    private var hasReducedSetterAccessLevel: Bool {
        guard let modifiers = self.modifiers else {
            return false
        }
        for modifier in modifiers {
            if let detail = modifier.detail {
                let kind = modifier.name.tokenKind
                if kind == .internalKeyword ∨ kind == .fileprivateKeyword ∨ kind == .privateKeyword,
                    detail.contains(where: { $0.text == "set" }) {
                    return true
                }
            }
        }
        return false
    }

    internal var isSettable: Bool {
        if keyword.tokenKind == .letKeyword {
            // let
            return false
        } else {
            // var
            if hasReducedSetterAccessLevel {
                return false
            }
            if let accessors = self.accessors {
                // Computed.
                if accessors.accessorListOrStmtList is AccessorListSyntax {
                    // Two accessors: get + set
                    return true
                } else {
                    // Just one accessor: get
                    return false
                }
            } else {
                // Stored.
                return true
            }
        }
    }
}
