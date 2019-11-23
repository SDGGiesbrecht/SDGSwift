/*
 OperatorAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SwiftSyntax

/// An operator.
public final class OperatorAPI: _APIElementBase, APIElementProtocol, DeclaredAPIElement,
  _NonOverloadableAPIElement, SortableAPIElement, _UniquelyDeclaredAPIElement,
  _UniquelyDeclaredSyntaxAPIElement
{

  // MARK: - DeclaredAPIElement

  // #documentation(SDGSwiftSource.UniquelyDeclaredAPIElement.declaration)
  /// The element’s declaration.
  public internal(set) var declaration: OperatorDeclSyntax
  // #documentation(SDGSwiftSource.UniquelyDeclaredAPIElement.name)
  /// The element’s name.
  public let name: OperatorDeclSyntax

  // MARK: - UniquelyDeclaredAPIElement

  internal init(
    documentation: [SymbolDocumentation],
    alreadyNormalizedDeclaration declaration: OperatorDeclSyntax,
    constraints: GenericWhereClauseSyntax?,
    name: OperatorDeclSyntax,
    children: [APIElement]
  ) {

    self.declaration = declaration
    self.name = name
    super.init(documentation: documentation)
    self.constraints = constraints
  }
}
