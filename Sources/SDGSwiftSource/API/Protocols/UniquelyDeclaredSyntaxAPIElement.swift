/*
 UniquelyDeclaredSyntaxAPIElement.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

internal protocol _UniquelyDeclaredSyntaxAPIElement: _UniquelyDeclaredAPIElement
where Declaration: APIDeclaration, Name == Declaration.Name {}

extension _UniquelyDeclaredSyntaxAPIElement {

  internal init(
    documentation: [SymbolDocumentation],
    declaration: Declaration,
    children: [APIElement] = []
  ) {
    let normalized = declaration.normalizedAPIDeclaration()
    self.init(
      documentation: documentation,
      alreadyNormalizedDeclaration: normalized,
      constraints: nil,
      name: normalized.name(),
      children: children
    )
  }

  // MARK: - UniquelyDeclaredAPIElement

  public func _shallowIdentifierList() -> Set<String> {
    return declaration.identifierList()
  }
}

extension _UniquelyDeclaredSyntaxAPIElement where Declaration: Constrained {

  internal init(
    documentation: [SymbolDocumentation],
    declaration: Declaration,
    children: [APIElement] = []
  ) {
    var normalized = declaration.normalizedAPIDeclaration()
    let constraints = normalized.genericWhereClause
    normalized = normalized.withGenericWhereClause(nil)
    self.init(
      documentation: documentation,
      alreadyNormalizedDeclaration: normalized,
      constraints: constraints,
      name: normalized.name(),
      children: children
    )
  }
}
