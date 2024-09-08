/*
 SymbolGraph.LoadingError.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText
import SDGLocalization

import SDGSwift
import SDGSwiftPackageManager

import SymbolKit

extension SymbolGraph {

  #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
    /// An error encountered while loading symbol graphs.
    public enum LoadingError: PresentableError {

      /// The compiler failed to export symbol graphs.
      case exportError(VersionedExternalProcessExecutionError<SwiftCompiler>)

      /// The package manifest could not be loaded.
      case packageLoadingError(SwiftCompiler.PackageLoadingError)

      /// The symbol graphs could not be loaded.
      case loadingError(Swift.Error)

      // MARK: - PresentableError

      public func presentableDescription() -> StrictString {
        switch self {
        case .exportError(let error):
          return error.presentableDescription()
        case .packageLoadingError(let error):
          return error.presentableDescription()
        case .loadingError(let error):
          return StrictString(error.localizedDescription)
        }
      }
    }
  #endif
}
