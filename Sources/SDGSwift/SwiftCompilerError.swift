/*
 SwiftCompilerError.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGLocalization
import SDGExternalProcess

import SDGSwiftLocalizations

extension SwiftCompiler {

    /// An error encountered while using Swift.
    public enum Error : PresentableError {

        // MARK: - Cases

        /// The required version of Swift is unavailable.
        case unavailable

        // MARK: - PresentableError

        public func presentableDescription() -> StrictString {
            switch self {
            case .unavailable:
                var details: String = "\n"
                details += SwiftCompiler.searchLocations(searchOrder: false).map({ $0.path.replacingOccurrences(of: NSHomeDirectory(), with: "~") }).joined(separator: "\n")

                return UserFacing<StrictString, InterfaceLocalization>({ localization in
                    switch localization {
                    case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                        return ([
                            StrictString("Swift \(SwiftCompiler.versions.lowerBound.string()) could not be located."),
                            "Make sure it is installed at one of the following paths or register it in $PATH so it can be located with “which”."
                            ] as [StrictString]).joined(separator: "\n") + StrictString(details)
                    }
                }).resolved()
            }
        }
    }
}
