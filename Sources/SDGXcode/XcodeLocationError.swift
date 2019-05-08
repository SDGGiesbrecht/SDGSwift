/*
 XcodeLocationError.swift

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

    /// No compatible version of Xcode could be located.
    public struct LocationError : PresentableError {

        // MARK: - PresentableError

        public func presentableDescription() -> StrictString {

            let commands: [StrictString] = Xcode.searchCommands
                .map({ "$ \($0.joined(separator: " "))" })

            return UserFacing<StrictString, InterfaceLocalization>({ localization in
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return (([
                        "No compatible version of Xcode could be located. (\(Xcode.compatibleVersionRange.inInequalityNotation({ StrictString($0.string()) })))",
                        "Make sure it is installed and can be found with one of the following commands:",
                        ] as [StrictString]) + commands).joined(separator: "\n")
                }
            }).resolved()
        }
    }
}
