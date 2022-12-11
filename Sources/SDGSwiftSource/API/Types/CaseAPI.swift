/*
 CaseAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SDGLogic

  import SwiftSyntax

  /// An enumeration case.
  public final class CaseAPI {

    // MARK: - DeclaredAPIElement

    // #documentation(SDGSwiftSource.UniquelyDeclaredAPIElement.declaration)
    /// The element’s declaration.
    public internal(set) var declaration: EnumCaseDeclSyntax
    // #documentation(SDGSwiftSource.UniquelyDeclaredAPIElement.name)
    /// The element’s name.
    public let name: EnumCaseDeclSyntax

    // MARK: - UniquelyDeclaredAPIElement

    internal init(
      documentation: [SymbolDocumentation],
      alreadyNormalizedDeclaration declaration: EnumCaseDeclSyntax,
      name: EnumCaseDeclSyntax,
      children: [APIElement]
    ) {

      self.declaration = declaration
      self.name = name
    }
  }
#endif
