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

        /// The package has no Xcode project.
        case noXcodeProject

        /// The Xcode project has no package scheme.
        case noPackageScheme

        /// The build directory could not be found in the project build settings.
        case noBuildDirectory

        /// The test coverage report could not be parsed.
        case corruptTestCoverageReport

        // MARK: - PresentableError

        // #workaround(SDGCornerstone 0.10.1, Detatched until available again.)
        // @documentation(SDGCornerstone.PresentableError.presentableDescription())
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
                            StrictString("Xcode \(Xcode.versions.lowerBound.string()) could not be located."),
                            "Make sure it (xcodebuild) is installed at one of the following paths or register it in $PATH so it can be located with “which”."
                            ] as [StrictString]).joined(separator: "\n") + StrictString(details)
                    }
                }).resolved()
            case .noXcodeProject:
                return UserFacing<StrictString, InterfaceLocalization>({ localization in
                    switch localization {
                    case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                        return "The package has no Xcode project."
                    }
                }).resolved()
            case .noPackageScheme:
                return UserFacing<StrictString, InterfaceLocalization>({ localization in
                    switch localization {
                    case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                        return "The Xcode project has no package scheme."
                    }
                }).resolved()
            case .noBuildDirectory:
                return UserFacing<StrictString, InterfaceLocalization>({ localization in
                    switch localization {
                    case .englishUnitedKingdom:
                        return "‘BUILD_DIR’ could not be found in the project build settings."
                    case .englishUnitedStates, .englishCanada:
                        return "“BUILD_DIR” could not be found in the project build settings."
                    }
                }).resolved()
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
