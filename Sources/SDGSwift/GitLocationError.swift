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
                return UserFacing<StrictString, InterfaceLocalization>({ localization in
                    var lines: [StrictString]
                    let range: StrictString
                    switch localization {
                        case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                             .deutschDeutschland:
                        range = Git.compatibleVersionRange.inInequalityNotation({ StrictString($0.string()) })
                    }
                    switch localization {
                    case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                        lines = [
                            "No compatible version of Git could be located. (\(range))",
                            "It must be installed and locatable with one of the following commands:",
                            ]
                    case .deutschDeutschland:
                        lines = [
                            "Keine passende Version von Git wurde gefunden. (\(range))",
                            "Es muss installiert und unter einem der folgenden Befehle vorhanden sein:",
                        ]
                    }
                    lines += Git.searchCommands
                        .map({ "$ \($0.joined(separator: " "))" })
                    return lines.joined(separator: "\n")
                }).resolved()
            }
        }
    }
}
