/*
 ExtensionDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

extension ExtensionDeclSyntax : Attributed, APISyntax, Constrained {

    // MARK: - APISyntax

    var isPublic: Bool {
        return true
    }

    var isHidden: Bool {
        return false
    }

    func selfParsedAPI() -> [APIElement] {
        var children = apiChildren()
        if let conformances = inheritanceClause?.conformances {
            children.append(contentsOf: conformances.lazy.map({ APIElement.conformance($0) }))
        }
        guard ¬children.isEmpty else {
            return []
        }
        return [.extension(ExtensionAPI(
            type: extendedType,
            constraints: genericWhereClause,
            children: children))]
    }
}
