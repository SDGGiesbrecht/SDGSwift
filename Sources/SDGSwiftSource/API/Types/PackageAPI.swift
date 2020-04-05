/*
 PackageAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(workspace version 0.32.0, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(Android))
  import Foundation

  import SDGLogic
  import SDGCollections
  import SDGText
  import SDGLocalization

  import SwiftSyntax
  import PackageModel
  import PackageGraph

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

    /// Creates a package API instance by parsing the specified package’s sources.
    ///
    /// - Parameters:
    ///     - package: The package, already loaded by the `SwiftPM` package.
    ///     - ignoredDependencies: Optional. An array of dependency module names known to be irrelevant to documentation. Parsing can be sped up by specifing dependencies to skip, but if a dependency is skipped, its API will not be available to participate in inheritance resolution.
    ///     - reportProgress: Optional. A closure to execute to report progress at significant milestones.
    ///     - progressReport: A line of text reporting a progress milestone.
    public convenience init(
      package: PackageGraph,
      ignoredDependencies: Set<String> = [],
      reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress
    ) throws {

      let root = package.rootPackages.first!.underlyingPackage
      try self.init(package: root, reportProgress: reportProgress)

      var dependencyModules: [ModuleAPI] = []

      for (name, source) in [
        ("Swift", Resources.CoreLibraries.swift),
        ("Foundation", Resources.CoreLibraries.foundation),
        ("Dispatch", Resources.CoreLibraries.dispatch),
        ("XCTest", Resources.CoreLibraries.xctest),
      ] where name ∉ ignoredDependencies {
        reportProgress(
          String(PackageAPI.reportForLoadingInheritance(from: StrictString(name)).resolved())
        )
        dependencyModules.append(try ModuleAPI(source: source))
      }

      let declaredDependencies = package.reachableTargets.filter({ module in
        switch module.type {
        case .executable, .systemModule, .test:
          return false
        case .library:
          return ¬root.targets.contains(module.underlyingTarget)
        }
      })
      for module in declaredDependencies.sorted(by: { $0.name < $1.name })
      where module.name ∉ ignoredDependencies {
        reportProgress(
          String(PackageAPI.reportForLoadingInheritance(from: StrictString(module.name)).resolved())
        )
        dependencyModules.append(
          try ModuleAPI(module: module.underlyingTarget, manifest: Optional<Syntax>.none)
        )
      }

      for module in dependencyModules {
        self.dependencies.append(module)
      }
      APIElement.resolveConformances(
        elements: [.package(self)] + dependencyModules.lazy.map({ APIElement.module($0) })
      )
    }

    private static func documentation(
      for package: PackageModel.Package,
      from manifest: SourceFileSyntax
    ) -> [SymbolDocumentation] {
      let search =
        "Package(".scalars
        + RepetitionPattern(ConditionalPattern({ $0 ∈ CharacterSet.whitespacesAndNewlines }))
        + "name: \u{22}\(package.name)\u{22}".scalars
      let node = manifest.smallestSubnode(containing: search)
      let manifestDeclaration = node?.ancestors().first(where: { $0.is(VariableDeclSyntax.self) })
      return manifestDeclaration?.documentation ?? []  // @exempt(from: tests)
    }

    /// Returns the documentation of the package declaration.
    ///
    /// - Parameters:
    ///     - package: The package, already loaded by the `SwiftPM` package.
    public static func documentation(for package: PackageModel.Package) throws
      -> [SymbolDocumentation]
    {
      let manifestURL = URL(fileURLWithPath: package.manifest.path.pathString)
      let manifest = try SyntaxParser.parseAndRetry(manifestURL)
      return documentation(for: package, from: manifest)
    }

    internal convenience init(
      package: PackageModel.Package,
      reportProgress: (String) -> Void = SwiftCompiler._ignoreProgress
    ) throws {

      let manifestURL = URL(fileURLWithPath: package.manifest.path.pathString)
      let manifest = try SyntaxParser.parseAndRetry(manifestURL)

      let documentation = PackageAPI.documentation(for: package, from: manifest)

      let declaration = FunctionCallExprSyntax.normalizedPackageDeclaration(name: package.name)
      self.init(documentation: documentation, declaration: declaration)

      for product in package.products where ¬product.name.hasPrefix("_") {
        switch product.type {
        case .library:
          children.append(
            .library(
              try LibraryAPI(product: product, manifest: manifest, reportProgress: reportProgress)
            )
          )
        case .executable, .test:
          continue
        }
      }

      for library in libraries {
        for module in library.modules where ¬modules.contains(module) {
          children.append(.module(module))
        }
      }
    }

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
