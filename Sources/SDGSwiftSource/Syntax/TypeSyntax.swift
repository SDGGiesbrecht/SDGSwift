/*
 TypeSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

extension TypeSyntax {

    internal var reference: TypeReferenceAPI {
        switch self {
        case let simple as SimpleTypeIdentifierSyntax :
            let genericArguments = simple.genericArgumentClause?.arguments.map({ $0.argumentType.reference }) ?? []
            return TypeReferenceAPI(name: simple.name.text, genericArguments: genericArguments)
        case let optional as OptionalTypeSyntax :
            let wrapped = optional.wrappedType.reference
            return TypeReferenceAPI(name: wrapped.name, genericArguments: wrapped.genericArguments, isOptional: true)
        default:
            for child in children {
                if let type = child as? TokenSyntax,
                    type.text ≠ ".",
                    type.tokenKind ≠ .inoutKeyword {
                    return TypeReferenceAPI(name: type.text, genericArguments: [])
                }
            }
            for child in children {
                if let type = child as? SimpleTypeIdentifierSyntax {
                    return type.reference
                }
            } // @exempt(from: tests) Unreachable with valid source.
            return TypeReferenceAPI(name: "?", genericArguments: []) // @exempt(from: tests)
        }
    }
}
