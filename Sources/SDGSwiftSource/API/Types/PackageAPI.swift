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

    // MARK: - Static Methods

    internal static func reportForLoadingInheritance(
      from module: StrictString
    ) -> UserFacing<StrictString, InterfaceLocalization> {
      return UserFacing<StrictString, InterfaceLocalization>({ localization in
        switch localization {
        case .englishUnitedKingdom:
          return "Loading inheritance from ‘\(module)’..."
        case .englishUnitedStates, .englishCanada:
          return "Loading inheritance from “\(module)”..."
        case .deutschDeutschland:
          return "Erbe von „\(module)“ wird geladen ..."
        }
      })
    }

    // MARK: - Initialization

    #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
      @available(macOS 10.15, *)
      private static func documentation(
        for package: PackageModel.Package,
        from manifest: SourceFileSyntax
      ) -> [SymbolDocumentation] {
        let search =
          "Package(".scalars
          + RepetitionPattern(ConditionalPattern({ $0 ∈ CharacterSet.whitespacesAndNewlines }))
          + "name: \u{22}\(package.manifest.displayName)\u{22}".scalars
        let node = manifest.smallestSubnode(containing: search)
        let manifestDeclaration = node?.ancestors().first(where: { $0.is(VariableDeclSyntax.self) })
        return manifestDeclaration?.documentation ?? []  // @exempt(from: tests)
      }

      /// Returns the documentation of the package declaration.
      ///
      /// - Parameters:
      ///     - package: The package, already loaded by the `SwiftPM` package.
      @available(macOS 10.15, *)
      public static func documentation(
        for package: PackageModel.Package
      ) throws -> [SymbolDocumentation] {
        let manifestURL = URL(fileURLWithPath: package.manifest.path.pathString)
        let manifest = try SyntaxParser.parseAndRetry(manifestURL)
        return documentation(for: package, from: manifest)
      }

      @available(macOS 10.15, *)
      internal convenience init(
        package: PackageModel.Package,
        reportProgress: (String) -> Void
      ) throws {

        let manifestURL = URL(fileURLWithPath: package.manifest.path.pathString)
        let manifest = try SyntaxParser.parseAndRetry(manifestURL)

        let documentation = PackageAPI.documentation(for: package, from: manifest)

        let declaration = FunctionCallExprSyntax.normalizedPackageDeclaration(
          name: package.manifest.displayName
        )
        self.init(documentation: documentation, declaration: declaration)

        for product in package.products where ¬product.name.hasPrefix("_") {
          switch product.type {
          case .library:
            children.append(
              .library(
                try LibraryAPI(product: product, manifest: manifest, reportProgress: reportProgress)
              )
            )
          case .executable, .test, .plugin, .snippet:
            continue
          }
        }

        for library in libraries {
          for module in library.modules where ¬modules.contains(module) {
            children.append(.module(module))
          }
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
