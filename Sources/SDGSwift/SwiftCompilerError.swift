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

        /// The test coverage report could not be parsed.
        case corruptTestCoverageReport

        // MARK: - PresentableError

        public func presentableDescription() -> StrictString {
            switch self {
            case .unavailable:

                let commands: [StrictString] = SwiftCompiler.searchCommands
                    .map({ "$ \($0.joined(separator: " "))" })

                return UserFacing<StrictString, InterfaceLocalization>({ localization in
                    switch localization {
                    case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                        return (([
                            "Swift \(SwiftCompiler.versions.lowerBound.string()) could not be located.",
                            "Make sure it is installed and can be found with one of the following commands:",
                            ] as [StrictString]) + commands).joined(separator: "\n")
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
