/*
 ProtocolDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

extension ProtocolDeclSyntax : AccessControlled {

    internal var protocolAPI: ProtocolAPI? {
        if ¬isPublic {
            return nil
        }
        let name = identifier.text
        if name.hasPrefix("_") {
            return nil
        }
        return ProtocolAPI(
            documentation: documentation,
            name: name,
            conformances: inheritanceClause?.conformances ?? [],
            constraints: genericWhereClause?.constraints ?? [],
            children: apiChildren())
    }
}
