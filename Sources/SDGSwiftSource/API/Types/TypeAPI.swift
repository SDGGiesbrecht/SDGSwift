/*
 TypeAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SDGControlFlow
  import SDGLogic
  import SDGCollections

  import SwiftSyntax

  /// A type.
  ///
  /// A type may be a structure, class, enumeration, type alias or associated type.
  public final class TypeAPI
  {

    // MARK: - Initialization

    internal init<T>(documentation: [SymbolDocumentation], declaration: T, children: [APIElement])
    where T: TypeDeclaration {

      let (normalizedDeclaration, _) = declaration.normalizedAPIDeclaration()
      self.declaration = normalizedDeclaration
      genericDeclaration = Syntax(normalizedDeclaration)
      genericName = Syntax(normalizedDeclaration.name())
    }

    // MARK: - Properties

    private let declaration: TypeDeclaration

    // MARK: - APIElementProtocol

    public func _shallowIdentifierList() -> Set<String> {
      return declaration.identifierList()
    }

    // MARK: - DeclaredAPIElement

    public private(set) var genericDeclaration: Syntax
    public private(set) var genericName: Syntax

    // MARK: - OverloadableAPIElement

    internal func genericOverloadPattern() -> Syntax {
      return genericName
    }
  }
#endif
