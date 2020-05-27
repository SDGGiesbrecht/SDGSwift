/*
 PackageStructureBuildError.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(WASI)  // #workaround(Swift 5.2.4, Web lacks Foundation.)
  import SDGText
  import SDGLocalization

  extension Package {

    /// An error encountered while building a Swift package.
    public enum BuildError: PresentableError {

      /// Git encountered an error.
      case gitError(VersionedExternalProcessExecutionError<Git>)

      /// Swift encountered an error.
      case swiftError(VersionedExternalProcessExecutionError<SwiftCompiler>)

      /// Foundation encountered an error.
      case foundationError(Swift.Error)

      // MARK: - PresentableError

      public func presentableDescription() -> StrictString {
        switch self {
        case .gitError(let error):
          return error.presentableDescription()
        case .swiftError(let error):
          return error.presentableDescription()
        case .foundationError(let error):
          return StrictString(error.localizedDescription)
        }
      }
    }
  }
#endif
