/*
 Syntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGSwiftSource

extension Syntax {

    var genericParameters: GenericParameterClauseSyntax? {
        switch self {
        case is StructDeclSyntax,
             is ClassDeclSyntax,
             is EnumDeclSyntax,
             is TypealiasDeclSyntax,
             is AssociatedtypeDeclSyntax,

             is VariableDeclSyntax:
            return nil
        case let initializer as InitializerDeclSyntax:
            return initializer.genericParameterClause
        case let `subscript` as SubscriptDeclSyntax:
            return `subscript`.genericParameterClause
        case let function as FunctionDeclSyntax:
            return function.genericParameterClause
        default:
            print("Unidentified declaration type: \(self)")
            return nil
        }
    }
}
