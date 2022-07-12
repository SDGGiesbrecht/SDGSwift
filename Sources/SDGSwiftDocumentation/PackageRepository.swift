/*
 PackageRepository.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGCollections

import SDGSwift
import SDGSwiftPackageManager

import SymbolKit
import Foundation

extension PackageRepository {

  private func publicModules() -> Result<Set<String>, SwiftCompiler.PackageLoadingError> {
    return manifest().map { manifest in
      return Set(
        manifest.products
          .lazy.filter({ ¬$0.name.hasPrefix("_") })
          .flatMap({ (product) -> [String] in
            switch product.type {
            case .library:
              return product.targets
                .lazy.filter { ¬$0.hasPrefix("_") }
            case .executable, .snippet, .plugin, .test:
              return []
            }
          })
      )
    }
  }

  #if !PLATFORM_LACKS_FOUNDATION_PROCESS
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
      switch exportSymbolGraph(reportProgress: reportProgress) {
      case .failure(let error):
        return .failure(.exportError(error))
      case .success(let exports):
        var graphs: [SymbolGraph]
        do {
          graphs = try FileManager.default.contents(ofDirectory: exports).map({ file in
            return try SymbolGraph(from: file)
          })
        } catch {
          return .failure(.loadingError(error))
        }

        if filteringUnreachable {
          switch publicModules() {
          case .failure(let error):
            return .failure(.packageLoadingError(error))
          case .success(let reachable):
            graphs.removeAll(where: { graph in
              return graph.module.name ∉ reachable
            })
          }
        }

        return .success(graphs)
      }
    }
  #endif
}
