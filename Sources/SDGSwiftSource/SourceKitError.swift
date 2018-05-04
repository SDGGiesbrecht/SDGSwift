/*
 SourceKitError.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGLocalization

import SDGSwiftLocalizations

extension SourceKit {

    /// An error encountered while using SourceKit.
    public enum Error : PresentableError {

        // MARK: - Cases

        /// The dynamic linker encountered an error.
        case dynamicLinkerError(description: String?)

        // MARK: - Initialization

        internal static func currentDynamicLinkerError() -> SourceKit.Error {
            return .dynamicLinkerError(description: String(validatingUTF8: dlerror()))
        }

        // MARK: - PresentableError

        // [_Inherit Documentation: SDGCornerstone.PresentableError.presentableDescription()_]
        /// Returns a localized description of the error.
        public func presentableDescription() -> StrictString {
            switch self {
            case .dynamicLinkerError(description: let description):
                if let linkerDescription = description {
                    return StrictString(linkerDescription)
                } else {
                    return UserFacing<StrictString, InterfaceLocalization>({ localization in
                        switch localization {
                        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                            return "The dynamic linker encountered an unknown error."
                        }
                    }).resolved()
                }
            }
        }
    }
}
