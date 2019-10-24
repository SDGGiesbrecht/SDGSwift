/*
 XcodeSchemeError.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText
import SDGLocalization

import SDGSwiftLocalizations

extension Xcode {

    /// An error encountered while loading the Xcode scheme.
    public enum SchemeError : PresentableError {

        // MARK: - Cases

        /// Foundation encountered an error.
        case foundationError(Swift.Error)

        /// Xcode encountered an error.
        case xcodeError(Xcode.Error)

        /// The Xcode project has no package scheme.
        case noPackageScheme

        // MARK: - PresentableError

        // #workaround(workspace version 0.23.1, Avoids parser crash.)
        /// Returns a localized description of the error.
        public func presentableDescription() -> StrictString {
            switch self {
            case .foundationError(let error):
                return StrictString(error.localizedDescription)
            case .xcodeError(let error):
                return error.presentableDescription()
            case .noPackageScheme:
                return UserFacing<StrictString, InterfaceLocalization>({ localization in
                    switch localization {
                    case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                        return "The Xcode project has no package scheme."
                    case .deutschDeutschland:
                        return "Das Xcode‐Projekt hat kein Paketenschema."
                    }
                }).resolved()
            }
        }
    }
}
