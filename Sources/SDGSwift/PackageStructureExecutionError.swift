/*
 PackageStructureExecutionError.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText
import SDGLocalization
import SDGExternalProcess

import SDGSwiftLocalizations

extension Package {

  /// An error encountered while executing a tool from a Swift package.
  public enum ExecutionError: PresentableError {

    /// Git encountered an error.
    case gitError(VersionedExternalProcessExecutionError<Git>)

    /// Failed to build the tool.
    case buildError(BuildError)

    /// Foundation encountered an error.
    case foundationError(Swift.Error)

    /// The package did not produce an executable with any of the requested names.
    case noSuchExecutable(requested: Set<StrictString>)

    /// The tool encountered an error during its execution.
    case executionError(ExternalProcess.Error)

    // MARK: - PresentableError

    public func presentableDescription() -> StrictString {
      switch self {
      case .gitError(let error):
        return error.presentableDescription()
      case .buildError(let error):
        return error.presentableDescription()
      case .foundationError(let error):
        return StrictString(error.localizedDescription)
      case .noSuchExecutable(let requested):
        let list = requested.sorted().joined(separator: "\n")

        return UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return
              "The package did not produce an executable with any of the requested names:\n\(list)"
          case .deutschDeutschland:
            return
              "Das Paket hat keine ausführbare Datei erzeugt, die mit einem der angeforderten Namen übereinstimmt:\n\(list)"
          }
        }).resolved()
      case .executionError(let error):
        return error.presentableDescription()
      }
    }
  }
}
