/*
 LibraryAPI.swift

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
  import SDGLogic
  import SDGCollections
  import SDGText
  import SDGLocalization

  import SwiftSyntax
  #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
    import PackageModel
  #endif

  import SDGSwift
  import SDGSwiftPackageManager

  import SDGSwiftLocalizations

  /// A library product of a package.
  public final class LibraryAPI: _NonOverloadableAPIElement, SortableAPIElement,
    _UniquelyDeclaredManifestAPIElement
  {

    // MARK: - Initialization

    internal init(
      documentation: [SymbolDocumentation],
      alreadyNormalizedDeclaration declaration: FunctionCallExprSyntax,
      constraints: GenericWhereClauseSyntax?,
      name: TokenSyntax,
      children: [APIElement]
    ) {

      self.declaration = declaration
      self.name = name
      _storage = APIElementStorage(documentation: documentation)
      self.constraints = constraints
    }

    // MARK: - APIElementProtocol

    public var _storage: _APIElementStorage

    public func _summarySubentries() -> [String] {
      return modules.map({ $0.name.source() })
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
