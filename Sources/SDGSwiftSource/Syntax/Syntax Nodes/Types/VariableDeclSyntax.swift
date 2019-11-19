/*
 VariableDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic

import SwiftSyntax

extension VariableDeclSyntax: AccessControlled, Accessor, APIDeclaration, APISyntax, Attributed,
  Member, OverloadableAPIDeclaration, OverridableDeclaration
{

  // MARK: - Accessor

  var keyword: TokenSyntax {
    return letOrVarKeyword
  }

  var accessors: Syntax? {
    return bindings.first?.accessor
  }

  // MARK: - APIDeclaration

  internal func normalizedAPIDeclaration() -> VariableDeclSyntax {
    return SyntaxFactory.makeVariableDecl(
      attributes: attributes?.normalizedForAPIDeclaration(),
      modifiers: modifiers?.normalizedForAPIDeclaration(operatorFunction: false),
      letOrVarKeyword: SyntaxFactory.makeToken(.varKeyword, trailingTrivia: .spaces(1)),
      bindings: bindings.normalizedForVariableAPIDeclaration(
        accessor: accessorListForAPIDeclaration()
      )
    )
  }

  internal func name() -> VariableDeclSyntax {
    return SyntaxFactory.makeVariableDecl(
      attributes: nil,
      modifiers: nil,
      letOrVarKeyword: SyntaxFactory.makeToken(.varKeyword, presence: .missing),
      bindings: bindings.forVariableName()
    )
  }

  internal func identifierList() -> Set<String> {
    let identifiers = bindings.lazy.map { binding in
      return binding.pattern.flattenedForAPI().lazy.map { flattened in
        return flattened.identifier.identifier.text
      }
    }
    return Set(identifiers.joined())
  }

  // MARK: - APISyntax

  internal var isHidden: Bool {
    return bindings.allSatisfy({ $0.pattern.concreteSyntaxIsHidden })
  }

  internal var shouldLookForChildren: Bool {
    return false
  }

  internal func createAPI(children: [APIElement]) -> [APIElement] {
    var list: [APIElement] = []
    for separate in bindings.flattenedForAPI() {
      list.append(
        .variable(
          VariableAPI(
            documentation: list.isEmpty ? documentation : [],  // The documentation only applies to the first.
            declaration: SyntaxFactory.makeVariableDecl(
              attributes: attributes,
              modifiers: modifiers,
              letOrVarKeyword: letOrVarKeyword,
              bindings: separate
            )
          )
        )
      )
    }
    return list
  }

  // MARK: - OverloadableAPIDeclaration

  internal func overloadPattern() -> VariableDeclSyntax {
    return SyntaxFactory.makeVariableDecl(
      attributes: nil,
      modifiers: modifiers?.forOverloadPattern(),
      letOrVarKeyword: letOrVarKeyword,
      bindings: bindings.forVariableOverloadPattern()
    )
  }
}
