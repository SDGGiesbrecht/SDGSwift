/*
 TypeSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
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
            return TypeReferenceAPI(name: "?", genericArguments: []) // @exempt(from: tests)
        }
    }

    internal func normalized() -> TypeSyntax {
        switch self {
        case let simple as SimpleTypeIdentifierSyntax :
            return simple.normalized()
        case let member as MemberTypeIdentifierSyntax :
            return member.normalized()
        case let tuple as TupleTypeSyntax :
            return tuple.normalized()
        case let function as FunctionTypeSyntax :
            return function.normalized()
        case let attributed as AttributedTypeSyntax :
            return attributed.normalized()
        default:
            if BuildConfiguration.current == .debug { // @exempt(from: tests)
                print("Unidentified type syntax class: \(type(of: self))")
            }
            return SyntaxFactory.makeSimpleTypeIdentifier(
                name: SyntaxFactory.makeToken(.wildcardKeyword),
                genericArgumentClause: nil)
        }

    }
}
