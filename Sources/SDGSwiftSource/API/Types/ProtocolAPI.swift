/*
 ProtocolAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollections

import SwiftSyntax

/// A protocol.
public final class ProtocolAPI: _APIElementBase, APIElementProtocol, _NonOverloadableAPIElement,
  SortableAPIElement, _UniquelyDeclaredSyntaxAPIElement
{

  // MARK: - Initialization

  internal init(
    documentation: [SymbolDocumentation],
    alreadyNormalizedDeclaration declaration: ProtocolDeclSyntax,
    constraints: GenericWhereClauseSyntax?,
    name: ProtocolDeclSyntax,
    children: [APIElement]
  ) {

    self.declaration = declaration
    self.name = name
    super.init(documentation: documentation, children: children)
    self.constraints = constraints

    for child in children {
      child.elementBase.isProtocolRequirement = true
    }
  }

  // MARK: - APIElementProtocol

  public var _storage: _APIElementStorage = APIElementStorage()

  // MARK: - DeclaredAPIElement

  // #documentation(SDGSwiftSource.UniquelyDeclaredAPIElement.declaration)
  /// The element’s declaration.
  public internal(set) var declaration: ProtocolDeclSyntax
  // #documentation(SDGSwiftSource.UniquelyDeclaredAPIElement.name)
  /// The element’s name.
  public let name: ProtocolDeclSyntax
}
