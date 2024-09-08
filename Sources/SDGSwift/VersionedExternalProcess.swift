/*
 VersionedExternalProcess.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow
import SDGCollections
import SDGText
import SDGLocalization
import SDGExternalProcess
import SDGVersioning

/// An externally installed process, with varying capabilities dependening on the version(s) available.
public protocol VersionedExternalProcess {

  /// The English name of the process.
  static var englishName: StrictString { get }
  /// Der deutsche Name des Prozesses im Dativ.
  static var deutscherNameInDativ: StrictString { get }

  /// The name of the command for use with `which`.
  static var commandName: String { get }

  /// The shell commands used to locate the process.
  ///
  /// These commands are in order from most standard to least standard install method and they will be recommended in this order in error messages. However, since more unorthodox installs are likely to masquerade for more standard ones in incomplete ways, the commands will be used in reverse order when actually searching for the process.
  static var searchCommands: [[String]] { get }

  /// The command to run to query the version.
  static var versionQuery: [String] { get }
}

private var locationCache:
  [ObjectIdentifier: [ObjectIdentifier: [Version: [Version: Result<ExternalProcess, Error>]]]] =
    [:]

extension VersionedExternalProcess {

  // MARK: - Locating

  private static subscript<Constraints>(
    versionConstraints: Constraints
  ) -> Result<ExternalProcess, VersionedExternalProcessLocationError<Self>>?
  where Constraints: RangeFamily, Constraints.Bound == Version {
    get {
      let result = locationCache[ObjectIdentifier(self)]?[ObjectIdentifier(Constraints.self)]?[
        versionConstraints.lowerBound
      ]?[versionConstraints.upperBound]
      return result?.mapError { $0 as! VersionedExternalProcessLocationError<Self> }
    }
    set {
      let converted = newValue?.mapError { $0 as Error }
      locationCache[ObjectIdentifier(self), default: [:]][
        ObjectIdentifier(Constraints.self),
        default: [:]
      ][
        versionConstraints.lowerBound,
        default: [:]
      ][versionConstraints.upperBound] = converted
    }
  }

  private static func tool<Constraints>(
    versionConstraints: Constraints
  ) -> Result<ExternalProcess, VersionedExternalProcessLocationError<Self>>
  where Constraints: RangeFamily, Constraints.Bound == Version {

    return cached(in: &self[versionConstraints]) {

      let searchLocations = searchCommands.lazy.reversed().lazy.compactMap { (command) -> URL? in
        #if PLATFORM_LACKS_FOUNDATION_PROCESS  // @exempt(from: tests) Unreachable.
          return nil
        #else
          guard let output = try? Shell.default.run(command: command).get() else {
            return nil
          }
          // @exempt(from: tests) Unreachable on CentOS.
          return URL(parsingOutput: output)
        #endif
      }

      func validate(
        _ process: ExternalProcess
      ) -> Bool {
        // @exempt(from: tests) Unreachable?
        #if PLATFORM_LACKS_FOUNDATION_PROCESS
          return false  // Cannot ensure version matches.
        #else
          // Make sure version is compatible.
          guard let output = try? process.run(versionQuery).get(),
            let version = Version(inVersionQueryOutput: output, of: commandName)
          else {
            return false  // @exempt(from: test)
            // Would require corrupt tools to be present during tests.
          }
          return versionConstraints.contains(version)
        #endif
      }

      if let found = ExternalProcess(
        searching: searchLocations,
        commandName: commandName,
        validate: validate
      ) {
        return .success(found)  // @exempt(from: tests) Unreachable on tvOS.
      } else {

        // #workaround(Swift 5.7, Shell misbehaves on Windows; this tries hard‐coded paths as a fallback.)
        #if os(Windows)
          var hardCoded: [URL] = []
          if Self.self == Git.self {
            hardCoded.append(URL(fileURLWithPath: #"C:\Program Files\Git\bin\git.exe"#))
          }
          if let found = ExternalProcess(
            searching: hardCoded,
            commandName: commandName,
            validate: validate
          ) {
            return .success(found)
          }
        #endif

        return .failure(
          .unavailable(
            versionConstraints: versionConstraints.inInequalityNotation({
              StrictString($0.string())
            })
          )
        )
      }
    }
  }

  // MARK: - Usage

  /// Returns the location of the process.
  ///
  /// - Parameters:
  ///   - versionConstraints: The acceptable range of versions.
  public static func location<Constraints>(
    versionConstraints: Constraints
  ) -> Result<URL, VersionedExternalProcessLocationError<Self>>
  where Constraints: RangeFamily, Constraints.Bound == Version {
    return tool(versionConstraints: versionConstraints)
      .map { process in
        // @exempt(from: tests) Unreachable on tvOS.
        return process.executable
      }
  }

  #if !PLATFORM_LACKS_FOUNDATION_PROCESS
    /// Runs a custom subcommand.
    ///
    /// - Parameters:
    ///   - arguments: The arguments (leave the process name off the beginning).
    ///   - workingDirectory: Optional. A different working directory.
    ///   - environment: Optional. A different set of environment variables.
    ///   - versionConstraints: The acceptable range of versions.
    ///   - ignoreStandardError: Optional. If `true`, standard error will be excluded from the output. The default is `false`.
    ///   - reportProgress: Optional. A closure to execute for each line of output.
    @discardableResult public static func runCustomSubcommand<Constraints>(
      _ arguments: [String],
      in workingDirectory: URL? = nil,
      with environment: [String: String]? = nil,
      versionConstraints: Constraints,
      ignoreStandardError: Bool = false,
      reportProgress: (_ progressReport: String) -> Void = { _ in }
    ) -> Result<String, VersionedExternalProcessExecutionError<Self>>
    where Constraints: RangeFamily, Constraints.Bound == Version {

      var environment = environment ?? ProcessInfo.processInfo.environment
      // Causes issues when run from within Xcode.
      environment["LLVM_PROFILE_FILE"] = nil
      environment["__LLVM_PROFILE_RT_INIT_ONCE"] = nil
      environment["RUN_DESTINATION_DEVICE_NAME"] = nil
      environment["RUN_DESTINATION_DEVICE_PLATFORM_IDENTIFIER"] = nil
      environment["RUN_DESTINATION_DEVICE_UDID"] = nil
      environment["__XCODE_BUILT_PRODUCTS_DIR_PATHS"] = nil
      environment["XCTestBundlePath"] = nil
      environment["XCTestConfigurationFilePath"] = nil
      environment["XCTestSessionIdentifier"] = nil

      reportProgress("$ \(commandName) " + arguments.joined(separator: " "))
      switch tool(versionConstraints: versionConstraints) {
      case .failure(let error):
        return .failure(.locationError(error))
      case .success(let tool):
        switch tool.run(
          arguments,
          in: workingDirectory,
          with: environment,
          ignoreStandardError: ignoreStandardError,
          reportProgress: reportProgress
        ) {
        case .failure(let error):
          return .failure(.executionError(error))
        case .success(let output):
          return .success(output)
        }
      }
    }

    /// Returns the resolved available version that satisfies the provided constraints.
    ///
    /// - Parameters:
    ///   - constraints: The version constraints.
    public static func version<Constraints>(forConstraints constraints: Constraints) -> Version?
    where Constraints: RangeFamily, Constraints.Bound == Version {
      let output = try? runCustomSubcommand(versionQuery, versionConstraints: constraints).get()
      return output.flatMap { output in
        return Version(inVersionQueryOutput: output, of: commandName)
      }
    }
  #endif
}
