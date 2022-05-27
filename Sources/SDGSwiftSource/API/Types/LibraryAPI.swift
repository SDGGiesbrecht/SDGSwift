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

    // MARK: - Static Methods

    public static func _reportForParsing(
      module: StrictString
    ) -> UserFacing<StrictString, InterfaceLocalization> {
      return reportForParsing(module: module)
    }
    internal static func reportForParsing(
      module: StrictString
    ) -> UserFacing<StrictString, InterfaceLocalization> {
      return UserFacing<StrictString, InterfaceLocalization>({ localization in
        switch localization {
        case .englishUnitedKingdom:
          return "Parsing ‘\(module)’..."
        case .englishUnitedStates, .englishCanada:
          return "Parsing “\(module)”..."
        case .deutschDeutschland:
          return "„\(module)“ wird zerteilt ..."
        }
      })
    }

    // MARK: - Initialization

    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
      public convenience init<Syntax>(
        _productSkippingModules product: Product,
        manifest: Syntax
      ) where Syntax: SyntaxProtocol {
        self.init(productSkippingModules: product, manifest: manifest)
      }
      private convenience init<Syntax>(
        productSkippingModules product: Product,
        manifest: Syntax
      ) where Syntax: SyntaxProtocol {
        let search =
          ".library(".scalars
          + RepetitionPattern(ConditionalPattern({ $0 ∈ CharacterSet.whitespacesAndNewlines }))
          + "name: \u{22}\(product.name)\u{22}".scalars
        let manifestDeclaration = manifest.smallestSubnode(containing: search)?.parent
        self.init(
          documentation: manifestDeclaration?.documentation ?? [],  // @exempt(from: tests)
          declaration: FunctionCallExprSyntax.normalizedLibraryDeclaration(name: product.name)
        )
      }
      @available(macOS 10.15, *)
      internal convenience init<Syntax>(
        product: Product,
        manifest: Syntax,
        reportProgress: (String) -> Void
      ) throws where Syntax: SyntaxProtocol {
        self.init(productSkippingModules: product, manifest: manifest)

        for module in product.targets where ¬module.name.hasPrefix("_") {
          reportProgress(
            String(LibraryAPI.reportForParsing(module: StrictString(module.name)).resolved())
          )
          children.append(.module(try ModuleAPI(module: module, manifest: manifest)))
        }
      }
    #endif

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
