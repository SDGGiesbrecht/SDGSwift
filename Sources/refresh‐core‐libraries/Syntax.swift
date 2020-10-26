/*
 Syntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.3, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(WASI) || os(Android))
  import SDGLogic

  import SwiftSyntax

  import SDGSwiftSource

  extension Syntax {

    var accessors: Syntax? {
      if self.is(StructDeclSyntax.self)
        ∨ self.is(ClassDeclSyntax.self)
        ∨ self.is(EnumDeclSyntax.self)
        ∨ self.is(TypealiasDeclSyntax.self)
        ∨ self.is(AssociatedtypeDeclSyntax.self)

        ∨ self.is(InitializerDeclSyntax.self)
        ∨ self.is(FunctionDeclSyntax.self)
      {
        return nil
      } else if let variable = self.as(VariableDeclSyntax.self) {
        return variable.bindings.first?.accessor
      } else if let `subscript` = self.as(SubscriptDeclSyntax.self) {
        return `subscript`.accessor
      } else {
        print("Unidentified declaration type: \(self)")
        return nil
      }
    }

    var withoutAccessors: Syntax {
      if self.is(StructDeclSyntax.self)
        ∨ self.is(ClassDeclSyntax.self)
        ∨ self.is(EnumDeclSyntax.self)
        ∨ self.is(TypealiasDeclSyntax.self)
        ∨ self.is(AssociatedtypeDeclSyntax.self)

        ∨ self.is(InitializerDeclSyntax.self)
        ∨ self.is(FunctionDeclSyntax.self)
      {
        return self
      } else if let variable = self.as(VariableDeclSyntax.self) {
        let bindings = variable.bindings.map({ $0.withAccessor(nil) })
        return Syntax(variable.withBindings(SyntaxFactory.makePatternBindingList(bindings)))
      } else if let `subscript` = self.as(SubscriptDeclSyntax.self) {
        return Syntax(`subscript`.withAccessor(nil))
      } else {
        print("Unidentified declaration type: \(self)")
        return self
      }
    }

    var genericParameters: GenericParameterClauseSyntax? {
      if self.is(StructDeclSyntax.self)
        ∨ self.is(ClassDeclSyntax.self)
        ∨ self.is(EnumDeclSyntax.self)
        ∨ self.is(TypealiasDeclSyntax.self)
        ∨ self.is(AssociatedtypeDeclSyntax.self)

        ∨ self.is(VariableDeclSyntax.self)
      {
        return nil
      } else if let initializer = self.as(InitializerDeclSyntax.self) {
        return initializer.genericParameterClause
      } else if let `subscript` = self.as(SubscriptDeclSyntax.self) {
        return `subscript`.genericParameterClause
      } else if let function = self.as(FunctionDeclSyntax.self) {
        return function.genericParameterClause
      } else {
        print("Unidentified declaration type: \(self)")
        return nil
      }
    }
  }
#endif
