/*
 VersionedExternalProcess.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow
import SDGCollections
import SDGText
import SDGExternalProcess
import SDGVersioning

/// An externally installed process, with varying capabilities dependening on the version(s) available.
public protocol VersionedExternalProcess {

  /// The English name of the process.
  static var englishName: StrictString { get }
  /// Der deutsche Name des Prozesses im Dativ.
  static var deutscherNameInDativ: StrictString { get }

  #warning("Split this up.")
  associatedtype VersionRange : RangeFamily where VersionRange.Bound == Version
  static var compatibleVersionRange: VersionRange { get }

  /// The name of the command for use with `which`.
  static var commandName: String { get }

  /// The shell commands used to locate the process.
  ///
  /// These commands are in order from most standard to least standard install method and they will be recommended in this order in error messages. However, since more unorthodox installs are likely to masquerade for more standard ones in incomplete ways, the commands will be used in reverse order when actually searching for the process.
  static var searchCommands: [[String]] { get }

  /// The command to run to query the version.
  static var versionQuery: [String] { get }
}

private var locationCache: [ObjectIdentifier: Result<ExternalProcess, Error>] = [:]

extension VersionedExternalProcess {

  // MARK: - Locating

  private static var located: Result<ExternalProcess, VersionedExternalProcessLocationError<Self>>? {
    get {
      let result = locationCache[ObjectIdentifier(self)]
      return result?.mapError { $0 as! VersionedExternalProcessLocationError<Self> }
    }
    set {
      let converted = newValue?.mapError { $0 as Error }
      locationCache[ObjectIdentifier(self)] = converted
    }
  }

  #warning("Make private.")
  public static func tool() -> Result<ExternalProcess, VersionedExternalProcessLocationError<Self>> {
    return cached(in: &located) {

      let searchLocations = searchCommands.lazy.reversed().lazy.compactMap{ (command) -> URL? in
        guard let output = try? Shell.default.run(command: command).get() else {
          return nil
        }
        return URL(fileURLWithPath: output)
      }

      func validate(_ process: ExternalProcess) -> Bool {
        // Make sure version is compatible.
        guard let output = try? process.run(versionQuery).get(),
          let version = Version(firstIn: output) else {
            return false
        }
        return compatibleVersionRange.contains(version)
      }

      if let found = ExternalProcess(searching: searchLocations, commandName: commandName, validate: validate) {
        return .success(found)
      } else {
        return .failure(.unavailable)
      }
    }
  }

  // MARK: - Usage

  /// Returns the location of the process.
  public static func location() -> Result<URL, VersionedExternalProcessLocationError<Self>> {
    return tool().map { $0.executable }
  }
}
