/*
 PackageRepository.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGLogic
import SDGCollections

import SDGSwift
import SDGSwiftPackageManager

import SymbolKit

  import SwiftSyntax
#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX_PARSER
  import SwiftSyntaxParser
#endif
#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
  import PackageModel
#endif

extension PackageRepository {

  #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
    private func symbolGraphs(
      filteringUnreachable: Bool = true,
      manifest: Manifest?,
      reportProgress: (_ progressReport: String) -> Void = { _ in }  // @exempt(from: tests)
    ) -> Result<[LoadedSymbolGraph], SymbolGraph.LoadingError> {
      switch exportSymbolGraph(reportProgress: reportProgress) {
      case .failure(let error):
        return .failure(.exportError(error))
      case .success(let exports):
        var graphs: [LoadedSymbolGraph]
        do {
          graphs = try FileManager.default.contents(ofDirectory: exports).sorted().map({ file in
            return LoadedSymbolGraph(graph: try SymbolGraph(from: file), origin: file)
          })
        } catch {
          return .failure(.loadingError(error))
        }

        if filteringUnreachable,
          let reachable = manifest?.publicModules()
        {
          graphs.removeAll(where: { graph in
            return graph.graph.module.name ∉ reachable
          })
          graphs = graphs.enumerated().sorted(by: { first, second in
            return (
              reachable.firstIndex(of: first.element.graph.module.name)
                ?? reachable.endIndex,  // @exempt(from: tests)
              first.offset
            )
              < (
                reachable.firstIndex(of: second.element.graph.module.name)
                  ?? reachable.endIndex,  // @exempt(from: tests)
                second.offset
              )
          }).map { $0.element }
        }

        return .success(graphs)
      }
    }

    /// Exports and loads the package’s symbol graphs.
    ///
    /// - Parameters:
    ///     - filteringUnreachable: Whether unreachable modules should be filtered out. Defaults to `true`.
    ///     - reportProgress: Optional. A closure to execute for each line of the compiler’s output.
    @available(macOS 10.15, *)
    public func symbolGraphs(
      filteringUnreachable: Bool = true,
      reportProgress: (_ progressReport: String) -> Void = { _ in }  // @exempt(from: tests)
    ) -> Result<[LoadedSymbolGraph], SymbolGraph.LoadingError> {
      let loadedManifest: Manifest?
      if filteringUnreachable {
        switch manifest() {
        case .failure(let error):
          return .failure(.packageLoadingError(error))
        case .success(let manifest):
          loadedManifest = manifest
        }
      } else {
        loadedManifest = nil
      }

      return symbolGraphs(
        filteringUnreachable: filteringUnreachable,
        manifest: loadedManifest,
        reportProgress: reportProgress
      )
    }

    private var manifestURL: URL {
      return location.appendingPathComponent("Package.swift")
    }
    private func manifestSource(url: URL) -> SourceFileSyntax {
      return (try? SyntaxParser.parse(manifestURL))
        ?? SourceFileSyntax(  // @exempt(from: tests)
          statements: CodeBlockItemListSyntax([]),
          eofToken: TokenSyntax(.eof, presence: .missing)
        )
    }
    private func reported(manifestURL: URL) -> String {
      return manifestURL.absoluteString
    }
    /// Loads only the documentation of the root package documentation node without loading the rest of the API.
    ///
    /// - Parameters:
    ///   - packageName: The name of the package.
    public func documentation(packageName: String) -> [SymbolDocumentation] {
      let manifestURL = self.manifestURL
      let manifestSource = self.manifestSource(url: manifestURL)
      return PackageAPI.documentation(
        name: packageName,
        manifestURL: reported(manifestURL: manifestURL),
        manifestSource: manifestSource
      )
    }
    /// Loads and returns the package’s API.
    ///
    /// - Parameters:
    ///   - reportProgress: Optional. A closure to execute for each line of the compiler’s output.
    @available(macOS 10.15, *)
    public func api(
      reportProgress: (_ progressReport: String) -> Void = { _ in }  // @exempt(from: tests)
    ) -> Result<PackageAPI, SymbolGraph.LoadingError> {
      let manifestURL = self.manifestURL
      let manifestSource = self.manifestSource(url: manifestURL)
      switch package() {
      case .failure(let error):
        return .failure(.packageLoadingError(error))
      case .success(let package):
        switch symbolGraphs(filteringUnreachable: true, reportProgress: reportProgress) {
        case .failure(let error):
          return .failure(error)
        case .success(let symbolGraphs):
          let reportedURL = reported(manifestURL: manifestURL)
          return .success(
            PackageAPI(
              name: package.manifest.displayName,
              manifestURL: reportedURL,
              manifestSource: manifestSource,
              libraries: package.manifest.publicLibraries(
                manifestURL: reportedURL,
                manifest: manifestSource
              ),
              symbolGraphs: symbolGraphs,
              moduleSources: package.publicModuleSources()
            )
          )
        }
      }
    }
  #endif
}
