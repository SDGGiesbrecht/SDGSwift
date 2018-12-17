/*
 PackageError.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLocalization

import SDGSwiftLocalizations

extension Package {

    /// An error that occurs while trying to use a remote package.
    public enum Error : PresentableError {

        // MARK: - Cases

        /// The package did not produce an executable with any of the requested names.
        case noSuchExecutable(requested: Set<StrictString>)

        // MARK: - PresentableError

        // #documentation(SDGCornerstone.PresentableError.presentableDescription())
        /// Returns a localized description of the error.
        public func presentableDescription() -> StrictString {
            switch self {
            case .noSuchExecutable(requested: let requested):
                var details: StrictString = "\n"
                details += StrictString(requested.sorted().joined(separator: "\n".scalars))

                return UserFacing<StrictString, InterfaceLocalization>({ localization in
                    switch localization {
                    case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                        return "The package did not produce an executable with any of the requested names:" + StrictString(details)
                    }
                }).resolved()
            }
        }
    }
}
