/*
 PackageAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import Foundation

  import SDGLogic
  import SDGCollections
  import SDGText
  import SDGLocalization

  import SwiftSyntax
  #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
    import SwiftSyntaxParser
  #endif
  #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
    import PackageModel
    import PackageGraph
  #endif

  import SDGSwift
  import SDGSwiftPackageManager

  import SDGSwiftLocalizations

  /// A package.
  public final class PackageAPI: _NonOverloadableAPIElement, SortableAPIElement,
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

    // MARK: - Properties

    // Storage because conformances only have weak references.
    private var dependencies: [ModuleAPI] = []

    // MARK: - APIElementProtocol

    public func _summarySubentries() -> [String] {
      var result = Array(libraries.lazy.map({ $0.summary() }).joined())
      result.append(contentsOf: modules.lazy.map({ $0.summary() }).joined())
      return result
    }

    // MARK: - APIElementProtocol

    public var _storage: _APIElementStorage

    // MARK: - DeclaredAPIElement

    // #documentation(SDGSwiftSource.UniquelyDeclaredAPIElement.declaration)
    /// The element’s declaration.
    public let declaration: FunctionCallExprSyntax
    // #documentation(SDGSwiftSource.UniquelyDeclaredAPIElement.name)
    /// The element’s name.
    public let name: TokenSyntax
  }
#endif
