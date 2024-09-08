/*
 PackageRepositoryInitializationError.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText
import SDGLocalization

import SDGSwift

extension PackageRepository {

  /// An error encountered while initializing a package repository.
  public enum InitializationError: PresentableError {

    /// The package manager encountered an error.
    case packageManagerError(Swift.Error)

    /// Git encountered an error.
    case gitError(VersionedExternalProcessExecutionError<Git>)

    // MARK: - PresentableError

    public func presentableDescription() -> StrictString {
      switch self {
      case .packageManagerError(let error):
        return StrictString(error.localizedDescription)
      case .gitError(let error):
        return error.presentableDescription()
      }
    }
  }
}
