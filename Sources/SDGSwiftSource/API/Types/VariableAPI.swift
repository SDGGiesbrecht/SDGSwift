/*
 VariableAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SwiftSyntax

/// A variable or property.
public final class VariableAPI: _APIElementBase, SortableAPIElement,
  UniquelyDeclaredOverloadableAPIElement, _UniquelyDeclaredSyntaxAPIElement
{

  // MARK: - Initialization

  internal init(
    documentation: [SymbolDocumentation],
    alreadyNormalizedDeclaration declaration: VariableDeclSyntax,
    constraints: GenericWhereClauseSyntax?,
    name: VariableDeclSyntax,
    children: [APIElement]
  ) {

    self.declaration = declaration
    self.name = name
    _storage = APIElementStorage(documentation: documentation)
    super.init()
    self.constraints = constraints
  }

  // MARK: - APIElementProtocol

  public var _storage: _APIElementStorage

  // MARK: - DeclaredAPIElement

  // #documentation(SDGSwiftSource.UniquelyDeclaredAPIElement.declaration)
  /// The element’s declaration.
  public let declaration: VariableDeclSyntax
  // #documentation(SDGSwiftSource.UniquelyDeclaredAPIElement.name)
  /// The element’s name.
  public let name: VariableDeclSyntax
}
