/*
 ModuleAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import Foundation

  import SDGControlFlow
  import SDGCollections

  import SwiftSyntax
  #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
    import SwiftSyntaxParser
  #endif
  #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
    import PackageModel
  #endif

  import SDGSwiftPackageManager

  /// A Swift module.
  public final class ModuleAPI:
    _UniquelyDeclaredManifestAPIElement
  {

    internal init(
      documentation: [SymbolDocumentation],
      alreadyNormalizedDeclaration declaration: FunctionCallExprSyntax,
      name: TokenSyntax,
      children: [APIElement]
    ) {

      self.declaration = declaration
      self.name = name
    }

    // MARK: - DeclaredAPIElement

    // #documentation(SDGSwiftSource.UniquelyDeclaredAPIElement.declaration)
    /// The element’s declaration.
    public let declaration: FunctionCallExprSyntax
    // #documentation(SDGSwiftSource.UniquelyDeclaredAPIElement.name)
    /// The element’s name.
    public let name: TokenSyntax
  }
#endif
