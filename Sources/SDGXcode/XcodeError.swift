/*
 XcodeError.swift

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

extension Xcode {

    /// An error encountered while using Xcode.
    public enum Error : PresentableError {

        // MARK: - Cases

        /// The required version of Xcode is unavailable.
        case unavailable

        // MARK: - PresentableError

        // [_Inherit Documentation: SDGCornerstone.PresentableError.presentableDescription()_]
        /// Returns a localized description of the error.
        public func presentableDescription() -> StrictString {
            switch self {
            case .unavailable:
                var details: String = "\n"
                details += Xcode.standardLocations.map({ $0.path.replacingOccurrences(of: NSHomeDirectory(), with: "~") }).joined(separator: "\n")

                return UserFacing<StrictString, InterfaceLocalization>({ localization in
                    switch localization {
                    case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                        return ([
                            StrictString("Xcode \(Xcode.version) could not be located."),
                            "Make sure it (xcodebuild) is installed at one of the following paths or register it with the default shell so it can be located with “which”."
                            ] as [StrictString]).joined(separator: "\n") + StrictString(details)
                    }
                }).resolved()
            }
        }
    }
}
