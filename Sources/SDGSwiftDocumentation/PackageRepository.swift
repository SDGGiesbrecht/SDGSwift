/*
 PackageRepository.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGSwift

import SymbolKit
import Foundation

extension PackageRepository {

  #if !PLATFORM_LACKS_FOUNDATION_PROCESS
    /// Exports and loads the package’s symbol graphs.
    ///
    /// - Parameters:
    ///     - reportProgress: Optional. A closure to execute for each line of the compiler’s output.
    ///     - progressReport: A line of output.
    public func symbolGraphs(
      reportProgress: (_ progressReport: String) -> Void = { _ in }  // @exempt(from: tests)
    ) -> Result<[SymbolGraph], SymbolGraph.LoadingError> {
      switch exportSymbolGraph(reportProgress: reportProgress) {
      case .failure(let error):
        return .failure(.exportError(error))
      case .success(let exports):
        do {
          return .success(
            try FileManager.default.contents(ofDirectory: exports).map({ file in
              return try SymbolGraph(from: file)
            })
          )
        } catch {
          return .failure(.loadingError(error))
        }
      }
    }
  #endif
}
