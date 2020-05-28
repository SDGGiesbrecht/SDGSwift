/*
 TypeDeclaration.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.2.4, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(WASI) || os(Android))
  import SDGLogic
  import SDGCollections

  import SwiftSyntax

  internal protocol TypeDeclaration: AccessControlled, Attributed, APISyntax, Generic, Inheritor {
    var identifier: TokenSyntax { get }

    func normalizedAPIDeclaration() -> (declaration: Self, constraints: GenericWhereClauseSyntax?)
    func name() -> Self
  }

  extension TypeDeclaration {

    internal func identifierList() -> Set<String> {
      var result: Set<String> = [identifier.text]
      if let genericParameters = genericParameterClause {
        result ∪= genericParameters.identifierList()
      }
      return result
    }

    // MARK: - APISyntax

    internal var shouldLookForChildren: Bool {
      return true
    }

    internal func createAPI(children: [APIElement]) -> [APIElement] {
      return [
        .type(
          TypeAPI(
            documentation: documentation,
            declaration: self,
            children: children
          )
        )
      ]
    }
  }
#endif
