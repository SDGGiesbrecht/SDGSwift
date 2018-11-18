/*
 ExtensionDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

extension ExtensionDeclSyntax {

    internal var extensionAPI: ExtensionAPI? {
        let conformances = inheritanceClause?.conformances ?? []
        let children = apiChildren()
        guard ¬children.isEmpty ∨ ¬conformances.isEmpty else {
            return nil
        }
        return ExtensionAPI(
            type: extendedType.reference,
            conformances: inheritanceClause?.conformances ?? [],
            constraints: genericWhereClause,
            children: children)
    }
}
