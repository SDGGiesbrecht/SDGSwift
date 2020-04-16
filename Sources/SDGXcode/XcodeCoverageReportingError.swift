/*
 XcodeCoverageReportingError.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(WASI)  // #workaround(Swift 5.2.2, Web lacks Foundation.)
  import SDGText
  import SDGLocalization

  import SDGSwiftLocalizations

  import SDGSwift

  extension Xcode {

    // #workaround(Swift 5.2.2, SwiftPM won’t compile.)
    #if !(os(Windows) || os(Android))
      /// An error encountered while checking test coverage.
      public enum CoverageReportingError: PresentableError {

        // MARK: - Cases

        /// Foundation encountered an error.
        case foundationError(Swift.Error)

        /// Xcode encountered an error.
        case xcodeError(VersionedExternalProcessExecutionError<Xcode>)

        /// The test coverage report could not be parsed.
        case corruptTestCoverageReport

        // MARK: - PresentableError

        public func presentableDescription() -> StrictString {
          switch self {
          case .foundationError(let error):
            return StrictString(error.localizedDescription)
          case .xcodeError(let error):
            return error.presentableDescription()
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
    #endif
  }
#endif
