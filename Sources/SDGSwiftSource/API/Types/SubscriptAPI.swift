/*
 SubscriptAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftSyntax won’t compile.)
  import SDGLogic
  import SDGCollections

  import SwiftSyntax

  /// A subscript.
  public final class SubscriptAPI: SortableAPIElement,
    UniquelyDeclaredOverloadableAPIElement, _UniquelyDeclaredSyntaxAPIElement
  {

    // MARK: - Initialization

    internal init(
      documentation: [SymbolDocumentation],
      alreadyNormalizedDeclaration declaration: SubscriptDeclSyntax,
      constraints: GenericWhereClauseSyntax?,
      name: SubscriptDeclSyntax,
      children: [APIElement]
    ) {

      self.declaration = declaration
      self.name = name
      self._storage = APIElementStorage(documentation: documentation)
      self.constraints = constraints
    }

    // MARK: - APIElementProtocol

    public var _storage: _APIElementStorage

    // MARK: - DeclaredAPIElement

    internal typealias Declaration = SubscriptDeclSyntax

    // #documentation(SDGSwiftSource.UniquelyDeclaredAPIElement.declaration)
    /// The element’s declaration.
    public internal(set) var declaration: SubscriptDeclSyntax
    // #documentation(SDGSwiftSource.UniquelyDeclaredAPIElement.name)
    /// The element’s name.
    public let name: SubscriptDeclSyntax
  }
#endif
