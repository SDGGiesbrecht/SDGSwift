/*
 PackageRepository.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

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

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_SYNTAX
  import SwiftSyntax
#endif
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
    ) -> Result<[SymbolGraph], SymbolGraph.LoadingError> {
      switch exportSymbolGraph(reportProgress: reportProgress) {
      case .failure(let error):
        return .failure(.exportError(error))
      case .success(let exports):
        var graphs: [SymbolGraph]
        do {
          graphs = try FileManager.default.contents(ofDirectory: exports).sorted().map({ file in
            return try SymbolGraph(from: file)
          })
        } catch {
          return .failure(.loadingError(error))
        }

        if filteringUnreachable,
          let reachable = manifest?.publicModules()
        {
          graphs.removeAll(where: { graph in
            return graph.module.name ∉ reachable
          })
          graphs = graphs.enumerated().sorted(by: { first, second in
            return (
              reachable.firstIndex(of: first.element.module.name)
                ?? reachable.endIndex,  // @exempt(from: tests)
              first.offset
            )
              < (
                reachable.firstIndex(of: second.element.module.name)
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
    ///     - progressReport: A line of output.
    public func symbolGraphs(
      filteringUnreachable: Bool = true,
      reportProgress: (_ progressReport: String) -> Void = { _ in }  // @exempt(from: tests)
    ) -> Result<[SymbolGraph], SymbolGraph.LoadingError> {
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

    /// Loads and returns the package’s API.
    ///
    /// - Parameters:
    ///     - reportProgress: Optional. A closure to execute for each line of the compiler’s output.
    public func api(
      reportProgress: (_ progressReport: String) -> Void = { _ in }  // @exempt(from: tests)
    ) -> Result<PackageAPI, SymbolGraph.LoadingError> {
      let manifestSource =
        (try? SyntaxParser.parse(location.appendingPathComponent("Package.swift")))
        ?? SyntaxFactory.makeBlankSourceFile()  // @exempt(from: tests)
      switch package() {
      case .failure(let error):
        return .failure(.packageLoadingError(error))
      case .success(let package):
        switch symbolGraphs(filteringUnreachable: true, reportProgress: reportProgress) {
        case .failure(let error):
          return .failure(error)
        case .success(let symbolGraphs):
          return .success(
            PackageAPI(
              name: package.manifest.displayName,
              manifestSource: manifestSource,
              libraries: package.manifest.publicLibraries(manifest: manifestSource),
              symbolGraphs: symbolGraphs,
              moduleSources: package.publicModuleSources()
            )
          )
        }
      }
    }
  #endif
}
