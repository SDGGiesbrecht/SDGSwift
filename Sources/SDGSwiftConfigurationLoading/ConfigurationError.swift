/*
 ConfigurationError.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText
import SDGLocalization

import SDGSwift
import SDGSwiftConfiguration

import SDGSwiftLocalizations

extension Configuration {

  /// An error encountered while loading a configuration.
  public enum Error: PresentableError {

    // MARK: - Cases

    /// Foundation encountered an error.
    case foundationError(Swift.Error)

    /// Swift encountered an error.
    case swiftError(VersionedExternalProcessExecutionError<SwiftCompiler>)

    /// The configuration is empty.
    case emptyConfiguration

    /// The configuration is corrupt.
    case corruptConfiguration

    // MARK: - PresentableError

    public func presentableDescription() -> StrictString {
      switch self {
      case .foundationError(let error):
        return StrictString(error.localizedDescription)
      case .swiftError(let error):
        return error.presentableDescription()
      case .emptyConfiguration:
        return UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "The configuration is empty."
          case .deutschDeutschland:
            return "Die Konfiguration ist lehr."
          }
        }).resolved()
      case .corruptConfiguration:
        return UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
            return "The configuration is corrupt."
          case .deutschDeutschland:
            return "Die Konfiguration ist beschädigt."
          }
        }).resolved()
      }
    }
  }
}
