/*
 Syntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SwiftSyntax

import SDGSwiftSource

extension Syntax {

  var accessors: Syntax? {
    switch self {
    case is StructDeclSyntax,
      is ClassDeclSyntax,
      is EnumDeclSyntax,
      is TypealiasDeclSyntax,
      is AssociatedtypeDeclSyntax,

      is InitializerDeclSyntax,
      is FunctionDeclSyntax:
      return nil
    case let variable as VariableDeclSyntax:
      return variable.bindings.first?.accessor
    case let `subscript` as SubscriptDeclSyntax:
      return `subscript`.accessor
    default:
      print("Unidentified declaration type: \(self)")
      return nil
    }
  }

  var withoutAccessors: Syntax {
    switch self {
    case is StructDeclSyntax,
      is ClassDeclSyntax,
      is EnumDeclSyntax,
      is TypealiasDeclSyntax,
      is AssociatedtypeDeclSyntax,

      is InitializerDeclSyntax,
      is FunctionDeclSyntax:
      return self
    case let variable as VariableDeclSyntax:
      let bindings = variable.bindings.map({ $0.withAccessor(nil) })
      return variable.withBindings(SyntaxFactory.makePatternBindingList(bindings))
    case let `subscript` as SubscriptDeclSyntax:
      return `subscript`.withAccessor(nil)
    default:
      print("Unidentified declaration type: \(self)")
      return self
    }
  }

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
