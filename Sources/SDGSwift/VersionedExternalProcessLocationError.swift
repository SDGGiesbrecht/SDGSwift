/*
 VersionedExternalProcessLocationError.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText
import SDGLocalization
import SDGVersioning

import SDGSwiftLocalizations

/// An error encountered while locating a versioned external process.
public enum VersionedExternalProcessLocationError<Process>: PresentableError
where Process: VersionedExternalProcess {

  // MARK: - Cases

  /// No compatible version of the process could be located.
  case unavailable(versionConstraints: StrictString)

  // MARK: - PresentableError

  public func presentableDescription() -> StrictString {
    switch self {
    case .unavailable(let versionConstraints):
      return UserFacing<StrictString, InterfaceLocalization>({ localization in
        var lines: [StrictString]
        switch localization {
        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
          lines = [
            "No compatible version of \(Process.englishName) could be located. (\(versionConstraints))",
            "It must be installed and locatable with one of the following commands:",
          ]
        case .deutschDeutschland:
          lines = [
            "Keine passende Version von \(Process.deutscherNameInDativ) wurde gefunden. (\(versionConstraints))",
            "Es muss installiert und unter einem der folgenden Befehle vorhanden sein:",
          ]
        }
        lines += Process.searchCommands
          .map({ "$ \($0.joined(separator: " "))" })
        return lines.joined(separator: "\n")
      }).resolved()
    }
  }
}
