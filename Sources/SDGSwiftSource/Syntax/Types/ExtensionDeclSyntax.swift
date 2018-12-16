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

extension ExtensionDeclSyntax : AccessControlled, Attributed {

    internal var extensionAPI: ExtensionAPI? {
        var children = apiChildren()
        if let conformances = inheritanceClause?.conformances {
            children.append(contentsOf: conformances.lazy.map({ APIElement.conformance($0) }))
        }
        guard ¬children.isEmpty else {
            return nil
        }
        return ExtensionAPI(
            type: extendedType,
            constraints: genericWhereClause,
            children: children)
    }
}
