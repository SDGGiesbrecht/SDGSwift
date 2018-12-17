/*
 ConfigurationError.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGSwiftLocalizations

extension Configuration {

    /// An error encountered while loading a configuration.
    public enum Error : PresentableError {

        // MARK: - Cases

        /// The configuration is empty.
        case emptyConfiguration

        /// The configuration is corrupt.
        case corruptConfiguration

        // MARK: - PresentableError

        // #documentation(SDGCornerstone.PresentableError.presentableDescription())
        /// Returns a localized description of the error.
        public func presentableDescription() -> StrictString {
            switch self {
            case .emptyConfiguration:
                return UserFacing<StrictString, InterfaceLocalization>({ localization in
                    switch localization {
                    case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                        return "The configuration is empty."
                    }
                }).resolved()
            case .corruptConfiguration:
                return UserFacing<StrictString, InterfaceLocalization>({ localization in
                    switch localization {
                    case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                        return "The configuration is corrupt."
                    }
                }).resolved()
            }
        }
    }
}
