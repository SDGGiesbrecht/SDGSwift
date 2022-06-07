/*
 VariableAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SwiftSyntax

  /// A variable or property.
  public final class VariableAPI: SortableAPIElement,
    UniquelyDeclaredOverloadableAPIElement, _UniquelyDeclaredSyntaxAPIElement
  {

    // MARK: - Initialization

    // #workaround(Temporary for SDGSwiftDocumentationTests.)
    public convenience init(
      _documentation documentation: [SymbolDocumentation],
      declaration: VariableDeclSyntax
    ) {
      self.init(documentation: documentation, declaration: declaration)
    }
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
#endif
