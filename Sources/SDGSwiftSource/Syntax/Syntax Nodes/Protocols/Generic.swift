/*
 Generic.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.2.1, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(WASI) || os(Android))
  import SwiftSyntax

  import SDGLogic

  internal protocol Generic: Constrained {
    var genericParameterClause: GenericParameterClauseSyntax? { get }
  }

  extension Generic {

    internal func normalizedGenerics() -> (GenericParameterClauseSyntax?, GenericWhereClauseSyntax?)
    {

      var newGenericParemeterClause: GenericParameterClauseSyntax?
      var newGenericWhereClause: GenericWhereClauseSyntax?
      if let originalGenericParameterClause = genericParameterClause {
        (newGenericParemeterClause, newGenericWhereClause) =
          originalGenericParameterClause.normalizedForAPIDeclaration()
      }

      newGenericWhereClause.merge(with: genericWhereClause?.normalized())
      return (newGenericParemeterClause, newGenericWhereClause)
    }
  }
#endif
