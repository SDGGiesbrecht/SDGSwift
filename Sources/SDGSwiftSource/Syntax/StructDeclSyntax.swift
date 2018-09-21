/*
 StructDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

extension StructDeclSyntax : AccessControlled {

    internal var typeAPI: TypeAPI? {
        if ¬isPublic {
            return nil
        }

        let (genericTypes, genericConstraints) = genericParameterClause?.typesAndConstraints ?? ([], [])

        return TypeAPI(
            documentation: documentation,
            isOpen: isOpen,
            keyword: structKeyword.tokenKind,
            name: TypeReferenceAPI(
                name: identifier.text,
                genericArguments: genericTypes),
            conformances: inheritanceClause?.conformances ?? [],
            constraints: genericConstraints + (genericWhereClause?.constraints ?? []),
            children: apiChildren())
    }
}
