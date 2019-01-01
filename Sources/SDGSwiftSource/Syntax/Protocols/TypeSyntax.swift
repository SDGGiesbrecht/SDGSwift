/*
 TypeSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic

extension TypeSyntax {

    internal func normalized(extractingFromIndexPath indexPath: [Int] = []) -> TypeSyntax {
        switch self {
        case let simple as SimpleTypeIdentifierSyntax:
            return simple.normalized()
        case let metatype as MetatypeTypeSyntax:
            return metatype.normalized()
        case let member as MemberTypeIdentifierSyntax:
            return member.normalized()
        case let optional as OptionalTypeSyntax:
            return optional.normalized()
        case let tuple as TupleTypeSyntax:
            return tuple.normalized(extractingFromIndexPath: indexPath)
        case let composition as CompositionTypeSyntax:
            return composition.normalized()
        case let array as ArrayTypeSyntax:
            return array.normalized()
        case let dictionary as DictionaryTypeSyntax:
            return dictionary.normalized()
        case let function as FunctionTypeSyntax:
            return function.normalized()
        case let attributed as AttributedTypeSyntax:
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
