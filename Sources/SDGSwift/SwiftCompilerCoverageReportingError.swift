/*
 SwiftCompilerCoverageReportingError.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(WASI)  // #workaround(workspace version 0.32.1, Web lacks Foundation.)
  import SDGText
  import SDGLocalization

  import SDGSwiftLocalizations

  extension SwiftCompiler {

    /// An error encountered while checking test coverage.
    public enum CoverageReportingError: PresentableError {

      // MARK: - Cases

      /// Swift encountered an error.
      case swiftError(VersionedExternalProcessExecutionError<SwiftCompiler>)

      /// Foundation encountered an error.
      case foundationError(Swift.Error)

      /// The test coverage report could not be parsed.
      case corruptTestCoverageReport

      // MARK: - PresentableError

      public func presentableDescription() -> StrictString {
        switch self {
        case .swiftError(let error):
          return error.presentableDescription()
        case .foundationError(let error):
          return StrictString(error.localizedDescription)
        case .corruptTestCoverageReport:
          return UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
              return "The test coverage report could not be parsed."
            case .deutschDeutschland:
              return "Die Testabdeckungsergebnisse konnten nicht zerteilt werden."
            }
          }).resolved()
        }
      }
    }
  }
#endif
