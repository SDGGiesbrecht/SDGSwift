/*
 GitLocationError.swift

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

extension Git {

    /// An error encountered while locating Git.
    public enum LocationError : PresentableError {

        // MARK: - Cases

        /// No compatible version of Git could be located.
        case unavailable

        // MARK: - PresentableError

        public func presentableDescription() -> StrictString {
            switch self {
            case .unavailable:
                let commands: [StrictString] = Git.searchCommands
                    .map({ "$ \($0.joined(separator: " "))" })

                return UserFacing<StrictString, InterfaceLocalization>({ localization in
                    switch localization {
                    case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                        return (([
                            "No compatible version of Git could be located. (\(Git.compatibleVersionRange.inInequalityNotation({ StrictString($0.string()) })))",
                            "Make sure it is installed and can be found with one of the following commands:",
                            ] as [StrictString]) + commands).joined(separator: "\n")
                    }
                }).resolved()
            }
        }
    }
}
