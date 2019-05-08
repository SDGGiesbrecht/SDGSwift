/*
 BuildDirectoryError.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLocalization

import SDGSwiftLocalizations

extension Xcode {

    /// An error encountered while searching for Xcode’s build directory.
    public enum BuildDirectoryError : PresentableError {

        // MARK: - Cases

        /// The Xcode scheme could not be loaded.
        case schemeError(SchemeError)

        /// The build directory could not be found in the project build settings.
        case noBuildDirectory

        // MARK: - PresentableError

        public func presentableDescription() -> StrictString {
            switch self {
            case .schemeError(let error):
                return error.presentableDescription()
            case .noBuildDirectory:
                return UserFacing<StrictString, InterfaceLocalization>({ localization in
                    switch localization {
                    case .englishUnitedKingdom:
                        return "‘BUILD_DIR’ could not be found in the project build settings."
                    case .englishUnitedStates, .englishCanada:
                        return "“BUILD_DIR” could not be found in the project build settings."
                    }
                }).resolved()
            }
        }
    }
}
