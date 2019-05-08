/*
 SwiftCompilerCoverageReportingError.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLocalization

import SDGSwift
import SDGSwiftLocalizations

extension SwiftCompiler {

    /// An error encountered while using Swift.
    public enum CoverageReportingError : PresentableError {

        // MARK: - Cases

        /// The package manager encountered an error.
        case packageManagerError(Swift.Error)

        /// Foundation encountered an error.
        case foundationError(Swift.Error)

        /// The test coverage report could not be parsed.
        case corruptTestCoverageReport

        // MARK: - PresentableError

        public func presentableDescription() -> StrictString {
            switch self {
            case .packageManagerError(let error),
                 .foundationError(let error):
                return StrictString(error.localizedDescription)
            case .corruptTestCoverageReport:
                return UserFacing<StrictString, InterfaceLocalization>({ localization in
                    switch localization {
                    case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                        return "The test coverage report could not be parsed."
                    }
                }).resolved()
            }
        }
    }
}
