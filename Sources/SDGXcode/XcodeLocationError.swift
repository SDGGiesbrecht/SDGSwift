/*
 XcodeLocationError.swift

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

    /// An error encountered while locating Xcode.
    public enum LocationError : PresentableError {

        /// No compatible version of Xcode could be located.
        case unavailable

        // MARK: - PresentableError

        public func presentableDescription() -> StrictString {
            switch self {
            case .unavailable:
                let commands: [StrictString] = Xcode.searchCommands
                    .map({ "$ \($0.joined(separator: " "))" })

                return UserFacing<StrictString, InterfaceLocalization>({ localization in
                    var lines: [StrictString]
                    let range: StrictString
                    switch localization {
                    case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
                         .deutschDeutschland:
                        range = Xcode.compatibleVersionRange.inInequalityNotation({ StrictString($0.string()) })
                    }
                    switch localization {
                    case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                        lines = [
                            "No compatible version of Xcode could be located. (\(range))",
                            "It must be installed and locatable with one of the following commands:",
                        ]
                    case .deutschDeutschland:
                        lines = [
                            "Keine passende Version von Xcode wurde gefunden. (\(range))",
                            "Es muss installiert und unter einem der folgenden Befehle vorhanden sein:",
                        ]
                    }
                    lines += Xcode.searchCommands
                        .map({ "$ \($0.joined(separator: " "))" })
                    return lines.joined(separator: "\n")
                }).resolved()
            }
        }
    }
}
