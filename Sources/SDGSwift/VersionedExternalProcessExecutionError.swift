/*
 VersionedExternalProcessExecutionError.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGText
import SDGLocalization
import SDGExternalProcess

import SDGSwiftLocalizations

/// An error encountered while using Git.
public enum VersionedExternalProcessExecutionError<Process>: PresentableError
where Process: VersionedExternalProcess {

  /// Git could not be located.
  case locationError(VersionedExternalProcessLocationError<Process>)

  /// Git encountered an error during its execution.
  case executionError(ExternalProcess.Error)

  // MARK: - PresentableError

  public func presentableDescription() -> StrictString {
    switch self {
    case .locationError(let error):
      return error.presentableDescription()
    case .executionError(let error):
      return error.presentableDescription()
    }
  }
}
